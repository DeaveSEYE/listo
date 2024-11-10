# listo

# Listo - Application de gestion de tâches

Listo est une application de gestion de tâches conçue pour vous aider à organiser et suivre vos activités de manière efficace. Cette application est développée avec **Flutter**, un framework de développement mobile multiplateforme, et utilise **Gradle** pour la gestion de la construction et des dépendances.

## Spécifications de l'environnement de développement

Avant de commencer à travailler sur le projet Listo, il est important de s'assurer que vous avez installé les versions recommandées de **Flutter** et **Gradle**. Ces versions sont optimisées pour garantir que l'application fonctionne correctement pendant le développement et la construction.

### 1. **Flutter Version Recommandée**

La version recommandée de **Flutter** pour ce projet est la version **3.24.4**. Il est important de maintenir cette version pour éviter les incompatibilités et les problèmes liés aux nouvelles mises à jour.

#### Comment vérifier votre version de Flutter
Pour vérifier la version de Flutter installée sur votre système, ouvrez un terminal ou une invite de commandes et exécutez la commande suivante :


flutter --version

Telecharger flutter a https://docs.flutter.dev/get-started/install/windows/mobile

### 2. **Gradle Version Recommandée**

La version recommandée de **Flutter** pour ce projet est la version **8.10.2**. Il est important de maintenir cette version pour éviter les incompatibilités et les problèmes liés aux nouvelles mises à jour.

#### Comment vérifier votre version de Gradle
Pour vérifier la version de Flutter installée sur votre système, ouvrez un terminal ou une invite de commandes et exécutez la commande suivante :

gradle -v

Telecharger Gradle a https://services.gradle.org/distributions


Une fois les outils installés et configurés, vous pouvez commencer à travailler sur le projet Listo. Pour le lancer, ouvrez un terminal, naviguez jusqu'au répertoire du projet, et exécutez les commandes suivantes :

initialiser le repos : 
git init

 Cloner le repos : 
git clone https://github.com/DeaveSEYE/listo.git 

flutter pub get
flutter run

# STRUCTURE DU PROJET 

lib/
├── core/
│   ├── api/              # Gestion des API, services, http
│   ├── utils/            # Outils et helpers (formatteur, etc.)
│   ├── constants/        # Variables et constantes globales
│   └── theme/            # Gestion des thèmes
│       └── theme.dart    # Définition des thèmes de l'application
│
├── features/
│   ├── auth/             # Authentification
│   │   ├── data/         # Gestion des données de l'authentification
│   │   ├── function/     # Logique métier de l'authentification
│   │   └── ui/           # Interface utilisateur d'authentification
│   │
│   ├── tasks/            # Fonctionnalité de gestion des tâches
│   │   ├── data/         # Gestion des données des tâches
│   │   ├── function/     # Logique métier des tâches
│   │   └── ui/           # Interface utilisateur des tâches
│
├── main.dart             # Point d'entrée de l'application
└── routes.dart           # Gestion des routes de l'application


La section features est constituée de dossiers qui représentent chacun un processus spécifique de développement, chaque dossier correspondant à une fonctionnalité de l'application. Voici un aperçu des principaux dossiers et leur rôle :

features/authentication : Ce dossier est dédié au processus d'authentification (login). Il contient :

L'interface de connexion : Les écrans et composants d'interface pour permettre à l'utilisateur de se connecter.
La logique de connexion : La logique métier et les contrôles de sécurité qui vérifient et valident les informations d'identification de l'utilisateur.
Les éléments associés au login : Par exemple, la gestion des sessions et la récupération de mot de passe.



