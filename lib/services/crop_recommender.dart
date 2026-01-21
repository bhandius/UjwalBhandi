class CropRecommender {
  /// Recommend crops based on soil pH
  static List<String> recommendCrop(double ph) {
    if (ph < 5.5) {
      return [
        'Tea',
        'Pineapple',
        'Blueberry',
        'Strawberry',
        'Raspberry',
        'Potato (some varieties)',
      ];
    } else if (ph >= 5.5 && ph < 6.5) {
      return [
        'Rice',
        'Potato',
        'Tomato',
        'Pepper',
        'Carrot',
        'Sweet Potato',
        'Corn',
      ];
    } else if (ph >= 6.5 && ph <= 7.5) {
      return [
        'Wheat',
        'Maize',
        'Pulses',
        'Soybean',
        'Cabbage',
        'Lettuce',
        'Beans',
        'Peas',
      ];
    } else if (ph > 7.5 && ph <= 8.5) {
      return [
        'Cotton',
        'Barley',
        'Sugarcane',
        'Alfalfa',
        'Asparagus',
        'Spinach',
      ];
    } else {
      return [
        'Salt-tolerant crops',
        'Beetroot',
        'Brussels Sprouts',
        'Cabbage (some varieties)',
      ];
    }
  }

  /// Get detailed crop information
  static String getCropInfo(String cropName) {
    final cropInfo = {
      'Tea': 'Prefers acidic soil (pH 4.5-5.5). Requires well-drained soil.',
      'Pineapple': 'Thrives in acidic soil (pH 4.5-6.5). Needs good drainage.',
      'Blueberry': 'Requires highly acidic soil (pH 4.0-5.5).',
      'Rice': 'Grows well in slightly acidic to neutral soil (pH 5.5-7.0).',
      'Potato': 'Prefers slightly acidic soil (pH 5.0-6.5).',
      'Tomato': 'Best in slightly acidic soil (pH 6.0-6.8).',
      'Wheat': 'Optimal in neutral soil (pH 6.5-7.5).',
      'Maize': 'Grows best in neutral to slightly alkaline soil (pH 6.0-7.5).',
      'Pulses': 'Prefer neutral soil (pH 6.5-7.5).',
      'Cotton': 'Thrives in slightly alkaline soil (pH 7.5-8.5).',
      'Barley': 'Grows well in alkaline soil (pH 7.0-8.5).',
      'Sugarcane': 'Prefers neutral to alkaline soil (pH 6.5-8.0).',
    };

    return cropInfo[cropName] ?? 'Crop information not available.';
  }
}
