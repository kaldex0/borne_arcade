# Documentation technique

Généré le {{GENERATED_AT}}

## Vue d'ensemble

La borne d'arcade est un menu Java plein écran qui liste automatiquement les jeux présents dans le dossier [projet](../..//projet/). Le menu affiche :
- le nom du jeu (nom du dossier)
- une miniature (photo_small.png)
- une description (description.txt)
- un rappel des commandes (bouton.txt)
- les meilleurs scores (fichier highscore)

Chaque jeu est lancé par un script shell portant le même nom que son dossier : `./<NomDuJeu>.sh`.

## Architecture logicielle

- Menu Java (MG2D) : [Main.java](../../Main.java), [Graphique.java](../../Graphique.java)
- Sélection et lancement : [Pointeur.java](../../Pointeur.java)
- Compilation : [compilation.sh](../../compilation.sh)
- Nettoyage : [clean.sh](../../clean.sh)
- Démarrage automatique : [borne.desktop](../../borne.desktop) ou service systemd (optionnel)

## Arborescence importante

- `projet/` : un dossier par jeu (sources, assets, description)
- `sound/` : sons du menu (bips, musique de fond)
- `img/` et `fonts/` : assets du menu
- `*.sh` : scripts de lancement des jeux

## Format des fichiers de métadonnées d'un jeu

- `description.txt` : jusqu'à 10 lignes (le menu affiche 10 lignes max).
- `bouton.txt` : 1 ligne, 7 éléments séparés par `:`
  - Format : `JOYSTICK:BTN1:BTN2:BTN3:BTN4:BTN5:BTN6`
- `photo_small.png` : miniature affichée dans le menu.
- `highscore` : liste de scores, format géré par [HighScore.java](../../HighScore.java).

## Liste des jeux détectés

{{GAME_LIST}}

## Dépendances

- Java (OpenJDK 11 recommandé)
- MG2D (bibliothèque graphique)
- Outils système : `git`, `x11-xserver-utils`, `lxterminal`

## Compilation

Le script [compilation.sh](../../compilation.sh) compile :
- le menu Java (fichiers `*.java` à la racine)
- tous les jeux Java présents sous `projet/*/`

## Exécution

Le menu est lancé par [lancerBorne.sh](../../lancerBorne.sh) :
- change le layout clavier
- compile
- démarre le menu Java
- lance un arrêt automatique après sortie

## Automatisation (installation et déploiement)

Scripts principaux :
- [scripts/install_borne.sh](../../scripts/install_borne.sh) : installation complète (dépendances, service, hook git)
- [scripts/update_from_git.sh](../../scripts/update_from_git.sh) : `git pull`, recompilation, redémarrage service
- [scripts/install_git_hook.sh](../../scripts/install_git_hook.sh) : installe le hook `post-merge`

Le hook `post-merge` exécute automatiquement `update_from_git.sh` après chaque `git pull`.
