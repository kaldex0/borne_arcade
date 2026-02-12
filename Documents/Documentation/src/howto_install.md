# How-to : installation

Généré le {{GENERATED_AT}}

## Objectif

Installer la borne d'arcade sur Raspberry Pi OS Bullseye 32-bit.

## Prérequis

- Raspberry Pi 3 B+
- Acces SSH ou clavier/ecran
- Depots `borne_arcade` et `MG2D`

## Etapes

1. Installer les dependances :

```
sudo ~/borne_arcade/scripts/setup_rpi_os.sh
```

2. Installer le service systemd et le hook git :

```
sudo ~/borne_arcade/scripts/install_borne.sh
```

3. Verifier le lancement :

```
./lancerBorne.sh
```

## Verification

- Le menu s'affiche
- Les jeux se lancent depuis le menu
- `scripts/validate_all.sh` est OK
