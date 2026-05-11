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
        width: 800, // Card ki width thodi adjust ki hai compact look ke liye
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white, // Day Theme: White Background
          borderRadius: BorderRadius.circular(32), // Smooth corners
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
                  fontSize: 32, // H3 ke hisaab se perfect size
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
                    fontSize:
                        26, // Paragraph jaisa lagne ke liye chota aur clean font size
                    height: 1.5, // Line height taaki padhne mein acha lage
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

              const SizedBox(height: 25),

              /// =========================
              /// BOTTOM SECTION (App Name - FONTIC)
              /// =========================
              Row(
                children: [
                  // Chota sa dot icon thoda premium feel dene ke liye
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // App Name
                  Text(
                    "FONTIC",
                    style: GoogleFonts.inter(
                      // Branding ke liye clean sans-serif font
                      color: Colors.black87,
                      fontSize: 18,
                      letterSpacing:
                          6.0, // Thoda space diya hai premium look ke liye
                      fontWeight: FontWeight.w800,
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
