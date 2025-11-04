# Wallpaper App

A modern Flutter desktop application for browsing, downloading, and setting wallpapers on Windows, macOS, and Linux.

## 🔗 Links

- **GitHub Repository:** [View on GitHub](https://github.com/Dukeazeta/stage3_wallpaperapp_dukeazeta)
- **Windows (.exe) Download:** [Download Latest Release](https://github.com/Dukeazeta/stage3_wallpaperapp_dukeazeta/releases/latest/download/stage3_wallpaperapp_dukeazeta.exe)
- **macOS (.app) Download:** [Download Latest Release](https://github.com/Dukeazeta/stage3_wallpaperapp_dukeazeta/releases/latest/download/stage3_wallpaperapp_dukeazeta.app.tar.gz)
- **Demo Video:** [Watch Demo](#)
- **Figma Design:** [View Figma File](#)

## 🚀 Setup & Installation

### Prerequisites
- Flutter SDK (version 3.9.2 or higher) with desktop support enabled
- Dart SDK
- **For Windows:**
  - Visual Studio 2019 or later with "Desktop development with C++" workload
- **For macOS:**
  - Xcode 12 or later
  - CocoaPods: `sudo gem install cocoapods`

- VS Code / Android Studio with Flutter extensions (recommended)

### Installation Steps
1. **Clone the repository**

2. **Enable desktop support** (if not already enabled)
   flutter config --enable-windows-desktop
   flutter config --enable-macos-desktop
   flutter config --enable-linux-desktop

3. **Install dependencies**

4. **Run the app locally**
1. Ensure Flutter desktop support is enabled (see step 2 above)
2. Run `flutter devices` to verify desktop platforms are available
3. Execute `flutter run -d [windows|macos]` to launch the app
4. The app will start in debug mode for testing and development

## 📋 Features
- Browse wallpapers by categories
- Download wallpapers
- Set wallpapers directly from the app
- Quality settings (High, Medium, Low)
- Settings customization
