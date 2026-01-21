import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class PHDetector {
  /// Detects soil pH from an image of a pH strip
  /// Returns a pH value between 0-14
  static Future<double> detectPH(File imageFile) async {
    try {
      // Read image bytes
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);

      if (image == null) {
        return 7.0; // Default neutral pH
      }

      // Extract dominant color from the center region (where pH strip usually is)
      final int centerX = image.width ~/ 2;
      final int centerY = image.height ~/ 2;
      final int sampleSize = 50; // Sample area size

      int totalR = 0, totalG = 0, totalB = 0;
      int pixelCount = 0;

      // Sample pixels from center region
      for (int y = centerY - sampleSize ~/ 2; 
           y < centerY + sampleSize ~/ 2 && y < image.height; 
           y++) {
        for (int x = centerX - sampleSize ~/ 2; 
             x < centerX + sampleSize ~/ 2 && x < image.width; 
             x++) {
          if (x >= 0 && y >= 0) {
            final pixel = image.getPixel(x, y);
            totalR += img.getRed(pixel);
            totalG += img.getGreen(pixel);
            totalB += img.getBlue(pixel);
            pixelCount++;
          }
        }
      }

      if (pixelCount == 0) {
        return 7.0;
      }

      final int avgR = totalR ~/ pixelCount;
      final int avgG = totalG ~/ pixelCount;
      final int avgB = totalB ~/ pixelCount;

      // Convert RGB to HSV for better color analysis
      final hsv = _rgbToHsv(avgR, avgG, avgB);
      final double hue = hsv[0];
      final double saturation = hsv[1];
      final double value = hsv[2];

      // pH detection based on color analysis
      // pH strips typically show:
      // Red/Orange → Acidic (pH < 6)
      // Yellow/Green → Neutral (pH 6-7.5)
      // Blue/Purple → Alkaline (pH > 7.5)

      double ph;

      if (hue < 30 || hue > 330) {
        // Red range - Acidic
        ph = 4.0 + (hue / 30) * 1.5;
      } else if (hue >= 30 && hue < 90) {
        // Yellow/Green range - Slightly acidic to neutral
        ph = 5.5 + ((hue - 30) / 60) * 2.0;
      } else if (hue >= 90 && hue < 180) {
        // Green/Cyan range - Neutral
        ph = 6.5 + ((hue - 90) / 90) * 1.5;
      } else if (hue >= 180 && hue < 270) {
        // Cyan/Blue range - Slightly alkaline
        ph = 7.5 + ((hue - 180) / 90) * 1.5;
      } else {
        // Blue/Purple range - Alkaline
        ph = 9.0 + ((hue - 270) / 60) * 2.0;
      }

      // Adjust based on saturation and value
      if (saturation < 0.3) {
        // Low saturation might indicate neutral
        ph = ph * 0.7 + 7.0 * 0.3;
      }

      // Clamp pH between 0-14
      ph = ph.clamp(0.0, 14.0);

      // Round to 1 decimal place
      return double.parse(ph.toStringAsFixed(1));
    } catch (e) {
      // Return default neutral pH on error
      return 7.0;
    }
  }

  /// Convert RGB to HSV color space
  static List<double> _rgbToHsv(int r, int g, int b) {
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    final double rNorm = r / 255.0;
    final double gNorm = g / 255.0;
    final double bNorm = b / 255.0;

    final double max = [rNorm, gNorm, bNorm].reduce((a, b) => a > b ? a : b);
    final double min = [rNorm, gNorm, bNorm].reduce((a, b) => a < b ? a : b);
    final double delta = max - min;

    double hue = 0;
    if (delta != 0) {
      if (max == rNorm) {
        hue = 60 * (((gNorm - bNorm) / delta) % 6);
      } else if (max == gNorm) {
        hue = 60 * (((bNorm - rNorm) / delta) + 2);
      } else {
        hue = 60 * (((rNorm - gNorm) / delta) + 4);
      }
    }

    if (hue < 0) hue += 360;

    final double saturation = max == 0 ? 0 : delta / max;
    final double value = max;

    return [hue, saturation, value];
  }

  /// Get pH category description
  static String getPHCategory(double ph) {
    if (ph < 5.5) {
      return 'Highly Acidic';
    } else if (ph < 6.5) {
      return 'Acidic';
    } else if (ph <= 7.5) {
      return 'Neutral';
    } else if (ph <= 8.5) {
      return 'Alkaline';
    } else {
      return 'Highly Alkaline';
    }
  }
}
