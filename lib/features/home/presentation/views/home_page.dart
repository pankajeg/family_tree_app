import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/family_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersState = ref.watch(familyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Tree'),
      ),
      body: membersState.when(
        data: (members) {
          if (members.isEmpty) {
            return const Center(child: Text('No family members found.'));
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(familyViewModelProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: members.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final member = members[index];
                return Card(
                  child: ListTile(
                    title: Text(member.name),
                    subtitle: Text(member.relationship),
                    trailing: member.parentId == null
                        ? const Icon(Icons.account_tree_outlined)
                        : Text('Parent: ${member.parentId}'),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Something went wrong while loading the family tree.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(familyViewModelProvider.notifier).refresh(),
                  child: const Text('Try again'),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
