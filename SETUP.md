# Local Development Setup

This guide explains how to run the MyPortfolio Flutter app on your machine.

## Prerequisites

- Flutter SDK with Dart 3.12 or later (check with `flutter --version`)
- One of the following targets:
  - An Android emulator, set up through Android Studio's Device Manager
  - Google Chrome
- The MyPortfolio Django backend, running locally (Follow its `SETUP.md`)

## 1. Build

From the project root:

```bash

# Install the packages listed in pubspec.yaml
flutter pub get

# Generate the .g.dart files for the models in lib/models/
dart run build_runner build --delete-conflicting-outputs

```

## 2. Run the app

1. Option A: Android emulator

```bash
# Start an android emulator 
flutter run
```

2. Option B: Chrome

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

## Configuration

The backend address is set in `lib/config.dart` and can be overridden at launch:

```bash
flutter run --dart-define=API_BASE_URL=<backend URL>
```

- Android emulator: `http://10.0.2.2:8000` (default)
- Chrome: `http://localhost:8000` 


## Troubleshooting

1. Projects fail to load and the backend terminal shows no request
    Check that the backend is running (`python manage.py runserver`) and that you are using the correct URL for your target.

2. The backend responds with `400 Bad Request`
    The host is not in the backend's `ALLOWED_HOSTS`.

3. Errors mention a missing `.g.dart` file  
    Run the code generation step again.

