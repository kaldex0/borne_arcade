# Rapport d'avancement SAE - Borne Arcade

## Objectifs et etat

1) Automatiser la generation de la documentation
- Fait: scripts/generate_docs.sh et scripts/generate_docs.ps1
- Docs sources dans Documents/Documentation/src
- Generation dans Documents/Documentation/generated

2) Test de la procedure sur la borne
- Partiel: tests realises en VM
- A finaliser: validation complete sur la borne physique (IUT)

3) Montee de version Raspberry Pi OS et bibliotheques
- Fait: scripts/setup_rpi_os.sh (Bullseye)
- Dependance optionnelle LOVE2D mentionnee
- A verifier: compatibilite MG2D et jeux sur OS cible

4) Automatisation de l'installation
- Fait: scripts/install_borne.sh
- Installe dependances, layout clavier, systemd, hook git

5) Automatisation du deploiement via git
- Fait: scripts/install_git_hook.sh + scripts/update_from_git.sh
- Hook post-merge pour appliquer les mises a jour apres git pull

6) Ajout d'un nouveau jeu
- Fait: NebulaRun
- Dossier: projet/NebulaRun
- Script: NebulaRun.sh

7) Tests necessaires
- Fait: scripts/validate_dependencies.sh
- Fait: scripts/validate_assets.sh
- Fait: scripts/validate_launchers.sh
- Fait: scripts/validate_all.sh
- A renforcer: tests de lancement complets sur la borne

## Points d'attention

- MG2D doit etre present et compile a cote du repo ou via MG2D_PATH.
- LOVE2D (CursedWare) depend de la version et de l'architecture.
- Certains jeux Python requierent pygame (python3-pygame).

## Prochaines actions

- Validation finale sur la borne physique (IUT): installation + lancement menu + jeux.
- Verification des dependances optionnelles (LOVE2D, audio, etc.).
- Mettre a jour INDEX.md si necessaire.
