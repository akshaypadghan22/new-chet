# Chaitanya Math Center (Flutter)

Screens: Home (notice + timetable), Haziri (attendance), Study (videos/notes folders), Feed (community posts), Profile (PTM, marks).

All data is in-memory sample data. Nothing is saved after the app closes.

## Option A: Build on your PC

1. Install Flutter (https://docs.flutter.dev/get-started/install) and Android Studio (for the Android SDK).
2. In this folder run:

   flutter create --platforms=android --org com.chaitanya --project-name chaitanya_math_center .
   flutter pub get
   flutter build apk --release

3. APK: `build/app/outputs/flutter-apk/app-release.apk`. Copy it to your phone and install it
   (allow "Install unknown apps").

To test quickly on a connected phone: `flutter run`.

## Option B: Build in the cloud with no installs (GitHub Actions)

1. Create a new GitHub repository and upload everything in this folder (keep `.github/workflows/build-apk.yml`).
2. Open the repo's **Actions** tab, choose **Build Android APK**, click **Run workflow**.
3. When it finishes (about 5 minutes), download `chaitanya-math-center-apk` from the run's Artifacts and unzip it.

## Notes

- The release APK is signed with the debug key. That is fine for sideloading, but Play Store needs your own keystore.
- "Call Teacher", "Notify Parents" and "Request PTM" currently only show messages. Real calling needs the `url_launcher` package.
