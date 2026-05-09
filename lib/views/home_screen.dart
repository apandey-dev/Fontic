import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/font_model.dart';
import '../services/font_service.dart';
import '../widgets/category_chip.dart';
import '../widgets/font_card.dart';
import '../widgets/search_pill.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FontModel> _displayFonts = [];

  // NAYA: Categories ki list aur selected state
  final List<String> _categories = [
    'All',
    'Sans Serif',
    'Serif',
    'Handwriting',
    'Display',
    'Monospace',
  ];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _applyFilters(); // Shuruat me list load karne ke liye
  }

  // NAYA: Ye function Search Bar aur Category dono ko ek sath filter karta hai
  void _applyFilters() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      Iterable<FontModel> filtered = FontService.getAllFonts();

      // 1. Search Query se filter karo
      if (query.isNotEmpty) {
        filtered = filtered.where(
          (font) => font.name.toLowerCase().contains(query),
        );
      }

      // 2. Category se filter karo (Agar 'All' nahi hai)
      if (_selectedCategory != 'All') {
        filtered = filtered.where(
          (font) => font.guessCategory == _selectedCategory,
        );
      }

      // Performance ke liye sirf pehle 30 render karo
      _displayFonts = filtered.take(30).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text("Fontic Vault"),
            backgroundColor: Colors.white.withOpacity(0.8),
            border: null,
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => const FavoritesScreen()),
                );
              },
              child: const Icon(
                LucideIcons.heart,
                color: Colors.black,
                size: 26,
              ),
            ),
          ),

          // Search Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 15),
              child: SearchPill(
                controller: _searchController,
                onChanged: (val) => _applyFilters(), // Update logic
              ),
            ),
          ),

          // NAYA: Horizontal Category List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return CategoryChip(
                    label: category,
                    isSelected: _selectedCategory == category,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                        _applyFilters(); // Category click hote hi list refresh hogi
                      });
                    },
                  );
                },
              ),
            ),
          ),

          // Thoda gap category aur cards ke beech
          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Generated Font Cards ya "No Results" message
          _displayFonts.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        "No fonts found \nTry another category",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final font = _displayFonts[index];
                      return FontCard(
                        key: ValueKey(
                          font.name,
                        ), // Card update bug solve karne ke liye zaroori
                        font: font,
                        isDarkTheme: index % 2 != 0,
                        index: index,
                      );
                    }, childCount: _displayFonts.length),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }
}
