import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SoilTest {
  final double ph;
  final List<String> recommendedCrops;
  final DateTime date;
  final String? imagePath;

  SoilTest({
    required this.ph,
    required this.recommendedCrops,
    required this.date,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'ph': ph,
      'recommendedCrops': recommendedCrops,
      'date': date.toIso8601String(),
      'imagePath': imagePath,
    };
  }

  factory SoilTest.fromJson(Map<String, dynamic> json) {
    return SoilTest(
      ph: (json['ph'] as num).toDouble(),
      recommendedCrops: List<String>.from(json['recommendedCrops']),
      date: DateTime.parse(json['date']),
      imagePath: json['imagePath'],
    );
  }
}

class HistoryService {
  static const String _historyKey = 'soil_test_history';

  /// Save a soil test to history
  static Future<void> saveTest(SoilTest test) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];
    
    history.add(jsonEncode(test.toJson()));
    
    await prefs.setStringList(_historyKey, history);
  }

  /// Get all soil tests from history
  static Future<List<SoilTest>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? history = prefs.getStringList(_historyKey);

    if (history == null || history.isEmpty) {
      return [];
    }

    return history.map((jsonString) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SoilTest.fromJson(json);
    }).toList();
  }

  /// Clear all history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  /// Delete a specific test from history
  static Future<void> deleteTest(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];
    
    if (index >= 0 && index < history.length) {
      history.removeAt(index);
      await prefs.setStringList(_historyKey, history);
    }
  }
}
