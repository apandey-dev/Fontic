import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExportCard extends StatelessWidget {
  final String fontName;
  final String previewText;
  final String subtitleText;

  const ExportCard({
    super.key,
    this.fontName = 'Playpen Sans',
    this.previewText = 'HELLO WORLD',
    this.subtitleText =
        'A beautiful demonstration of Playpen Sans\ntypography in a modern layout.',
  });

  @override
  Widget build(BuildContext context) {
    // Agar previewText empty hai, toh default "HELLO WORLD" dikhayega
    final mainHeading = previewText.trim().isEmpty
        ? "HELLO WORLD"
        : previewText;

    return Center(
      child: Container(
        width: 950,
        height:
            480, // Height adjust ki gayi hai taaki image jaisa perfect ratio mile
        decoration: BoxDecoration(
          // DAY THEME: White Background
          color: Colors.white,

          borderRadius: BorderRadius.circular(42),

          // DAY THEME: Subtle dark border
          border: Border.all(color: Colors.black.withOpacity(0.08), width: 1.5),

          // DAY THEME: Lighter shadow suitable for white background
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 40,
              spreadRadius: 4,
              offset: const Offset(0, 10), // Thoda sa neeche ki taraf shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(42),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// =========================
                /// MAIN TYPOGRAPHY (HELLO WORLD)
                /// =========================
                Text(
                  mainHeading,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.getFont(
                    fontName,
                    color: Colors.black, // DAY THEME: Black text
                    fontSize: 110, // Bada size image match karne ke liye
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 15),

                /// =========================
                /// SUBTITLE TEXT
                /// =========================
                Text(
                  subtitleText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.getFont(
                    fontName,
                    color:
                        Colors.black87, // Slightly lighter black for subtitle
                    fontSize: 36,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                /// =========================
                /// DIVIDER LINE
                /// =========================
                Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.black.withOpacity(0.12), // Dark divider
                ),

                const SizedBox(height: 30),

                /// =========================
                /// BOTTOM SECTION (FONT NAME)
                /// =========================
                Text(
                  "Font name: $fontName",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.getFont(
                    fontName,
                    color: Colors.black, // Black text
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
