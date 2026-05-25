import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Media query to handle responsiveness across different display sizes
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          'पशुसंवर्धन विभाग (चारा विकास)',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome & User Profile Summary Banner
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

            // Performance Target Progress Section
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

            // Responsive Data Grid Metrics
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
                // Mocking data directly aligned to your Excel structure
                List<Map<String, dynamic>> summaryMetrics = [
                  {'title': 'लक्ष्यांक क्षेत्र', 'val': '१,२५०', 'unit': 'हे.', 'icon': Icons.g_translate, 'color': Colors.blue},
                  {'title': 'लक्ष्यांक परिमाण', 'val': '४,८००', 'unit': 'क्विं.', 'icon': Icons.layers, 'color': Colors.orange},
                  {'title': 'वितरित परिमाण', 'val': '३,७६८', 'unit': 'क्विं.', 'icon': Icons.local_shipping, 'color': AppColors.primaryGreen},
                  {'title': 'साध्य लाभार्थी', 'val': '८४५', 'unit': 'शेतकरी', 'icon': Icons.people, 'color': Colors.purple},
                ];
                return SummaryCard(
                  title: summaryMetrics[index]['title'],
                  value: summaryMetrics[index]['val'],
                  unit: summaryMetrics[index]['unit'],
                  icon: summaryMetrics[index]['icon'],
                  iconColor: summaryMetrics[index]['color'],
                );
              },
            ),
            const SizedBox(height: 24),

            // Action Quick Links (Navigation Buttons)
            const Text(
              'जलद पर्याय',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          // Will route to Add Record screen later
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('नवीन नोंद जोडा', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.darkBlue),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          // Will route to Records screen later
                        },
                        icon: const Icon(Icons.view_list, color: AppColors.darkBlue),
                        label: const Text('सर्व नोंदी पहा', style: TextStyle(color: AppColors.darkBlue, fontSize: 15)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      context.push('/map');
                    },
                    icon: const Icon(Icons.map, color: Colors.white),
                    label: const Text('नकाशा पहा (View Map)', style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
