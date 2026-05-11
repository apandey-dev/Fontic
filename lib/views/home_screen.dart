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

  // Categories ki list
  final List<String> _categories = [
    'All',
    'Sans Serif',
    'Serif',
    'Handwriting',
    'Display',
    'Monospace',
  ];
  String _selectedCategory = 'All';

  // Grid vs List State
  bool _isGridView = true;
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  // Search Bar aur Category dono ko handle karta hai
  void _applyFilters() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      Iterable<FontModel> filtered = FontService.getAllFonts();

      if (query.isNotEmpty) {
        filtered = filtered.where(
          (font) => font.name.toLowerCase().contains(query),
        );
      }

      if (_selectedCategory != 'All') {
        filtered = filtered.where(
          (font) => font.guessCategory == _selectedCategory,
        );
      }

      _displayFonts = filtered.take(30).toList(); // Performance limit
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),

        // NAYA: Jab user list ko scroll karega toh keyboard band ho jayega
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

        slivers: [
          // 1. App Bar
          CupertinoSliverNavigationBar(
            largeTitle: const Text("Fontic Vault"),
            backgroundColor: Colors.white.withOpacity(0.8),
            border: null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Toggle Search Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearchVisible = !_isSearchVisible;
                      if (!_isSearchVisible) {
                        _searchController.clear();
                        _applyFilters();
                      }
                    });
                  },
                  child: Icon(
                    _isSearchVisible ? LucideIcons.xCircle : LucideIcons.search,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                // Layout Toggle Button (Grid/List)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _isGridView
                          ? LucideIcons.layoutList
                          : LucideIcons.layoutGrid,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // Favorites Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const FavoritesScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    LucideIcons.heart,
                    color: Colors.black,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),

          // 2. Search Row (Now Toggleable)
          if (_isSearchVisible)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 15),
                child: SearchPill(
                  controller: _searchController,
                  onChanged: (val) => _applyFilters(),
                ),
              ),
            ),

          // 3. Category List
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
                        _applyFilters();
                      });
                    },
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // 4. Generated Cards (GRID OR LIST)
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
                  sliver: _isGridView
                      // GRID VIEW LAYOUT
                      ? SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.85,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final font = _displayFonts[index];
                            return FontCard(
                              key: ValueKey(font.name), // Bug solve key
                              font: font,
                              isDarkTheme: index % 3 == 0,
                              index: index,
                              isGridView: true,
                            );
                          }, childCount: _displayFonts.length),
                        )
                      // LIST VIEW LAYOUT
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final font = _displayFonts[index];
                            return FontCard(
                              key: ValueKey(font.name), // Bug solve key
                              font: font,
                              isDarkTheme: index % 2 != 0,
                              index: index,
                              isGridView: false,
                            );
                          }, childCount: _displayFonts.length),
                        ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
