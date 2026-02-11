# Documentation d'installation

Généré le {{GENERATED_AT}}

## Prérequis matériels

- Raspberry Pi 3 Model B (recommandé)
- Écran 4:3 (1280x1024 conseillé)
- Joystick + 6 boutons par joueur

## Système d'exploitation

- Raspberry Pi OS 32-bit (Legacy/Bullseye recommandé pour compatibilité)

## Installation rapide (sur Raspberry Pi OS)

1. Mettre à jour le système :

```
sudo apt-get update
sudo apt-get full-upgrade -y
```

2. Installer les dépendances principales :

```
sudo apt-get install -y git rsync unzip openjdk-11-jdk x11-xserver-utils lxterminal alsa-utils pulseaudio
```

3. Cloner les dépôts :

```
mkdir -p ~/git
cd ~/git
# MG2D (si accessible)
# git clone <URL_MG2D>
# Borne arcade
# git clone <URL_BORNE_ARCADE>
```

4. Vérifier l’arborescence :

```
~/git/
  MG2D/
  borne_arcade/
```

5. Vérifier MG2D :

- Placez MG2D à côté du dépôt `borne_arcade` :

```
~/git/
  MG2D/
  borne_arcade/
```

- Ou définir une variable d'environnement avant lancement :

```
export MG2D_PATH=/chemin/vers/MG2D
```

6. Lancer une fois manuellement :

```
cd ~/git/borne_arcade
./lancerBorne.sh
```

## Démarrage automatique

Option A – Autostart LXDE

```
mkdir -p ~/.config/autostart
cp ~/git/borne_arcade/borne.desktop ~/.config/autostart/
```

Option B – Systemd (recommandé)

```
sudo ~/git/borne_arcade/scripts/install_systemd.sh
```

## Automatisation de l'installation

Une installation complète (dépendances, service systemd, hook git, compilation) :

```
sudo ~/git/borne_arcade/scripts/install_borne.sh
```

## Déploiement automatique via git

Après installation du hook, chaque `git pull` déclenche :
- recompilation
- redémarrage du service

Installation du hook :

```
sudo ~/git/borne_arcade/scripts/install_git_hook.sh
```

## Mise à jour des dépendances

- Java recommandé : OpenJDK 11
- Si migration vers Bookworm, valider tous les jeux un par un
