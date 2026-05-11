import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExportCard extends StatelessWidget {
  final String fontName;
  final String previewText;
  final double
  headingFontSize; // Heading ka font size vary karne ke liye parameter

  const ExportCard({
    super.key,
    this.fontName = 'Playpen Sans',
    this.previewText =
        'The quick brown fox jumps over the lazy dog. A beautiful demonstration of modern typography in a simple layout.',
    this.headingFontSize = 24.0, // Default H4 size rakha hai
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 950, // Width thodi zyada kar di hai
        height: 380, // Height thodi kam kar di hai
        decoration: BoxDecoration(
          color: Colors.white, // DAY THEME: White Background
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.black.withOpacity(0.08), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        // Padding all directions se exactly 14 kar di hai
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =========================
              /// TOP SECTION (H4 Style - Font Name)
              /// =========================
              Text(
                fontName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.getFont(
                  fontName,
                  color: Colors.black87,
                  fontSize:
                      headingFontSize, // Yahan se size vary karega (H4 / 24px)
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 20,
              ), // Spacing thodi adjust ki hai compact height ke liye
              /// =========================
              /// MIDDLE SECTION (P Tag Style - Preview Text)
              /// =========================
              Expanded(
                child: Text(
                  previewText,
                  style: GoogleFonts.getFont(
                    fontName,
                    color: Colors.black.withOpacity(0.85),
                    fontSize: 26,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /// =========================
              /// DIVIDER LINE
              /// =========================
              Container(
                width: double.infinity,
                height: 1.2,
                color: Colors.black.withOpacity(0.1),
              ),

              const SizedBox(height: 15),

              /// =========================
              /// BOTTOM SECTION (App Name - FONTIC at Right Corner)
              /// =========================
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Aligning items to the right corner
                children: [
                  Icon(
                    CupertinoIcons.sparkles,
                    color: Colors.black54, // Subtle icon color
                    size: 14, // Small icon size
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "FONTIC",
                    style: GoogleFonts.fredoka(
                      color: Colors.black54, // Subtle watermark style text
                      fontSize: 14, // Small font size
                      letterSpacing: 3.5, // Perfect spacing for branding
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
