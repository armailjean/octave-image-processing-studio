# Octave Image Processing Studio

**Application graphique de traitement et d'analyse d'images numériques développée avec GNU Octave.**

## Présentation du projet

Octave Image Processing Studio est une application permettant de charger, visualiser, transformer, améliorer et analyser des images numériques à travers une interface graphique (GUI) interactive et intuitive.

Ce logiciel met à disposition plusieurs outils de traitement d'images, des réglages de couleurs en temps réel, des filtres numériques ainsi que des fonctionnalités d'analyse fréquentielle basées sur la transformée de Fourier rapide (FFT).

L'objectif est de proposer un environnement simple, pratique et performant pour manipuler et étudier des images numériques.

## Fonctionnalités principales

### 1. Gestion des images
- Chargement d'images depuis l'ordinateur.
- Affichage de l'image originale.
- Affichage de l'image après traitement.
- Exportation des images traitées.
- Prise en charge des formats PNG, JPG et BMP.

### 2. Transformations géométriques
- Conversion en niveaux de gris.
- Rotation avec angle personnalisé.
- Découpage (Crop) avec coordonnées personnalisées.
- Redimensionnement en pourcentage.
- Miroir horizontal et vertical.
- Création d'images négatives.

### 3. Réglages et améliorations
- Ajustement de la luminosité.
- Réglage du contraste.
- Modification individuelle des canaux de couleurs RGB :
  - Rouge (R).
  - Vert (G).
  - Bleu (B).

### 4. Filtres et traitements numériques
- Filtre moyen pour le lissage des images.
- Filtre Sobel pour la détection des contours.
- Application de filtres personnalisés.
- Calcul et visualisation des histogrammes.

### 5. Analyse fréquentielle (FFT)
- Application de la transformée de Fourier rapide (FFT).
- Visualisation du spectre en magnitude.
- Analyse des composantes fréquentielles de l'image.

### 6. Gestion de l'historique
- Annulation des opérations (Undo).
- Rétablissement des opérations (Redo).
- Gestion de l'historique avec les piles `History` et `Future`.
- Réinitialisation de l'image à son état original.

### 7. Interface graphique (GUI)
- Interface interactive et intuitive.
- Affichage simultané de l'image originale et de l'image traitée.
- Panneau d'outils et de réglages avec sliders.
- Menu principal organisé par catégories.
- Thème clair et sombre.
- Affichage d'une grille.
- Messages d'information et de suivi des opérations.

## Technologies utilisées

| Technologie | Utilisation |
|---|---|
| GNU Octave | Environnement de développement |
| Octave GUI / Graphics | Création de l'interface graphique |
| Traitement d'images numériques | Transformations et filtres |
| FFT | Analyse fréquentielle |
| RGB | Manipulation des canaux de couleurs |

## Installation et exécution

### Prérequis

- GNU Octave installé sur l'ordinateur.
- Les fonctions et packages nécessaires au traitement d'images, selon les fonctionnalités utilisées par le projet.

### Installation

1. Cloner le repository GitHub :

```bash
git clone https://github.com/armailjean/octave-image-processing-studio.git
```

2. Accéder au dossier du projet :

```bash
cd octave-image-processing-studio
```

3. Ouvrir GNU Octave.

4. Exécuter le fichier principal de l'application :

```octave
run('main.m')
```

**Remarque :** remplacer `main.m` par le nom réel du fichier principal si celui-ci est différent.

## Guide d'utilisation

1. Lancer l'application sous GNU Octave.
2. Charger une image depuis l'ordinateur.
3. Visualiser l'image originale dans la zone dédiée.
