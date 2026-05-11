import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExportCard extends StatelessWidget {
  final String fontName;
  final String previewText;

  const ExportCard({
    super.key,
    this.fontName = 'Playpen Sans',
    this.previewText =
        'The quick brown fox jumps over the lazy dog. A beautiful demonstration of modern typography in a simple layout.',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 800,
        height: 450,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =========================
              /// TOP SECTION (H3 Style - Font Name)
              /// =========================
              Text(
                fontName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.getFont(
                  fontName,
                  color: Colors.black87,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 30),

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

              const SizedBox(height: 20),

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
                      // Updated to Fredoka Font
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
