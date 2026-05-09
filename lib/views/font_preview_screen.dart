import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontPreviewScreen extends StatefulWidget {
  final String fontName;
  const FontPreviewScreen({super.key, required this.fontName});

  @override
  State<FontPreviewScreen> createState() => _FontPreviewScreenState();
}

class _FontPreviewScreenState extends State<FontPreviewScreen> {
  double _fontSize = 45;
  String _previewText = "The quick brown fox jumps over the lazy dog.";
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Container + SafeArea for notch protection
    return Container(
      color: Colors.white, // Preview screen ka background white hai
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.fontName),
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              // Controls Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Column(
                  children: [
                    CupertinoTextField(
                      controller: _textController,
                      placeholder: "Type your own text...",
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _previewText = val.isEmpty
                              ? "The quick brown fox jumps over the lazy dog."
                              : val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "Size",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: CupertinoSlider(
                            value: _fontSize,
                            min: 20,
                            max: 120,
                            activeColor: Colors.black,
                            onChanged: (val) => setState(() => _fontSize = val),
                          ),
                        ),
                        Text(
                          "${_fontSize.toInt()}px",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Preview Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Text(
                        _previewText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          widget.fontName,
                          fontSize: _fontSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
