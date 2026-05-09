import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPill extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchPill({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(CupertinoIcons.search, color: CupertinoColors.systemGrey),
          const SizedBox(width: 10),
          Expanded(
            child: Material(
              type: MaterialType
                  .transparency, // Important for TextField inside custom containers
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: "Search 1500+ fonts...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                // Font family apne aap AppTheme se 'Fredoka' uthayega
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                onChanged('');
                FocusScope.of(context).unfocus();
              },
              child: const Icon(
                CupertinoIcons.clear_circled_solid,
                color: CupertinoColors.systemGrey3,
              ),
            ),
        ],
      ),
    );
  }
}
