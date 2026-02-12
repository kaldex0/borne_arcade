# How-to : creer et deployer un nouveau jeu

Généré le {{GENERATED_AT}}

## Objectif

Ajouter un jeu, le rendre visible dans le menu et le deployer via git.

## Etapes

1. Creer le dossier du jeu :

```
mkdir -p projet/NomDuJeu
```

2. Ajouter les fichiers requis :

- `description.txt`
- `bouton.txt`
- `photo_small.png`
- `highscore` (optionnel)

3. Creer le script de lancement a la racine :

```
./NomDuJeu.sh
```

4. Tester localement :

```
./NomDuJeu.sh
```

5. Generer la doc et valider :

```
./scripts/generate_docs.sh
./scripts/validate_all.sh
```

6. Commit + push, puis pull sur la borne :

```
git add .
git commit -m "Add NomDuJeu"
git push
```

Sur la borne :

```
cd ~/borne_arcade
git pull
```

## Verification

- Le jeu apparait dans le menu
- La description et les boutons s'affichent
- Le jeu se lance correctement
