# Documentation technique

Genere le 2026-03-04 10:21:04

Modele: gemma2:latest

## Documentation technique

**Date:** 2026-03-04

### Vue d'ensemble

La borne d'arcade est un menu Java plein cran qui liste automatiquement les jeux prsents dans le dossier `projet/`. Le menu affiche :

* le nom du jeu (nom du dossier)
* une miniature (photo_small.png)
* une description (description.txt)
* un rappel des commandes (bouton.txt)
* les meilleurs scores (fichier highscore)

Chaque jeu est lanc par un script shell portant le mme nom que son dossier : `./<NomDuJeu>.sh`.

### Architecture logicielle

* Menu Java (MG2D) : [Main.java](../../Main.java), [Graphique.java](../../Graphique.java)
* Slection et lancement : [Pointeur.java](../../Pointeur.java)
* Compilation : [compilation.sh](../../compilation.sh)
* Nettoyage : [clean.sh](../../clean.sh)
* Dmarrage automatique : [borne.desktop](../../borne.desktop) ou service systemd (optionnel)

### Arborescence importante

* `projet/` : un dossier par jeu (sources, assets, description)
* `sound/` : sons du menu (bips, musique de fond)
* `img/` et `fonts/` : assets du menu
* `*.sh` : scripts de lancement des jeux

### Format des fichiers de mtadonnes d'un jeu

* `description.txt` : jusqu' 10 lignes (le menu affiche 10 lignes max).
* `bouton.txt` : 1 ligne, 7 lments spars par `:`
    - Format : `JOYSTICK:BTN1:BTN2:BTN3:BTN4:BTN5:BTN6`
* `photo_small.png` : miniature affiche dans le menu.
* `highscore` : liste de scores, format gr par [HighScore.java](../../HighScore.java).

### Liste des jeux dtects

{{GAME_LIST}}

### Dpendances

* Java (OpenJDK 11 recommand)
* MG2D (bibliothque graphique)
    - emplacement par dfaut : `../MG2D` (voisin du repo)
    - ou variable d'environnement `MG2D_PATH`
* Jeux Python : `python3`, `python3-pygame`
* Outils systme : `git`, `x11-xserver-utils`, `lxterminal`, `xdotool`
* Optionnel : `love` (LOVE2D pour CursedWare)

### Compilation

Le script [compilation.sh](../../compilation.sh) compile :
* le menu Java (fichiers `*.java`  la racine)
* tous les jeux Java prsents sous `projet/*/`

### Excution

Le menu est lanc par [lancerBorne.sh](../../lancerBorne.sh) :
* change le layout clavier
* compile
* dmarre le menu Java
* lance un arrt automatique aprs sortie

### Automatisation (installation et dploiement)

Scripts principaux :
* [scripts/install_borne.sh](../../scripts/install_borne.sh) : installation complte (dpendances, service, hook git)
* [scripts/update_from_git.sh](../../scripts/update_from_git.sh) : `git pull`, recompilation, redmarrage service
* [scripts/install_git_hook.sh](../../scripts/install_git_hook.sh) : installe le hook `post-merge`

Le hook `post-merge` excute automatiquement `update_from_git.sh` aprs chaque `git pull`.

### Validation rapide

Scripts disponibles :
* `scripts/validate_dependencies.sh` : vrifie les outils requis
* `scripts/validate_assets.sh` : vrifie les fichiers requis par jeu
* `scripts/validate_launchers.sh` : vrifie les scripts de lancement par jeu
* `scripts/validate_all.sh` : excute les deux
