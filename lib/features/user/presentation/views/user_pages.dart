import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  int _columnsForWidth(double width) {
    if (width >= 1440) return 6;
    if (width >= 768) return 4;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Family Memories Gallery', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _columnsForWidth(width),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, i) => Card(
            child: Center(child: Text('Memory ${i + 1}')),
          ),
        ),
        const SizedBox(height: 16),
        Text('Recent Events', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (_, i) => SizedBox(
              width: 220,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event ${i + 1}', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      const Text('Wedding / Birth / Reunion'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Notifications', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        ...List.generate(
          4,
          (i) => Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_none),
              title: Text('Notification ${i + 1}'),
              subtitle: const Text('A new update is available.'),
            ),
          ),
        ),
      ],
    );
  }
}

class FamilyTreePage extends StatelessWidget {
  const FamilyTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Family Tree Visualization'),
          SizedBox(height: 12),
          Card(
            child: ExpansionTile(
              title: Text('Grandparent: Ahmed'),
              children: [
                ListTile(title: Text('Parent: Omar')),
                ListTile(title: Text('Parent: Sara')),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text('Grandparent: Fatima'),
              children: [
                ListTile(title: Text('Parent: Leila')),
                ListTile(title: Text('Parent: Youssef')),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: const Text('Add Member'),
        icon: const Icon(Icons.person_add_alt_1),
      ),
    );
  }
}

class AddEventLauncher extends StatelessWidget {
  const AddEventLauncher({required this.onOpen, super.key});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return EventsPage(onAddEvent: onOpen);
  }
}

class EventsPage extends StatelessWidget {
  const EventsPage({required this.onAddEvent, super.key});

  final VoidCallback onAddEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 320,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (_, i) => Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  color: Colors.teal.withValues(alpha: 0.12),
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_outlined),
                ),
                const SizedBox(height: 8),
                Text('Event Title ${i + 1}'),
                const Text('Category: wedding'),
                const Spacer(),
                const Row(
                  children: [
                    Icon(Icons.favorite_border, size: 18),
                    SizedBox(width: 6),
                    Text('23'),
                    SizedBox(width: 14),
                    Icon(Icons.comment_outlined, size: 18),
                    SizedBox(width: 6),
                    Text('6'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddEvent,
        label: const Text('Add Event'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'wedding';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _category,
            items: const [
              DropdownMenuItem(value: 'wedding', child: Text('Wedding')),
              DropdownMenuItem(value: 'birth', child: Text('Birth')),
              DropdownMenuItem(value: 'engagement', child: Text('Engagement')),
            ],
            onChanged: (value) => setState(() => _category = value ?? 'wedding'),
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Image'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({super.key});

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  String _category = 'all';
  String _priority = 'medium';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All')),
                      DropdownMenuItem(value: 'events', child: Text('Events')),
                      DropdownMenuItem(value: 'members', child: Text('Members')),
                    ],
                    onChanged: (value) => setState(() => _category = value ?? 'all'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _priority,
                    decoration: const InputDecoration(labelText: 'Priority'),
                    items: const [
                      DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
                      DropdownMenuItem(value: 'high', child: Text('High')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'low', child: Text('Low')),
                    ],
                    onChanged: (value) => setState(() => _priority = value ?? 'medium'),
                  ),
                ),
              ],
            ),
          ),
          const TabBar(tabs: [Tab(text: 'Pending'), Tab(text: 'Accepted'), Tab(text: 'Rejected')]),
          Expanded(
            child: TabBarView(
              children: [for (final status in ['Pending', 'Accepted', 'Rejected']) _SuggestionsList(status: status)],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionsList extends StatelessWidget {
  const _SuggestionsList({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 8,
      itemBuilder: (_, i) => Card(
        child: ListTile(
          title: Text('$status Suggestion ${i + 1}'),
          subtitle: const Text('Category: Events | Priority: High'),
        ),
      ),
    );
  }
}

class DigitalLibraryPage extends StatefulWidget {
  const DigitalLibraryPage({super.key});

  @override
  State<DigitalLibraryPage> createState() => _DigitalLibraryPageState();
}

class _DigitalLibraryPageState extends State<DigitalLibraryPage> {
  String _type = 'all';
  String _language = 'all';
  String _category = 'all';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(width: 180, child: _dropdown('Type', _type, ['all', 'pdf', 'doc'], (v) => _type = v)),
            SizedBox(width: 180, child: _dropdown('Language', _language, ['all', 'en', 'ar'], (v) => _language = v)),
            SizedBox(width: 180, child: _dropdown('Category', _category, ['all', 'history', 'events'], (v) => _category = v)),
            FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_file), label: const Text('Upload')),
          ],
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (_, i) => Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.insert_drive_file_outlined, size: 42),
                const SizedBox(height: 10),
                Text('File ${i + 1}'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown(String label, String value, List<String> values, ValueChanged<String> setter) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: [for (final item in values) DropdownMenuItem(value: item, child: Text(item.toUpperCase()))],
      onChanged: (selected) {
        setState(() {
          setter(selected ?? values.first);
        });
      },
    );
  }
}

class VideoLibraryPage extends StatefulWidget {
  const VideoLibraryPage({super.key});

  @override
  State<VideoLibraryPage> createState() => _VideoLibraryPageState();
}

class _VideoLibraryPageState extends State<VideoLibraryPage> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const Text('Privacy Toggle'),
            const SizedBox(width: 10),
            Switch(value: _isPrivate, onChanged: (v) => setState(() => _isPrivate = v)),
            const Spacer(),
            FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.upload), label: const Text('Upload Video')),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 280,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (_, i) => Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_circle_outline, size: 50),
                const SizedBox(height: 8),
                Text('Video ${i + 1}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
        const SizedBox(height: 12),
        Text('Profile Info', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const Card(child: ListTile(title: Text('Name'), subtitle: Text('Amina Ali'))),
        const Card(child: ListTile(title: Text('Email'), subtitle: Text('amina@example.com'))),
        const SizedBox(height: 10),
        FilledButton(onPressed: () {}, child: const Text('Edit Profile')),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: () {}, child: const Text('Change Password')),
        SwitchListTile(
          value: _notifications,
          title: const Text('Notifications'),
          onChanged: (value) => setState(() => _notifications = value),
        ),
      ],
    );
  }
}
