import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/features/auth/providers/auth_provider.dart';
import 'package:ashfoam_sadiq/src/features/management/providers/management_providers.dart';
import 'package:ashfoam_sadiq/src/features/sync/providers/sync_providers.dart';
import 'package:ashfoam_sadiq/src/features/settings/widgets/tax_settings_card.dart';
import 'package:ashfoam_sadiq/src/features/settings/widgets/company_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

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
  bool _isLoading = false;

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
                            _buildAccountCard(),
                            const SizedBox(height: 24),
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
                  _buildAccountCard(),
                  const SizedBox(height: 24),
                  const CompanySettingsCard(),
                  const SizedBox(height: 24),
                  _buildSystemCard(),
                  const SizedBox(height: 24),
                  _buildQuickAddMetadataCard(),
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

  Widget _buildAccountCard() {
    return FCard(
      title: const Text("Account Settings"),
      subtitle: const Text("Manage your personal login and profile info."),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber.withOpacity(0.1),
                  child: const Icon(Icons.person, color: Colors.amber),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Administrator",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "admin@ashfoam.com",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                FButton(
                  variant: FButtonVariant.ghost,
                  onPress: () {},
                  child: const Text("Edit"),
                ),
              ],
            ),
          ),
          const Divider(),
          FButton(
            variant: FButtonVariant.outline,
            onPress: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_outline, size: 16),
                SizedBox(width: 8),
                Text("Change Password"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FButton(
              variant: FButtonVariant.destructive,
              onPress: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Sign Out"),
                    content: const Text(
                      "Are you sure you want to sign out? You will need an internet connection to sign back in.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "Sign Out",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  ref.read(authNotifierProvider.notifier).signOut();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, size: 16),
                  SizedBox(width: 8),
                  Text("Sign Out"),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildQuickAddMetadataCard() {
    final brandController = TextEditingController();
    final categoryController = TextEditingController();

    return FCard(
      title: const Text("Product Metadata"),
      subtitle: const Text("Quickly add new labels for your inventory."),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FTextField(
                  control: FTextFieldControl.managed(
                    controller: brandController,
                  ),
                  hint: "New Brand...",
                ),
              ),
              const SizedBox(width: 8),
              FButton(
                variant: FButtonVariant.outline,
                onPress: () async {
                  final name = brandController.text.trim();
                  if (name.isEmpty) return;
                  await ref.read(addBrandProvider)(
                    db.ProductBrandsCompanion(
                      id: drift.Value(const Uuid().v4()),
                      name: drift.Value(name),
                      createdAt: drift.Value(DateTime.now()),
                    ),
                  );
                  brandController.clear();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Brand added")),
                    );
                  }
                },
                child: const Icon(Icons.add, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FTextField(
                  control: FTextFieldControl.managed(
                    controller: categoryController,
                  ),
                  hint: "New Category...",
                ),
              ),
              const SizedBox(width: 8),
              FButton(
                variant: FButtonVariant.outline,
                onPress: () async {
                  final name = categoryController.text.trim();
                  if (name.isEmpty) return;
                  await ref.read(addCategoryProvider)(
                    db.ProductCategoriesCompanion(
                      id: drift.Value(const Uuid().v4()),
                      name: drift.Value(name),
                      createdAt: drift.Value(DateTime.now()),
                    ),
                  );
                  categoryController.clear();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Category added")),
                    );
                  }
                },
                child: const Icon(Icons.add, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        FTextField(
          control: FTextFieldControl.managed(controller: controller),
          hint: hint,
        ),
      ],
    );
  }
}
