import 'package:ashfoam_sadiq/src/features/sync/providers/sync_providers.dart';
import 'package:ashfoam_sadiq/src/features/settings/widgets/tax_settings_card.dart';
import 'package:ashfoam_sadiq/src/features/settings/widgets/company_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _branchNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _managerController = TextEditingController();

  @override
  void dispose() {
    _branchNameController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _managerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Manage your store configuration and account preferences.",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const CompanySettingsCard(),
                            const SizedBox(height: 24),
                            _buildSystemCard(),
                            const SizedBox(height: 24),
                            const TaxSettingsCard(),
                          ],
                        ),
                      ),
                    ],
                  )
                else ...[
                  const CompanySettingsCard(),
                  const SizedBox(height: 24),
                  _buildSystemCard(),
                  const SizedBox(height: 24),
                  const TaxSettingsCard(),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemCard() {
    final syncState = ref.watch(bulkSyncProvider);

    return FCard(
      title: const Text("Bulk Data Synchronization"),
      subtitle: const Text("Push unsynced local data securely to the cloud."),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Remote Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (syncState is AsyncLoading)
                    const Text(
                      "Syncing...",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    )
                  else if (syncState.hasError)
                    Text(
                      "Error: ${syncState.error}",
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    )
                  else
                    Text(
                      syncState.value ?? "All clear",
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                ],
              ),
              FButton(
                variant: FButtonVariant.outline,
                onPress: syncState is AsyncLoading
                    ? null
                    : () async {
                        await ref
                            .read(bulkSyncProvider.notifier)
                            .uploadAllUnsynced();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync operation triggered.'),
                            ),
                          );
                        }
                      },
                child: syncState is AsyncLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Publish to Cloud"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          FutureBuilder<Map<String, int>>(
            future: ref.read(bulkSyncProvider.notifier).getPendingCounts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  "Calculating pending records...",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                );
              }
              final data = snapshot.data ?? {};
              final total = data.values.fold(0, (sum, val) => sum + val);

              if (total == 0) {
                return const Text(
                  "No pending unsynced records found.",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$total pending item(s) to publish:",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...data.entries
                      .where((e) => e.value > 0)
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.key,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                e.value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
