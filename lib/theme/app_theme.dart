import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    // Fredoka ka base font text theme
    final TextTheme fredokaTextTheme = GoogleFonts.fredokaTextTheme();

    // Fredoka ka sirf font family string ("Fredoka")
    final String? fredokaFontFamily = GoogleFonts.fredoka().fontFamily;

    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      primaryColor: CupertinoColors.black,

      // 1. MATERIAL WIDGETS KE LIYE DEFAULT
      fontFamily: fredokaFontFamily,
      textTheme: fredokaTextTheme,

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.fredoka(),
        labelStyle: GoogleFonts.fredoka(),
        counterStyle: GoogleFonts.fredoka(),
        helperStyle: GoogleFonts.fredoka(),
        errorStyle: GoogleFonts.fredoka(),
        prefixStyle: GoogleFonts.fredoka(),
        suffixStyle: GoogleFonts.fredoka(),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.fredoka(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // 2. CUPERTINO (iOS) WIDGETS KE LIYE DEFAULT (Fix applied here)
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: CupertinoColors.black,
        textTheme: CupertinoTextThemeData(
          // For regular text in iOS widgets (like text fields)
          textStyle: GoogleFonts.fredoka(color: Colors.black, fontSize: 16),
          // For Large Titles (CupertinoSliverNavigationBar)
          navLargeTitleTextStyle: GoogleFonts.fredoka(
            color: Colors.black,
            fontSize: 34,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          // For normal nav bar titles
          navTitleTextStyle: GoogleFonts.fredoka(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          // For input fields / Search bar
          actionTextStyle: GoogleFonts.fredoka(color: Colors.black),
        ),
      ),
      useMaterial3: true,
    );
  }
}
