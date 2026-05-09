import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/font_model.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../views/font_preview_screen.dart';

class FontCard extends StatefulWidget {
  final FontModel font;
  final bool isDarkTheme;
  final int index;
  final bool isGridView; // NAYA: Card ko batayega ki chota dikhna hai ya bada

  const FontCard({
    super.key,
    required this.font,
    required this.isDarkTheme,
    required this.index,
    this.isGridView = false, // Default list view
  });

  @override
  State<FontCard> createState() => _FontCardState();
}

class _FontCardState extends State<FontCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDarkTheme
        ? AppConstants.cardDark
        : AppConstants.cardLight;
    final textColor = widget.isDarkTheme ? Colors.white : Colors.black;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (widget.index * 50).clamp(0, 400)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) {
          _scaleController.reverse();
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  FontPreviewScreen(fontName: widget.font.name),
            ),
          );
        },
        onTapCancel: () => _scaleController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            // Grid mode me margin grid handle karta hai, isliye yahan margin chota diya
            margin: EdgeInsets.only(bottom: widget.isGridView ? 0 : 24),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isGridView ? 16 : 24,
              vertical: widget.isGridView ? 20 : 28,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(widget.isGridView ? 22 : 30),
              border: Border.all(
                color: widget.isDarkTheme
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: widget.isGridView ? 12 : 24,
                  offset: Offset(0, widget.isGridView ? 4 : 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: widget.isGridView
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                // TOP ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category Chip
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: textColor.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!widget
                                .isGridView) // Grid me icon hide kar do space bachane ke liye
                              Icon(
                                LucideIcons.type,
                                size: 14,
                                color: textColor.withOpacity(0.7),
                              ),
                            if (!widget.isGridView) const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.font.guessCategory,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: textColor.withOpacity(0.8),
                                  fontSize: widget.isGridView ? 10 : 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Heart Toggle
                    ValueListenableBuilder<List<String>>(
                      valueListenable: StorageService.likedFontsNotifier,
                      builder: (context, likedList, child) {
                        final isLiked = likedList.contains(widget.font.name);
                        return GestureDetector(
                          onTap: () =>
                              StorageService.toggleFavorite(widget.font.name),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Icon(
                              isLiked
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              key: ValueKey(isLiked),
                              color: isLiked
                                  ? AppConstants.accentRed
                                  : textColor.withOpacity(0.3),
                              size: widget.isGridView ? 22 : 26,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                if (!widget.isGridView) const SizedBox(height: 30),

                // HELLO WORLD (Preview Text)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: widget.isGridView ? 10.0 : 0,
                  ),
                  child: Text(
                    widget.isGridView
                        ? "Aa"
                        : "HELLO WORLD", // Grid me bada Aa dikhega
                    style: GoogleFonts.getFont(
                      widget.font.name,
                      fontSize: widget.isGridView ? 45 : 38,
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                if (!widget.isGridView) ...[
                  const SizedBox(height: 10),
                  Text(
                    "A beautiful demonstration of ${widget.font.name}.",
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Divider(
                    color: textColor.withOpacity(0.08),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                ],

                // FOOTER
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FONT NAME",
                      style: TextStyle(
                        color: textColor.withOpacity(0.4),
                        fontSize: widget.isGridView ? 9 : 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.font.name,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: widget.isGridView ? 14 : 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
