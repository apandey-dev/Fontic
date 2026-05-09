# 🎨 Fontic Vault

**A beautiful, minimal, and feature-rich font discovery app built with Flutter.**  
Explore **1500+ Google Fonts**, search instantly, preview typefaces, and build your personal collection of favorites — all wrapped in a polished Cupertino-style interface.

---

## ✨ Features

- **1500+ Google Fonts** – Browse the entire Google Fonts catalogue directly inside the app.
- **Smart Search** – Find fonts by name instantly with responsive filtering.
- **Category Filters** – Filter fonts by:
  - Sans Serif
  - Serif
  - Handwriting
  - Display
  - Monospace
- **Favorites System** – Save your favorite fonts locally using SharedPreferences.
- **Reactive UI Updates** – Uses ValueNotifier and ValueListenableBuilder for instant UI refresh.
- **Font Preview Screen** – Customize preview text and adjust font size dynamically.
- **Grid & List Layouts** – Toggle between detailed list view and compact grid view.
- **Smooth Animations** – Includes staggered animations, fade transitions, and scaling effects.
- **Premium Cupertino UI** – iOS-inspired design with smooth navigation and clean typography.
- **Modern Typography** – Uses Fredoka as the primary UI font throughout the app.

---

## 🛠 Tech Stack

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform app framework |
| Dart | Programming language |
| google_fonts | Dynamic Google Fonts integration |
| shared_preferences | Local storage for favorites |
| lucide_icons | Modern icon library |

---

## 📁 Project Structure

```bash
lib/
├── main.dart
├── models/
│   └── font_model.dart
├── services/
│   ├── font_service.dart
│   └── storage_service.dart
├── theme/
│   └── app_theme.dart
├── utils/
│   ├── constants.dart
│   └── dummy_fonts.dart
├── views/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── favorites_screen.dart
│   └── font_preview_screen.dart
└── widgets/
    ├── animated_font_title.dart
    ├── category_chip.dart
    ├── font_card.dart
    └── search_pill.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.x recommended)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

---

## 📦 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/apandey-dev/fontic.git
```

### 2. Navigate to the Project Folder

```bash
cd fontic
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

---

## 📱 Screens Included

| Screen | Description |
|--------|-------------|
| Splash Screen | Animated startup screen |
| Home Screen | Browse and search fonts |
| Grid View | Compact font preview layout |
| Favorites Screen | Saved favorite fonts |
| Preview Screen | Live customizable font preview |

---

## 🎯 Core Functionalities

### Dynamic Font Loading

The app dynamically loads all available Google Fonts using:

```dart
GoogleFonts.asMap()
```

This allows Fontic to support a huge collection of fonts without manually maintaining font data.

---

### Smart Category Detection

Fonts are automatically categorized based on keywords in the font name.

Examples:
- `Sans` → Sans Serif
- `Serif` → Serif
- `Mono` → Monospace
- `Hand` → Handwriting

---

### Live Font Preview

Users can:
- Type custom preview text
- Adjust font size with slider
- Preview typography in real time

---

### Favorites Persistence

Favorites are stored locally using:

```dart
SharedPreferences
```

The app maintains reactive updates using:

```dart
ValueNotifier
```

---

## 🎨 UI & Design Philosophy

Fontic follows a clean and modern iOS-inspired design language:

- Soft shadows
- Rounded cards
- Minimal layouts
- Smooth animations
- Premium typography
- Responsive spacing
- Elegant transitions

---

## ⚡ Performance Optimizations

- Efficient lazy rendering with Slivers
- Lightweight local state management
- Optimized animations
- Minimal rebuilds using ValueNotifier
- Responsive search filtering

---

## 🔮 Future Improvements

Planned features for future updates:

- Dark Mode
- Font Downloading
- Font Pair Recommendations
- Recently Viewed Fonts
- Cloud Sync
- Font Comparison Tool
- Advanced Typography Playground

---

## 🤝 Contributing

Contributions are welcome.

1. Fork the repository
2. Create a new branch
3. Commit your changes
4. Push the branch
5. Open a Pull Request

---

## 📜 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

### Arpit Pandey

Flutter Developer & UI Enthusiast

GitHub: https://github.com/apandey-dev

---

## ❤️ Credits

- Flutter
- Google Fonts
- Lucide Icons
- Shared Preferences Package

---

<p align="center">
  Made with ❤️ using Flutter
</p>