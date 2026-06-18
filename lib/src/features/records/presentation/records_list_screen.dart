import 'package:flutter/material.dart';
import 'package:fodder_distribution/core/theme/app_colors.dart';
import 'package:fodder_distribution/core/utils/mock_data.dart';
import 'package:fodder_distribution/models/fodder_distribution_model.dart';

class RecordsListScreen extends StatefulWidget {
  const RecordsListScreen({super.key});

  @override
  State<RecordsListScreen> createState() => _RecordsListScreenState();
}

class _RecordsListScreenState extends State<RecordsListScreen> {
  List<FodderDistributionModel> displayedRecords = List.from(mockFodderRecords);
  String searchQuery = "";

  void _filterSearch(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        displayedRecords = List.from(mockFodderRecords);
      } else {
        displayedRecords = mockFodderRecords.where((record) {
          final searchLower = query.toLowerCase();
          return record.taluka.toLowerCase().contains(searchLower) || 
                 record.jilha.toLowerCase().contains(searchLower) || 
                 record.pikacheNav.toLowerCase().contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Live Search Bar Section
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            onChanged: _filterSearch,
            decoration: InputDecoration(
              hintText: 'तालुका, जिल्हा किंवा पिकाचे नाव शोधा...',
              prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        
        // Records List View
        Expanded(
          child: displayedRecords.isEmpty
              ? const Center(child: Text('कोणतीही नोंद सापडली नाही.', style: TextStyle(fontSize: 16)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: displayedRecords.length,
                  itemBuilder: (context, index) {
                    final record = displayedRecords[index];
                    
                    final Color statusColor = record.sadhyaTakkevari >= 75.0 
                        ? AppColors.primaryGreen 
                        : Colors.orange.shade700;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${record.taluka} (${record.jilha})',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkBlue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    record.hangam,
                                    style: const TextStyle(fontSize: 12, color: AppColors.darkBlue, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 16),
                            
                            Row(
                              children: [
                                const Icon(Icons.grass, color: AppColors.secondaryGreen, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  'पिकाचे नाव: ${record.pikacheNav} (${record.van})',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('लक्ष्यांक परिमाण', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                                    Text('${record.lakshyankParimanKvin} क्विंटल', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('वितरित परिमाण', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                                    Text('${record.vitaritParimanKvin} क्विंटल', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('साध्य टक्केवारी', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                                    Text(
                                      '${record.sadhyaTakkevari}%', 
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
