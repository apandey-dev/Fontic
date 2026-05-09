import 'package:google_fonts/google_fonts.dart';
import '../models/font_model.dart';

class FontService {
  // GoogleFonts package se directly saare fonts ki keys (names) utha rahe hain
  static List<FontModel> getAllFonts() {
    return GoogleFonts.asMap().keys
        .map((fontName) => FontModel(name: fontName))
        .toList();
  }

  // Search logic
  static List<FontModel> searchFonts(String query) {
    final all = getAllFonts();
    if (query.isEmpty) return all;

    return all
        .where((font) => font.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
