# gael

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 2. install dependencies

```bash
flutter pub get
```

## 3. run the app

```bash
flutter run
```

## 4. build the app

```bash
flutter build apk
```

**Note:** 

- Définir la couleur de la barre de notification.
(la zone en haut de l'écran où se trouve l'heure, la batterie, etc.)

```dart
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
));
```

- Definir l'effet flou.

```dart 
import 'dart:ui' as ui show ImageFilter;

ClipRect(
        // Use ClipRect to restrict the blur effect to the container boundaries
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Text('Hello World'),
          ),
        ),
      ),

```

!Important:
pour arreter de suivre un fichier dans git
```bash
git rm --cached <file>
```