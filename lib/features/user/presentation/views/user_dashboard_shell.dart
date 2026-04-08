import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/dashboard_scaffold.dart';
import 'user_pages.dart';

class UserDashboardShell extends StatefulWidget {
  const UserDashboardShell({super.key});

  @override
  State<UserDashboardShell> createState() => _UserDashboardShellState();
}

class _UserDashboardShellState extends State<UserDashboardShell> {
  int _selectedIndex = 0;

  static const _destinations = <DashboardDestination>[
    DashboardDestination(label: 'Home', icon: Icons.home_outlined),
    DashboardDestination(label: 'Family Tree', icon: Icons.account_tree_outlined),
    DashboardDestination(label: 'Events', icon: Icons.event_outlined),
    DashboardDestination(label: 'Suggestions', icon: Icons.lightbulb_outline),
    DashboardDestination(label: 'Digital Library', icon: Icons.folder_outlined),
    DashboardDestination(label: 'Video Library', icon: Icons.video_library_outlined),
    DashboardDestination(label: 'Profile', icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const UserHomePage(),
      const FamilyTreePage(),
      AddEventLauncher(onOpen: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const AddEventPage()),
        );
      }),
      const SuggestionsPage(),
      const DigitalLibraryPage(),
      const VideoLibraryPage(),
      const ProfilePage(),
    ];

    return DashboardScaffold(
      title: 'User Dashboard',
      destinations: _destinations,
      selectedIndex: _selectedIndex,
      onSelect: (index) => setState(() => _selectedIndex = index),
      child: pages[_selectedIndex],
    );
  }
}
