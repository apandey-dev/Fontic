class FontModel {
  final String name;

  FontModel({required this.name});

  // String match karke category guess karne ka ek smart tareeqa
  String get guessCategory {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('sans')) return 'Sans Serif';
    if (lowerName.contains('serif')) return 'Serif';
    if (lowerName.contains('mono')) return 'Monospace';
    if (lowerName.contains('hand')) return 'Handwriting';
    return 'Display';
  }
}
