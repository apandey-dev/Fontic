import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontPreviewView extends StatelessWidget {
  final String fontName;
  final String previewText;

  const FontPreviewView({
    super.key,
    required this.fontName,
    required this.previewText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20), // Yeh card ke bahar ki space hai
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 250),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.black.withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            // Yahan container ke andar ki padding sirf 4px kar di hai
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  previewText.trim().isEmpty
                      ? "Type something to preview..."
                      : previewText,
                  style: GoogleFonts.getFont(
                    fontName,
                    fontSize: 21,
                    color: Colors.black.withOpacity(0.85),
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
