import 'package:flutter/material.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('Members', '1,242'),
      ('Events', '318'),
      ('Suggestions', '76'),
      ('Generations', '8'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (_, i) {
            final (title, value) = cards[i];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    const Spacer(),
                    Text(value, style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Text('Bar Chart', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        const _ChartPlaceholder(type: 'bar'),
        const SizedBox(height: 16),
        Text('Line Chart', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        const _ChartPlaceholder(type: 'line'),
      ],
    );
  }
}

class _ChartPlaceholder extends StatelessWidget {
  const _ChartPlaceholder({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.teal.withValues(alpha: 0.09),
      ),
      alignment: Alignment.center,
      child: Text(type == 'bar' ? 'Bar Graph Placeholder' : 'Line Graph Placeholder'),
    );
  }
}

class ManageFamilyTreePage extends StatelessWidget {
  const ManageFamilyTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.person_add), label: const Text('Add Member')),
            const SizedBox(width: 10),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit), label: const Text('Edit Member')),
            const SizedBox(width: 10),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.delete_outline), label: const Text('Delete Member')),
          ],
        ),
        const SizedBox(height: 14),
        const Card(
          child: ExpansionTile(
            title: Text('Tree View Root: Family A'),
            children: [
              ListTile(title: Text('Child Node 1')),
              ListTile(title: Text('Child Node 2')),
            ],
          ),
        ),
      ],
    );
  }
}

class ManageEventsPage extends StatelessWidget {
  const ManageEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Event Name')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: List<DataRow>.generate(
          8,
          (index) => DataRow(
            cells: [
              DataCell(Text('Event ${index + 1}')),
              const DataCell(Text('Pending')),
              DataCell(
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Approve')),
                    TextButton(onPressed: () {}, child: const Text('Reject')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ManageSuggestionsPage extends StatefulWidget {
  const ManageSuggestionsPage({super.key});

  @override
  State<ManageSuggestionsPage> createState() => _ManageSuggestionsPageState();
}

class _ManageSuggestionsPageState extends State<ManageSuggestionsPage> {
  String _status = 'pending';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _status,
          decoration: const InputDecoration(
            labelText: 'Status Filter',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'pending', child: Text('Pending')),
            DropdownMenuItem(value: 'accepted', child: Text('Accepted')),
            DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
          ],
          onChanged: (value) => setState(() => _status = value ?? 'pending'),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          6,
          (i) => Card(
            child: ListTile(
              title: Text('Suggestion ${i + 1}'),
              subtitle: Text('Status: ${_status.toUpperCase()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle_outline)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.cancel_outlined)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FileManagementPage extends StatefulWidget {
  const FileManagementPage({super.key});

  @override
  State<FileManagementPage> createState() => _FileManagementPageState();
}

class _FileManagementPageState extends State<FileManagementPage> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search files',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 180,
              child: DropdownButtonFormField<String>(
                initialValue: _filter,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All')),
                  DropdownMenuItem(value: 'images', child: Text('Images')),
                  DropdownMenuItem(value: 'docs', child: Text('Docs')),
                ],
                onChanged: (value) => setState(() => _filter = value ?? 'all'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('File Name')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Owner')),
              DataColumn(label: Text('Uploaded')),
            ],
            rows: List.generate(
              10,
              (i) => DataRow(
                cells: [
                  DataCell(Text('file_${i + 1}.pdf')),
                  const DataCell(Text('Document')),
                  const DataCell(Text('Admin')),
                  const DataCell(Text('2026-04-07')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  bool _adminPermission = true;
  bool _memberPermission = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Role Management', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const Card(child: ListTile(title: Text('Admin'))),
        const Card(child: ListTile(title: Text('Member'))),
        const SizedBox(height: 16),
        Text('Permissions', style: Theme.of(context).textTheme.titleLarge),
        CheckboxListTile(
          title: const Text('Admin Permission'),
          value: _adminPermission,
          onChanged: (v) => setState(() => _adminPermission = v ?? true),
        ),
        CheckboxListTile(
          title: const Text('Member Permission'),
          value: _memberPermission,
          onChanged: (v) => setState(() => _memberPermission = v ?? true),
        ),
        const SizedBox(height: 16),
        Text('Audit Logs', style: Theme.of(context).textTheme.titleLarge),
        ...List.generate(
          5,
          (i) => const Card(
            child: ListTile(
              title: Text('Role changed'),
              subtitle: Text('2026-04-07 11:40'),
            ),
          ),
        ),
      ],
    );
  }
}
