import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_filex/open_filex.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/export_card.dart';

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
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _downloadFontImage() async {
    // Check and request permissions
    if (Platform.isAndroid) {
      // For Android 13+ (API 33+), we don't need storage permission for some cases, 
      // but for direct directory access, ManageExternalStorage or Media permissions are needed.
      // Trying the most common approach for Download folder.
      PermissionStatus status;
      if (await Permission.manageExternalStorage.isRestricted) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.manageExternalStorage.request();
        if (status.isDenied) {
          status = await Permission.storage.request();
        }
      }

      if (!status.isGranted) {
        Fluttertoast.showToast(msg: "Storage permission required to save image");
        return;
      }
    }

    try {
      // 1. Capture the widget (Extracted to ExportCard)
      final image = await _screenshotController.captureFromWidget(
        ExportCard(
          fontName: widget.fontName,
          previewText: _previewText,
        ),
        delay: const Duration(milliseconds: 100),
        pixelRatio: 3.0,
      );

      // 2. Determine path (Download folder)
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        directory = await getDownloadsDirectory();
      }

      final String fileName = "Fontic_${widget.fontName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.png";
      final String filePath = '${directory!.path}/$fileName';
      final File file = File(filePath);

      // 3. Save the file
      await file.writeAsBytes(image);

      // 4. Show success Snackbar with "Open" action (since fluttertoast doesn't support buttons)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Image saved to Downloads folder"),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: "OPEN",
              textColor: Colors.blue,
              onPressed: () {
                OpenFilex.open(filePath);
              },
            ),
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error saving image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Container + SafeArea for notch protection
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.fontName),
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(CupertinoIcons.cloud_download),
                onPressed: _downloadFontImage,
              ),
            ],
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
