import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farming Tips'),
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade50,
              Colors.green.shade50,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildTipCard(
              context,
              'Understanding Soil pH',
              'Soil pH measures acidity or alkalinity on a scale of 0-14. '
              'Neutral pH is 7.0. Most crops prefer slightly acidic to neutral soil (pH 6.0-7.5).',
              Icons.info,
              Colors.blue,
            ),
            const SizedBox(height: 15),
            _buildTipCard(
              context,
              'Acidic Soil (pH < 6.5)',
              '• Add lime to raise pH\n'
              '• Use organic matter like compost\n'
              '• Avoid over-fertilizing with nitrogen\n'
              '• Consider acid-loving crops like blueberries and potatoes',
              Icons.warning_amber,
              Colors.orange,
            ),
            const SizedBox(height: 15),
            _buildTipCard(
              context,
              'Neutral Soil (pH 6.5-7.5)',
              '• Ideal for most crops\n'
              '• Maintain with regular organic matter addition\n'
              '• Test soil annually\n'
              '• Suitable for vegetables, grains, and legumes',
              Icons.check_circle,
              Colors.green,
            ),
            const SizedBox(height: 15),
            _buildTipCard(
              context,
              'Alkaline Soil (pH > 7.5)',
              '• Add sulfur or acidifying fertilizers\n'
              '• Use organic mulches\n'
              '• Consider raised beds with acidic soil\n'
              '• Grow alkaline-tolerant crops like cotton and barley',
              Icons.water_drop,
              Colors.blue,
            ),
            const SizedBox(height: 15),
            _buildTipCard(
              context,
              'General Soil Health Tips',
              '• Test soil pH before planting season\n'
              '• Add compost regularly to improve soil structure\n'
              '• Rotate crops to maintain soil nutrients\n'
              '• Use cover crops to prevent erosion\n'
              '• Monitor soil moisture levels',
              Icons.eco,
              Colors.green,
            ),
            const SizedBox(height: 15),
            _buildTipCard(
              context,
              'pH Testing Best Practices',
              '• Test soil at multiple locations\n'
              '• Test at the same time each year\n'
              '• Take samples from root zone depth\n'
              '• Clean pH strips before use\n'
              '• Test when soil is moist but not wet',
              Icons.science,
              Colors.purple,
            ),
            const SizedBox(height: 15),
            _buildTipCard(
              context,
              'Improving Soil Quality',
              '• Add organic matter (compost, manure)\n'
              '• Practice crop rotation\n'
              '• Use natural fertilizers\n'
              '• Avoid over-tilling\n'
              '• Maintain proper drainage',
              Icons.agriculture,
              Colors.brown,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              content,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
