# Presentation - Automatisations de la borne d'arcade

## Objectif

Montrer ce qui a ete automatise et comment, avec un parcours clair des scripts et de l'integration.

## Automatisation 1 - Generation de documentation

- Script: scripts/generate_docs.sh (Linux) et scripts/generate_docs.ps1 (Windows)
- Sources: Documents/Documentation/src
- Sorties: Documents/Documentation/generated
- Fonctionnement: remplace {{GENERATED_AT}} et produit la liste des jeux via {{GAME_LIST}}

## Automatisation 2 - Installation complete sur la borne

- Script: scripts/install_borne.sh
- Actions:
  - installation des dependances (via scripts/setup_rpi_os.sh)
  - installation du layout clavier borne
  - installation systemd (autostart)
  - installation du hook git post-merge
  - compilation initiale

## Automatisation 3 - Deploiement via git (post-pull)

- Script: scripts/install_git_hook.sh
- Script: scripts/update_from_git.sh
- Hook: .git/hooks/post-merge
- Effet: apres un git pull, recompilation + redemarrage du service

## Automatisation 4 - Validation rapide

- scripts/validate_dependencies.sh: verifie les outils requis
- scripts/validate_assets.sh: verifie les fichiers obligatoires par jeu
- scripts/validate_launchers.sh: verifie les scripts de lancement
- scripts/validate_all.sh: lance tout

## Automatisation 5 - IA pour documentation et rapport (Ollama)

- Script: scripts/ai_automation.py
- Utilise: ollama_wrapper_iut.py
- Genere:
  - documentation IA: technical_ai.md, installation_ai.md, ajout_jeu_ai.md, utilisateur_ai.md
  - rapport d'avancement IA: ia_rapport.md
- Lancement:
  - python3 scripts/ai_automation.py --all
  - ou OLLAMA_RUN=1 scripts/generate_docs.sh

## Exemples d'execution

- Generation doc:
  - scripts/generate_docs.sh
- Installation complete:
  - sudo scripts/install_borne.sh
- Deploiement automatique:
  - git pull (hook post-merge)
- Validation:
  - scripts/validate_all.sh

## Conclusion

L'ensemble des automatisations reduit les actions manuelles a l'installation initiale et au git pull, avec des controles de coherences et une documentation toujours a jour.

