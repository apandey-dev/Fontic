import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/font_model.dart';
import '../services/storage_service.dart';
import '../widgets/font_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F7), 
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF2F2F7),
          appBar: AppBar(
            title: const Text("Liked Fonts"),
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: ValueListenableBuilder<List<String>>(
            valueListenable: StorageService.likedFontsNotifier,
            builder: (context, likedList, child) {
              if (likedList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.heart_slash,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No favorites yet!",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemCount: likedList.length,
                itemBuilder: (context, index) {
                  final font = FontModel(name: likedList[index]);
                  return FontCard(font: font, isDarkTheme: true, index: index);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
