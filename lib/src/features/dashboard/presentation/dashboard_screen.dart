import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'रामचंद्र गायकवाड (जिल्हा अधिकारी)',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'विभाग: पुणे जिल्हा कार्यालय | भूमिका: प्रशासक',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'एकूण वितरण सद्यस्थिती (चालू हंगाम)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('एकूण साध्य टक्केवारी', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('७८.५%', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const LinearProgressIndicator(
                    value: 0.785,
                    backgroundColor: Colors.black12,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryGreen),
                    minHeight: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              // Updated mock data with trend indicators
              List<Map<String, dynamic>> summaryMetrics = [
                {
                  'title': 'लक्ष्यांक क्षेत्र',
                  'val': '१,२५०',
                  'unit': 'हे.',
                  'icon': Icons.g_translate,
                  'color': Colors.blue,
                  'trend': '+५%',
                  'isPositive': true
                },
                {
                  'title': 'लक्ष्यांक परिमाण',
                  'val': '४,८००',
                  'unit': 'क्विं.',
                  'icon': Icons.layers,
                  'color': Colors.orange,
                  'trend': '+८%',
                  'isPositive': true
                },
                {
                  'title': 'वितरित परिमाण',
                  'val': '३,७६८',
                  'unit': 'क्विं.',
                  'icon': Icons.local_shipping,
                  'color': AppColors.primaryGreen,
                  'trend': '+१२%',
                  'isPositive': true
                },
                {
                  'title': 'साध्य लाभार्थी',
                  'val': '८४५',
                  'unit': 'शेतकरी',
                  'icon': Icons.people,
                  'color': Colors.purple,
                  'trend': '+४%',
                  'isPositive': true
                },
              ];
              
              final metric = summaryMetrics[index];
              
              return SummaryCard(
                title: metric['title'],
                value: metric['val'],
                unit: metric['unit'],
                trend: metric['trend'],
                isPositive: metric['isPositive'],
                icon: metric['icon'],
                iconColor: metric['color'],
                onTap: () {
                  // Action for each card
                },
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'विभागनिहाय प्रगती',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('प्रगती आलेख (Chart Placeholder)')),
          ),
        ],
      ),
    );
  }
}
