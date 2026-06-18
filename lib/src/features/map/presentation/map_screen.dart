import 'package:flutter/material.dart';
import 'package:fodder_distribution/core/theme/app_colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 70, color: AppColors.primaryGreen.withOpacity(0.7)),
            const SizedBox(height: 16),
            const Text(
              'भौगोलिक नकाशा व्ह्यू (GIS Mapping)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 6),
            const Text(
              'येथे महाराष्ट्राच्या नकाशावर जिल्हावार वितरण सद्यस्थिती दिसेल.',
              style: TextStyle(fontSize: 14, color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
