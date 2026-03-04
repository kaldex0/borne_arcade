# Documentation d'installation

Genere le 2026-03-04 10:23:56

Modele: gemma2:latest

## Documentation d'installation

**Date:** 2026-03-04

Ce document explique comment installer la borne d'arcade sur un Raspberry Pi 3.


### Prrequis matriels

* Raspberry Pi 3 Model B (recommand)
* cran 4:3 (1280x1024 conseill)
* Joystick + 6 boutons par joueur


### Systme d'exploitation

* Raspberry Pi OS 32-bit (Legacy/Bullseye recommand pour compatibilit, RPi 3 B+)



### Installation rapide (sur Raspberry Pi OS)

1.  **Mettre  jour le systme :**
    ```bash
    sudo apt-get update
    sudo apt-get full-upgrade -y
    ```


2. **Installer les dpendances principales:**
   ```bash
   sudo apt-get install -y git rsync unzip openjdk-11-jdk python3 python3-pip python3-pygame x11-xserver-utils lxterminal xdotool alsa-utils pulseaudio 
    ```

3. **Cloner les dpts:**


     ```bash
     mkdir -p ~/git
     cd ~/git
     # MG2D (si accessible)
     # git clone <URL_MG2D>
     # Borne arcade
     # git clone <URL_BORNE_ARCADE>
     ```

4. **Vrifier l'arborescence :**


   ```bash
    ~/git/
      MG2D/
      borne_arcade/
   ```

5.  **(Optionnel) Installer LOVE2D:**
    ```bash
    sudo apt-get install -y love
    ```

6. **Lancer une fois manuellement :**


   ```bash
   cd ~/git/borne_arcade
   ./lancerBorne.sh
   ```

## Dmarrage automatique

* **Option A  Autostart LXDE:**

    ```bash
    mkdir -p ~/.config/autostart
    cp ~/git/borne_arcade/borne.desktop ~/.config/autostart/
    ```

* **Option B  Systemd (recommand):**


    ```bash
    sudo ~/git/borne_arcade/scripts/install_systemd.sh
    ```



## Layout clavier borne

Si vous voyez l'erreur "layout 'borne' introuvable" :

   ```bash
   sudo ~/git/borne_arcade/scripts/install_keyboard_layout.sh
   ```



## Automatisation de l'installation

Une installation complte (dpendances, service systemd, hook git, compilation) :


    ```bash
    sudo ~/git/borne_arcade/scripts/install_borne.sh
    ```

 ## Dploiement automatique via git

Aprs installation du hook, chaque `git pull` dclenche :

- recompilation
- redmarrage du service

Installation du hook :

```bash
sudo ~/git/borne_arcade/scripts/install_git_hook.sh
```




## Tests rapides

Validation des dpendances et assets :


    ```bash
    ~/git/borne_arcade/scripts/validate_all.sh 
    ```



 Si des jeux Python ou LOVE2D ne se lancent pas, vrifiez :



    ```bash
   ~/git/borne_arcade/scripts/validate_launchers.sh  
    ```



 ## Mise  jour des dpendances


- Java (OpenJDK 11 recommand)

- MG2D (bibliothque graphique)
     - emplacement par dfaut : `../MG2D` (voisin du repo)
     - ou variable d'environnement `MG2D_PATH`

## Compilation

Le script [compilation.sh](../../compilation.sh) compile :

- le menu Java (fichiers `*.java`  la racine)

- tous les jeux Java prsents sous `projet/*/`



 **Excution**


 Le menu est lanc par [lancerBorne.sh](../../lancerBorne.sh) :
 - change le layout clavier
 - compile
 - dmarre le menu Java
 - lance un arrt automatique aprs sortie
