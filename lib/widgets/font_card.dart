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
  final int index; // Animation delay ke liye

  const FontCard({
    super.key,
    required this.font,
    required this.isDarkTheme,
    required this.index,
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
    // Tap karne par card bounce hone ka setup
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    // Bounce ko aur thoda smooth kiya hai (0.96)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
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

    // Staggered Entrance Animation
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (widget.index * 50).clamp(0, 400)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)), // Niche se slide hoke aayega
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
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(30),
              // Naya: Ek bahut subtle border premium feel ke liye
              border: Border.all(
                color: widget.isDarkTheme
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP ROW (Category & Heart Icon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Naya: Category Chip with Icon
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: textColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.type,
                            size: 14,
                            color: textColor.withOpacity(0.7),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.font.guessCategory,
                            style: TextStyle(
                              color: textColor.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Heart Toggle Button (Download Icon Removed)
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
                            child: Container(
                              key: ValueKey(isLiked),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isLiked
                                    ? AppConstants.accentRed.withOpacity(0.1)
                                    : Colors.transparent,
                              ),
                              child: Icon(
                                isLiked
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: isLiked
                                    ? AppConstants.accentRed
                                    : textColor.withOpacity(0.3),
                                size: 26,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // HELLO WORLD (Preview Font)
                Text(
                  "HELLO WORLD",
                  style: GoogleFonts.getFont(
                    widget.font.name,
                    fontSize: 38,
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  "A beautiful demonstration of ${widget.font.name}.",
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                // Naya: Premium Divider
                Divider(
                  color: textColor.withOpacity(0.08),
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 16),

                // FOOTER WITH OVERFLOW FIX
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded widget collision ko rokega aur lambe naam ko cut kar dega
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FONT NAME",
                            style: TextStyle(
                              color: textColor.withOpacity(0.4),
                              fontSize: 11,
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
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow
                                .ellipsis, // <--- Overflow Fix Here (Adds ...)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Naya: Aesthetic Tag for google fonts
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: textColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "fonts.google.com",
                        style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
