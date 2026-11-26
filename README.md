# Flutter POS

[![License: MIT](https://img.shields.io/badge/license-MIT-orange)](./LICENSE)
[![Made with Flutter](https://img.shields.io/badge/made%20with-Flutter-blue)](https://flutter.dev/)

A Point of Sale (POS) application built with Flutter, demonstrating **Clean Architecture** principles and **offline-first** design patterns. This project serves as a learning resource and reference implementation for building Flutter apps with proper architecture and automatic data synchronization between local storage (SQLite) and cloud database (Firestore).

The app prioritizes local-first operations, storing all data in SQLite and automatically syncing with Firestore when online. When offline, all user actions (create, update, delete) are recorded as `QueuedActions` in the local database and automatically executed in sequence when internet connectivity is restored.

## Demo APK

[Download Demo APK](https://github.com/elrizwiraswara/flutter_pos/releases)

## Features

### Core Functionality

- **Product Management**: Full CRUD operations for products with image upload support
- **Sales Transactions**: POS interface with cart management and transaction history
- **Thermal Receipt Printing**: Print transaction receipts via USB, Bluetooth, BLE, or network printers with configurable paper sizes (58mm, 72mm, 80mm)
- **User Authentication**: Firebase Authentication with Google Sign-In integration
- **Account Management**: User profile management and settings

### Technical Implementation

- **Offline-First Architecture**: Works seamlessly without internet connection
- **Automatic Data Sync**: SQLite ↔ Firestore bidirectional synchronization
- **Queued Actions**: Automatic retry mechanism for offline operations (create, update, delete)
- **Clean Architecture**: Separation between presentation, domain, and data layers
- **State Management**: Riverpod (migrated from Provider) for safer, more testable state management
- **Dependency Injection**: Centralized DI setup for better code organization
- **Unit Testing**: Tests for datasources, repositories, and use cases
- **Material Design 3**: Material design 3 and Dark & Light theme switching support
- **Customizable Theming**: Adjustable colors and typography
- **Multi-Platform**: Supports Android, iOS, Windows, macOS, and Linux
- **Error Handling**: User-friendly error messages and states
- **Reusable Widgets**: Custom UI components for consistent design

## Project Structure

```
flutter_pos/
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app_view.dart                 # Root widget (theme, routing, locale)
│   ├── bootstrap/                    # Startup: Firebase, emulators, dependencies
│   ├── config/                       # Firebase options, emulator host, test account
│   ├── managers/                     # App-wide wiring
│   │   ├── navigation/               # Routes and route params
│   │   ├── registry/                 # Dependency injection (get_it, injectable)
│   │   └── theme/                    # Light and dark theme state
│   │
│   ├── core/                         # Code shared by all features
│   │   ├── assets/                   # Asset paths
│   │   ├── constants/                # App constants
│   │   ├── locale/                   # Localization
│   │   ├── data/services/            # Connectivity, database (sqflite), device info, logger, printer
│   │   ├── domain/                   # Result wrapper, use case base class, params
│   │   ├── presentation/             # Shared screens, widgets, theme, error views
│   │   ├── storage/                  # File storage (data, domain)
│   │   └── sync/queued_action/       # Offline action queue (data, domain)
│   │
│   ├── utils/                        # Formatters, launcher, logger and other helpers
│   │
│   └── features/                     # One folder per feature
│       ├── account/
│       ├── auth/
│       ├── home/
│       ├── main/
│       ├── products/
│       ├── welcome/
│       └── transactions/             # Expanded here as an example
│           ├── data/
│           │   ├── models/           # Models with JSON serialization
│           │   ├── sources/          # Local (sqflite) and remote (Firestore) datasources
│           │   ├── repositories/     # Repository implementations
│           │   └── export.dart       # Barrel file
│           ├── domain/
│           │   ├── entities/         # Business entities
│           │   ├── repositories/     # Repository interfaces
│           │   ├── usecases/         # Use cases
│           │   └── export.dart
│           ├── presentation/
│           │   ├── managers/         # State management (Riverpod)
│           │   ├── screens/          # Screens
│           │   ├── widgets/          # Feature widgets
│           │   └── export.dart
│
├── test/                             # Mirrors lib/
│   ├── core/                         # Core service, storage and sync tests
│   ├── features/                     # Datasource, repository and use case tests per feature
│   └── helpers/                      # Shared fixtures and in-memory test database
│
├── tool/emulators/                   # start.sh runs the emulators, seed.sh rebuilds the seed
├── firebase/emulator-seed/           # Seed data the emulators start from
│
├── firebase.json                     # Firebase emulator configuration
├── .firebaserc                       # Firebase project alias (demo-flutter-pos)
├── firestore.rules                   # Firestore security rules
├── storage.rules                     # Storage security rules
├── analysis_options.yaml             # Dart analyzer configuration
├── pubspec.yaml                      # Package dependencies
└── README.md                         # Project documentation
```

## Getting Started

The app talks to the Firebase Emulator Suite on your machine, so you do not need a Firebase project to try it.

### Prerequisites

- [fvm](https://fvm.app/), which installs the Flutter version this repo pins in `.fvmrc`
- Java 21 or newer on your `PATH`, which the Firebase emulators need
- Node.js, so `npx` can run the Firebase CLI
- An Android emulator or a phone

### Set up

Clone the repository and install the pinned Flutter version:

```sh
git clone https://github.com/elrizwiraswara/flutter_pos.git
cd flutter_pos
fvm install
fvm use
flutter pub get
```

### Start the emulators

Run this in its own terminal and leave it open:

```sh
tool/emulators/start.sh
```

Every start begins from the seed data in `firebase/emulator-seed/`, so product stock is back to 10 each time. If you change the seed, `tool/emulators/seed.sh` rebuilds it. The Emulator UI is at <http://localhost:4000>.

### Run the app

On the Android emulator, run `flutter run`. In VS Code, use the default launch configuration, "flutter_pos".

Debug builds show a "Sign in with test account" button on the sign-in screen. The account is `cashier@flutterpos.test` with the password `cashier123`. Release builds do not have it.

To run on a phone on the same Wi-Fi, pass your computer's LAN IP address:

```sh
flutter run --dart-define=EMULATOR_HOST=<your computer's LAN IP>
```

The Google sign-in launch configuration still reads `GOOGLE_SERVER_CLIENT_ID` from a `config.json` file, passed with `--dart-define-from-file config.json`.

### Test

To test the application, run the following command:

```sh
flutter test --coverage
```

To view the test coverage you can use `genhtml` or [test_cov_console](https://pub.dev/packages/test_cov_console)

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any bugs, feature requests, or improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
