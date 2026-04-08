import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/dashboard_scaffold.dart';
import 'admin_pages.dart';

class AdminDashboardShell extends StatefulWidget {
  const AdminDashboardShell({super.key});

  @override
  State<AdminDashboardShell> createState() => _AdminDashboardShellState();
}

class _AdminDashboardShellState extends State<AdminDashboardShell> {
  int _selectedIndex = 0;

  static const _destinations = <DashboardDestination>[
    DashboardDestination(label: 'Overview', icon: Icons.dashboard_outlined),
    DashboardDestination(label: 'Family Tree', icon: Icons.account_tree_outlined),
    DashboardDestination(label: 'Manage Events', icon: Icons.event_note_outlined),
    DashboardDestination(label: 'Suggestions', icon: Icons.tips_and_updates_outlined),
    DashboardDestination(label: 'File Management', icon: Icons.folder_shared_outlined),
    DashboardDestination(label: 'Settings', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const AdminOverviewPage(),
      const ManageFamilyTreePage(),
      const ManageEventsPage(),
      const ManageSuggestionsPage(),
      const FileManagementPage(),
      const AdminSettingsPage(),
    ];

    return DashboardScaffold(
      title: 'Admin Dashboard',
      destinations: _destinations,
      selectedIndex: _selectedIndex,
      onSelect: (index) => setState(() => _selectedIndex = index),
      child: pages[_selectedIndex],
    );
  }
}
