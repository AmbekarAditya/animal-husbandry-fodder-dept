import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fodder_distribution/core/theme/app_colors.dart';
import 'package:fodder_distribution/core/localization/localization_provider.dart';
import 'package:fodder_distribution/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:fodder_distribution/src/features/records/presentation/records_list_screen.dart';
import 'package:fodder_distribution/src/features/records/presentation/add_record_screen.dart';
import 'package:fodder_distribution/src/features/admin/presentation/admin_panel_screen.dart';
import 'package:fodder_distribution/src/features/map/presentation/map_screen.dart';

class MainNavigationShell extends ConsumerStatefulWidget {
  const MainNavigationShell({super.key});

  @override
  ConsumerState<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends ConsumerState<MainNavigationShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RecordsListScreen(),
    const AddRecordScreen(),
    const AdminPanelScreen(),
    const MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth >= 800;

    // Watch locale and translations
    final currentLocale = ref.watch(localeProvider);
    final translations = ref.watch(translationsProvider);

    final List<String> titles = [
      translations['dashboardTitle'] ?? 'डॅशबोर्ड',
      translations['viewRecordsTitle'] ?? 'सर्व नोंदी पहा',
      translations['addRecordTitle'] ?? 'नवीन नोंद जोडा',
      translations['adminTitle'] ?? 'प्रशासकीय पॅनेल',
      translations['mapTitle'] ?? 'नकाशा व्ह्यू',
    ];

    List<Widget> drawerItems(bool insideDrawer) => [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCFD8DC), width: 0.5),
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.person, size: 40, color: AppColors.primaryGreen),
            ),
            accountName: Text(
              currentLocale == 'mr' ? 'रामचंद्र गायकवाड' : 'Ramchandra Gaikwad',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
            accountEmail: Text(
              currentLocale == 'mr' 
                  ? 'भूमिका: जिल्हा अधिकारी (प्रशासक)' 
                  : 'Role: District Officer (Admin)',
              style: const TextStyle(
                color: AppColors.textDark,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: AppColors.primaryGreen),
            title: Text(translations['dashboardTitle'] ?? 'डॅशबोर्ड (Dashboard)'),
            selected: _selectedIndex == 0,
            selectedTileColor: const Color(0xFFE8F5E9),
            onTap: () {
              setState(() => _selectedIndex = 0);
              if (insideDrawer) Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list, color: AppColors.primaryGreen),
            title: Text(translations['viewRecordsTitle'] ?? 'सर्व नोंदी पहा (View Records)'),
            selected: _selectedIndex == 1,
            selectedTileColor: const Color(0xFFE8F5E9),
            onTap: () {
              setState(() => _selectedIndex = 1);
              if (insideDrawer) Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle, color: AppColors.primaryGreen),
            title: Text(translations['addRecordTitle'] ?? 'नवीन नोंद जोडा (Add Record)'),
            selected: _selectedIndex == 2,
            selectedTileColor: const Color(0xFFE8F5E9),
            onTap: () {
              setState(() => _selectedIndex = 2);
              if (insideDrawer) Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map, color: AppColors.primaryGreen),
            title: Text(translations['mapTitle'] ?? 'नकाशा व्ह्यू (Map View)'),
            selected: _selectedIndex == 4,
            selectedTileColor: const Color(0xFFE8F5E9),
            onTap: () {
              setState(() => _selectedIndex = 4);
              if (insideDrawer) Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings, color: Colors.orange),
            title: Text(
              translations['adminTitle'] ?? 'प्रशासकीय पॅनेल (Admin)',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: _selectedIndex == 3,
            selectedTileColor: const Color(0xFFFFF3E0),
            onTap: () {
              setState(() => _selectedIndex = 3);
              if (insideDrawer) Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(translations['logout'] ?? 'लॉगआउट (Logout)', style: const TextStyle(color: Colors.red)),
            onTap: () {
              if (insideDrawer) Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
        ];

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkBlue),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.darkBlue),
        elevation: 0,
        automaticallyImplyLeading: !isLargeScreen,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ActionChip(
              backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.1),
              side: BorderSide(color: AppColors.primaryGreen.withValues(alpha: 0.3)),
              avatar: const Icon(Icons.translate, size: 16, color: AppColors.primaryGreen),
              label: Text(
                currentLocale == 'mr' ? 'English' : 'मराठी',
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                ref.read(localeProvider.notifier).toggleLocale();
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
            ),
          ),
        ),
      ),
      drawer: !isLargeScreen
          ? Drawer(child: Column(children: [...drawerItems(true)]))
          : null,
      body: Row(
        children: [
          if (isLargeScreen)
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Column(
                children: [...drawerItems(false)],
              ),
            ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }
}
