#!/bin/bash
set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Ce script doit être exécuté en root (sudo)." >&2
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get full-upgrade -y

# Outils de base
apt-get install -y git rsync unzip

# Java (version recommandée)
apt-get install -y openjdk-11-jdk

# Son (si requis par certains jeux)
apt-get install -y alsa-utils pulseaudio

# X11 utilitaires (clavier/terminal)
apt-get install -y x11-xserver-utils lxterminal

echo "Installation terminée. Redémarrage recommandé."