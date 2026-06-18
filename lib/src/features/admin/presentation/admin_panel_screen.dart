import 'package:flutter/material.dart';
import 'package:fodder_distribution/core/theme/app_colors.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock list of pending staff requests for verification
  final List<Map<String, String>> pendingUsers = [
    {'name': 'सुनील देशमुख', 'taluka': 'शिरूर', 'role': 'डाटा एंट्री ऑपरेटर'},
    {'name': 'अमित भोसले', 'taluka': 'बारामती', 'role': 'निरीक्षक (Viewer)'},
    {'name': 'स्वाती कुलकर्णी', 'taluka': 'हवेली', 'role': 'डाटा एंट्री ऑपरेटर'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab bar configuration header
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryGreen,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.primaryGreen,
            indicatorWeight: 3,
            tabs: const [
              Tab(icon: Icon(Icons.people_outline), text: 'वापरकर्ता मंजूरी'),
              Tab(icon: Icon(Icons.upload_file_outlined), text: 'एकत्रित डेटा (Bulk Upload)'),
            ],
          ),
        ),
        
        // Dynamic content split by selected tabs
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildUserApprovalsTab(),
              _buildBulkUploadTab(),
            ],
          ),
        ),
      ],
    );
  }

  // Tab View 1: Handling User Role Approvals
  Widget _buildUserApprovalsTab() {
    if (pendingUsers.isEmpty) {
      return const Center(
        child: Text('कोणतेही प्रलंबित अर्ज नाहीत.', style: TextStyle(fontSize: 16)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: pendingUsers.length,
      itemBuilder: (context, index) {
        final user = pendingUsers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const CircleAvatar(
              backgroundColor: AppColors.darkBlue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              user['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            subtitle: Text('तालुका: ${user['taluka']} | भूमिका: ${user['role']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Reject Button
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.redAccent),
                  onPressed: () {
                    setState(() {
                      pendingUsers.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('अर्ज फेटाळला गेला.')),
                    );
                  },
                ),
                // Approve Button
                IconButton(
                  icon: const Icon(Icons.check_circle, color: AppColors.primaryGreen),
                  onPressed: () {
                    setState(() {
                      pendingUsers.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('वापरकर्ता यशस्वीरित्या मंजूर केला!')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Tab View 2: Excel / CSV parsing dashboard interface layout
  Widget _buildBulkUploadTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Interactive visual card dropzone mockup
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textLight.withOpacity(0.3), style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                const Icon(Icons.cloud_upload, size: 64, color: AppColors.darkBlue),
                const SizedBox(height: 16),
                const Text(
                  'तुमची एक्सेल किंवा सीएसव्ही (.xlsx / .csv) फाईल निवडा',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 6),
                const Text(
                  'बियाणे वितरण सद्यस्थितीची मूळ फाईल येथे अपलोड करा',
                  style: TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // This is where file_picker processing logic executes
                    _mockFileSelection();
                  },
                  icon: const Icon(Icons.folder_open),
                  label: const Text('फाईल शोधा (Browse)'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Informational Warning Note Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.amber.shade900),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'टीप: अपलोड करण्यापूर्वी फाईलमधील कॉलम्सचे नाव मूळ संरचनेशी (जिल्हा, तालुका, हंगाम, लक्ष्यांक) जुळत असल्याची खात्री करा.',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _mockFileSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'निवडलेली फाईल आढळली:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const ListTile(
                leading: Icon(Icons.insert_drive_file, color: Colors.green),
                title: Text('बियाणे वितरण सद्यस्थिती (1).xlsx'),
                subtitle: Text('आकार: २४.५ KB'),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('रद्द करा'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('डेटा यशस्वीरित्या प्रोसेस करून डेटाबेसमध्ये समाविष्ट केला!')),
                      );
                    },
                    child: const Text('अपलोड करा', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
