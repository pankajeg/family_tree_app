import 'package:flutter/material.dart';

class DashboardDestination {
  const DashboardDestination({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({
    super.key,
    required this.title,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelect,
    required this.child,
    this.floatingActionButton,
  });

  final String title;
  final List<DashboardDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;

    if (isDesktop) {
      final rail = NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelect,
        labelType: NavigationRailLabelType.all,
        destinations: [
          for (final destination in destinations)
            NavigationRailDestination(
              icon: Icon(destination.icon),
              label: Text(destination.label),
            ),
        ],
      );

      final content = Column(
        children: [
          _TopHeader(title: title),
          Expanded(child: child),
        ],
      );

      return Scaffold(
        body: Row(
          children: isRtl
              ? <Widget>[Expanded(child: content), rail]
              : <Widget>[rail, Expanded(child: content)],
        ),
        floatingActionButton: floatingActionButton,
      );
    }

    final drawer = Drawer(
      child: SafeArea(
        child: ListView.builder(
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            final destination = destinations[index];
            return ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.label),
              selected: selectedIndex == index,
              onTap: () {
                Navigator.of(context).pop();
                onSelect(index);
              },
            );
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [_HeaderActions()],
      ),
      drawer: isRtl ? null : drawer,
      endDrawer: isRtl ? drawer : null,
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            const SizedBox(
              width: 260,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(child: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(
          width: 160,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        CircleAvatar(child: Icon(Icons.person)),
        SizedBox(width: 12),
      ],
    );
  }
}
