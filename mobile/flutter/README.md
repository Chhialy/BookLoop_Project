# BookLoop (Flutter)

Minimal Flutter scaffold for implementing Figma frames as mobile screens.

Quick start

1. Install Flutter SDK and ensure `flutter` is available on PATH.
2. From the `mobile/flutter` folder:

```powershell
cd 'C:\Users\chhia\OneDrive\Desktop\BookLoop_Project\mobile\flutter'
flutter pub get
flutter run
```

Downloading Figma assets

You can download PNG exports from Figma using the helper script `tools/download_figma_assets.ps1`.
Set your token in the environment (do NOT commit it):

```powershell
$env:FIGMA_API_TOKEN = '<your_figma_token>'
cd 'C:\Users\chhia\OneDrive\Desktop\BookLoop_Project'
powershell -ExecutionPolicy ByPass -File .\tools\download_figma_assets.ps1 -fileKey '<FIGMA_FILE_KEY>' -nodeIds '15-1429,15-1430' -outDir '.\mobile\flutter\assets'
```

After downloading, add the asset paths to `pubspec.yaml` if needed and reference them from the screens.

Notes
- `AppTheme.light` and `PrimaryButton` are provided under `lib/src` and `lib/widgets`.
- Tests: `flutter test` runs a basic navigation smoke test.
# Mobile (Flutter) — BookLoop Project

This folder contains a minimal Flutter scaffold for implementing the 11 Figma designs.

Quick start (local machine must have the Flutter SDK installed):

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. From repo root:

```powershell
cd 'C:\Users\chhia\OneDrive\Desktop\BookLoop_Project\mobile\flutter'
flutter pub get
flutter run
```

Notes:
- On Windows you can run Android emulators locally. For iOS builds/simulator you need macOS or a cloud builder.
- Design assets and tokens should be added to `assets/` and `lib/design_tokens.dart`.
- Replace the placeholder screens in `lib/screens/` with real implementations after you export assets from Figma.
