# Rive Player

A Flutter web application for playing Rive animations.

## Features

- **List View**: Browse through available Rive animation files
- **Player View**: Play and view Rive animations in an interactive player
- **URL Path Strategy**: Direct URL navigation to specific animations
- **Web-Only**: Optimized for web deployment

## Getting Started

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- A web browser

### Installation

1. Navigate to the project directory:
   ```bash
   cd riveplayer
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

### Adding Rive Files

1. Place your `.riv` files in the `assets/rive/` folder
2. Run the update script to automatically sync the file list:
   ```bash
   dart run bin/update_rive_files.dart
   ```
   This will scan `assets/rive/` and update the file list in `lib/screens/rive_list_screen.dart`

**Manual Alternative**: You can also manually update the file list in `lib/screens/rive_list_screen.dart`:
```dart
static const List<String> riveFiles = [
  'your_file1.riv',
  'your_file2.riv',
  'your_file3.riv',
];
```

### Running the App

Run in Chrome:
```bash
flutter run -d chrome
```

Or run on a different web browser:
```bash
flutter run -d edge        # Microsoft Edge
flutter run -d web-server  # Default browser
```

### Building for Production

Build the web app:
```bash
flutter build web
```

The output will be in the `build/web/` directory.

## Project Structure

```
lib/
├── main.dart                      # App entry point with routing configuration
└── screens/
    ├── rive_list_screen.dart      # Screen showing list of Rive files
    └── rive_player_screen.dart    # Screen for playing Rive animations

bin/
└── update_rive_files.dart         # Script to auto-update file list

assets/
└── rive/                          # Place your .riv files here
```

## Scripts

### Update Rive Files List

```bash
dart run bin/update_rive_files.dart
```

This script automatically:
- Scans the `assets/rive/` folder for all `.riv` files
- Updates the `riveFiles` list in `lib/screens/rive_list_screen.dart`
- Sorts files alphabetically

Run this script whenever you add or remove `.riv` files from the assets folder.

## Routes

- `/` - Home screen with list of Rive files
- `/player/:fileName` - Player screen for specific Rive file

Example: `/player/sample1.riv`

## Dependencies

- **rive**: ^0.13.14 - Rive runtime for Flutter
- **go_router**: ^14.7.0 - Declarative routing with URL path strategy

## Where to Get Rive Files

You can create or download Rive animations from:
- [Rive Community](https://rive.app/community) - Free animations
- [Rive Editor](https://rive.app/) - Create your own animations

## License

This project is open source and available under the MIT License.
