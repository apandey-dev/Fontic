import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const String _favKey = 'favorite_fonts';

  // ValueNotifier taaki UI ko pata chale kab like/unlike hua bina setState ke
  static ValueNotifier<List<String>> likedFontsNotifier =
      ValueNotifier<List<String>>([]);

  // Main.dart me call hota hai
  static void initialize(SharedPreferences prefs) {
    _prefs = prefs;
    likedFontsNotifier.value = _prefs.getStringList(_favKey) ?? [];
  }

  // Like/Unlike karne ka function
  static void toggleFavorite(String fontName) {
    List<String> currentLikes = List.from(likedFontsNotifier.value);

    if (currentLikes.contains(fontName)) {
      currentLikes.remove(fontName);
    } else {
      currentLikes.add(fontName);
    }

    likedFontsNotifier.value = currentLikes; // Notifies UI
    _prefs.setStringList(_favKey, currentLikes); // Saves to memory
  }

  // Check karne ke liye ki font liked hai ya nahi
  static bool isFavorite(String fontName) {
    return likedFontsNotifier.value.contains(fontName);
  }
}
