#!/usr/bin/env python3
"""AI automation using the IUT Ollama wrapper.

Generates a progress report and doc updates based on existing sources.
"""
from __future__ import annotations

import argparse
import os
from datetime import datetime
from pathlib import Path
from typing import List

from ollama_wrapper_iut import (
    OllamaWrapper,
    OllamaConnectionError,
    OllamaResponseError,
    OllamaServerStartError,
)


REPO_ROOT = Path(__file__).resolve().parents[1]
DOCS_ROOT = REPO_ROOT / "Documents" / "Documentation"
SRC_DIR = DOCS_ROOT / "src"
OUT_DIR = DOCS_ROOT / "generated"

DEFAULT_MODEL = os.getenv("OLLAMA_MODEL", "gemma2:latest")
DEFAULT_BASE_URL = os.getenv("OLLAMA_BASE_URL", "http://10.22.28.190:11434")


def _read_text(path: Path, max_chars: int = 40000) -> str:
    if not path.exists():
        return f"[Missing file: {path}]"
    text = path.read_text(encoding="utf-8", errors="replace")
    if len(text) > max_chars:
        return text[:max_chars] + "\n[...truncated...]"
    return text


def _to_ascii(text: str) -> str:
    return text.encode("ascii", errors="ignore").decode("ascii")


def _collect_sources() -> List[str]:
    sources: List[str] = []

    doc_min = DOCS_ROOT / "doc_minimale.md"
    sources.append(f"## doc_minimale.md\n{_read_text(doc_min)}")

    for src in sorted(SRC_DIR.glob("*.md")):
        sources.append(f"## {src.name}\n{_read_text(src)}")

    return sources


def _build_prompt(sources: List[str]) -> str:
    today = datetime.now().strftime("%Y-%m-%d")
    header = (
        "Tu es un assistant qui produit un rapport d'avancement et une synthese de documentation.\n"
        "Utilise uniquement les informations fournies ci-dessous.\n"
        "Si une information manque, indique-le clairement au lieu d'inventer.\n"
        "Ecris en ASCII uniquement.\n"
        f"Date: {today}\n"
    )
    tasks = (
        "Taches attendues:\n"
        "1) Resume des automations mises en place (doc, install, deploiement).\n"
        "2) Etat d'avancement par item de la mission.\n"
        "3) Actions restantes claires et courtes.\n"
        "4) Risques / points d'attention (dependances, tests).\n"
        "Format: Markdown concis avec titres et listes.\n"
    )
    body = "\n\n".join(sources)
    return f"{header}\n{tasks}\nSources:\n{body}"


def generate_report(client: OllamaWrapper) -> Path:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    out_path = OUT_DIR / "ia_rapport.md"

    sources = _collect_sources()
    prompt = _build_prompt(sources)
    result = client.generate_text(model=DEFAULT_MODEL, prompt=prompt)

    header = (
        f"# Rapport d'avancement (IA)\n\n"
        f"Genere le {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"
        f"Modele: {DEFAULT_MODEL}\n\n"
    )

    out_path.write_text(header + _to_ascii(result.response.strip()) + "\n", encoding="utf-8")
    return out_path


def _build_doc_prompt(doc_kind: str, sources: List[str]) -> str:
    today = datetime.now().strftime("%Y-%m-%d")
    header = (
        "Tu es un assistant qui re-ecrit une documentation claire et concise.\n"
        "Utilise uniquement les informations fournies ci-dessous.\n"
        "Si une information manque, indique-le clairement au lieu d'inventer.\n"
        "Ecris en ASCII uniquement.\n"
        f"Date: {today}\n"
    )
    tasks = (
        f"Document cible: {doc_kind}\n"
        "Format: Markdown concis avec titres, listes, et etapes.\n"
    )
    body = "\n\n".join(sources)
    return f"{header}\n{tasks}\nSources:\n{body}"


def generate_docs(client: OllamaWrapper) -> List[Path]:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    sources = _collect_sources()
    outputs: List[Path] = []

    doc_map = {
        "Documentation technique": "technical_ai.md",
        "Documentation d'installation": "installation_ai.md",
        "Documentation pour l'ajout d'un nouveau jeu": "ajout_jeu_ai.md",
        "Documentation utilisateur": "utilisateur_ai.md",
    }

    for label, filename in doc_map.items():
        prompt = _build_doc_prompt(label, sources)
        result = client.generate_text(model=DEFAULT_MODEL, prompt=prompt)
        out_path = OUT_DIR / filename
        header = (
            f"# {label}\n\n"
            f"Genere le {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"
            f"Modele: {DEFAULT_MODEL}\n\n"
        )
        out_path.write_text(header + _to_ascii(result.response.strip()) + "\n", encoding="utf-8")
        outputs.append(out_path)

    return outputs


def main() -> int:
    parser = argparse.ArgumentParser(description="IA automation via Ollama.")
    parser.add_argument("--report", action="store_true", help="Generate progress report.")
    parser.add_argument("--docs", action="store_true", help="Generate documentation set.")
    parser.add_argument("--all", action="store_true", help="Generate docs + report.")
    args = parser.parse_args()

    do_report = args.report or args.all
    do_docs = args.docs or args.all
    if not do_report and not do_docs:
        do_report = True

    client = OllamaWrapper(base_url=DEFAULT_BASE_URL)
    if not client.is_server_running():
        print(f"Ollama indisponible a {DEFAULT_BASE_URL}.")
        return 2

    try:
        if do_docs:
            outputs = generate_docs(client)
            for path in outputs:
                print(f"Doc generee: {path}")

        if do_report:
            out_path = generate_report(client)
            print(f"Rapport genere: {out_path}")
    except (OllamaConnectionError, OllamaResponseError, OllamaServerStartError) as exc:
        print(f"Erreur Ollama: {exc}")
        return 2
    except Exception as exc:
        print(f"Erreur: {exc}")
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
