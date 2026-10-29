# Projet-Mobile — Mes devoirs

Application Flutter de suivi des devoirs pour le cours de programmation mobile.

## Fonctionnalités

- Consulter les devoirs et leur cours
- Ajouter un devoir avec validation des champs
- Marquer un devoir comme terminé ou à faire
- Supprimer un devoir
- Voir le nombre de devoirs restants

## Démarrer

Installez le [Flutter SDK](https://docs.flutter.dev/get-started/install), puis lancez :

```sh
flutter pub get
flutter run
```

Un émulateur ou un appareil connecté est nécessaire.

## Fichiers principaux

- `lib/main.dart` : application et parcours de suivi des devoirs
- `pubspec.yaml` : configuration et dépendances
- `docs/use-cases.md` : acteur, cas d’utilisation, diagramme et scénario principal

> Les devoirs sont actuellement gardés en mémoire et disparaissent à la fermeture de l’application. Le stockage local est un bon prochain exercice.
