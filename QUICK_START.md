# Quick Start Guide

## Adding Your Rive Files

1. **Download Rive files** from [Rive Community](https://rive.app/community) or create your own

2. **Add files to assets**:
   - Place your `.riv` files in `assets/rive/` folder
   - Example: `assets/rive/myanimation.riv`

3. **Update the file list**:
   ```bash
   dart run bin/update_rive_files.dart
   ```
   This automatically scans your assets folder and updates the app.

4. **Run the app**:
   ```bash
   flutter run -d chrome
   ```

## Example Free Rive Files to Try

Visit https://rive.app/community and download any animation, such as:
- Animated Characters
- Loading Animations
- Interactive Buttons
- Animated Icons

## Troubleshooting

**Issue**: "Failed to load Rive file"
- **Solution**: Make sure the filename in the list exactly matches the file in `assets/rive/`
- **Quick fix**: Run `dart run bin/update_rive_files.dart` to sync the file list

**Issue**: App doesn't show my new animation
- **Solution**: Run `dart run bin/update_rive_files.dart` to update the file list
- **Alternative**: Run `flutter pub get` and restart the app after adding new files

## Project Structure

```
riveplayer/
├── lib/
│   ├── main.dart                    # App entry with routing
│   └── screens/
│       ├── rive_list_screen.dart    # List of animations
│       └── rive_player_screen.dart  # Animation player
├── bin/
│   └── update_rive_files.dart       # Auto-update file list script
├── assets/
│   └── rive/                        # Put your .riv files here
├── pubspec.yaml                     # Dependencies
└── README.md                        # Full documentation
```

## URLs

Once running, you can navigate to:
- `http://localhost:port/` - Animation list
- `http://localhost:port/player/filename.riv` - Direct to player

The port number will be shown when you run `flutter run -d chrome`.
