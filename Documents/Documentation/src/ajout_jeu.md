# Documentation pour l'ajout d'un nouveau jeu

Généré le {{GENERATED_AT}}

## Principe

Un jeu est détecté automatiquement s'il existe :
- un dossier `projet/<NomDuJeu>/`
- un script de lancement `./<NomDuJeu>.sh`

Le nom du dossier = nom du jeu dans le menu.

## Structure minimale d'un jeu

```
projet/<NomDuJeu>/
  description.txt
  bouton.txt
  photo_small.png
  highscore           (optionnel au départ)
  (sources/ assets/ etc.)
<NomDuJeu>.sh         (à la racine)
```

## Fichiers obligatoires

### description.txt
- 10 lignes max (les lignes supplémentaires sont ignorées)
- Exemple :

```
Jeu d'action rapide
Évitez les obstacles
Collectez des bonus
...
```

### bouton.txt
- 1 seule ligne
- 7 éléments séparés par `:`
- Format :

```
JOYSTICK:BTN1:BTN2:BTN3:BTN4:BTN5:BTN6
```

Exemple :

```
MOVE:SHOT:POWER:PAUSE:START:BACK:MENU
```

### photo_small.png
- miniature affichée dans le menu

## Script de lancement

Créer `/<NomDuJeu>.sh` à la racine du projet.

Exemple Java :

```
#!/bin/bash
cd projet/<NomDuJeu>
java -cp .:../..:${MG2D_PATH} Main
```

Si `MG2D_PATH` n'est pas défini, placez MG2D à côté du repo : `../MG2D`.

Exemple réel ajouté : `StarDodger` (jeu d'esquive avec boost) :
- Dossier : `projet/StarDodger/`
- Script : `StarDodger.sh`
- Commande boost : bouton A (J1)

Exemple Python :

```
#!/bin/bash
cd projet/<NomDuJeu>
python3 main.py
```

Rendre le script exécutable :

```
chmod +x <NomDuJeu>.sh
```

## Compilation

Le script [compilation.sh](../../compilation.sh) compile tous les fichiers `*.java` présents dans `projet/*/`.
Si votre jeu n'est pas Java, assurez-vous que son script de lancement gère l'exécution.

## Vérifications

- Le jeu apparaît dans le menu
- La description s’affiche
- Les boutons s’affichent
- La miniature s’affiche
- Le jeu se lance et revient au menu en quittant

## Liste des jeux détectés

{{GAME_LIST}}
