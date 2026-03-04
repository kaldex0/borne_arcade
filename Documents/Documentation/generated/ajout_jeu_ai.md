# Documentation pour l'ajout d'un nouveau jeu

Genere le 2026-03-04 10:26:25

Modele: gemma2:latest

## Documentation pour l'ajout d'un nouveau jeu

###  Principes

Un jeu est dtect automatiquement si:
- Un dossier `projet/<NomDuJeu>/` existe.
- Un script de lancement `./<NomDuJeu>.sh` est prsent dans le rpertoire racine du projet.

Le nom du dossier devient le nom du jeu affich dans le menu.

### Structure minimale d'un jeu

```
projet/<NomDuJeu>/
  description.txt
  bouton.txt
  photo_small.png
  highscore           (optionnel au dpart)
  (sources/ assets/ etc.)
<NomDuJeu>.sh         ( la racine)
```

### Fichiers obligatoires

#### `description.txt`

- Maximum 10 lignes (les lignes supplmentaires sont ignores).
- Exemple :

```
Jeu d'action rapide
vitez les obstacles
Collectez des bonus
...
```

#### `bouton.txt`

- Une seule ligne.
- 7 lments spars par `:`.
- Format :

```
JOYSTICK:BTN1:BTN2:BTN3:BTN4:BTN5:BTN6
```

Exemple :

```
MOVE:SHOT:POWER:PAUSE:START:BACK:MENU
```

#### `photo_small.png`

- Miniature affiche dans le menu.

### Script de lancement

Crer `/<NomDuJeu>.sh`  la racine du projet.

Exemple Java :

```bash
#!/bin/bash
cd projet/<NomDuJeu>
java -cp .:../..:${MG2D_PATH} Main
```

Si `MG2D_PATH` n'est pas dfini, placez MG2D  ct du repo : `../MG2D`.

Exemple rel ajout : `StarDodger` (jeu d'esquive avec boost) :
- Dossier : `projet/StarDodger/`
- Script : `StarDodger.sh`
- Commande boost : bouton A (J1)

Exemple Python ajout : `NebulaRun` :
- Dossier : `projet/NebulaRun/`
- Script : `NebulaRun.sh`

Exemple Python :

```bash
#!/bin/bash
cd projet/<NomDuJeu>
python3 NebulaRun.py
```


Rendre le script excutable : `chmod +x <NomDuJeu>.sh`.

### Validation

Aprs ajout d'un nouveau jeu, valider les scripts de lancement par jeu avec `scripts/validate_launchers.sh`.

##  Informations manquantes

-  La documentation ne mentionne pas comment installer MG2D ni les spcificits des jeux Python ou LOVE2D.
- Il manque galement un paragraphe sur la contribution au projet, le dpt des jeux, etc.
