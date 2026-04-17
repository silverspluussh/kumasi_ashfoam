import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/models/branch.model.dart';
import 'package:ashfoam_sadiq/src/features/settings/providers/settings_providers.dart';
import 'package:ashfoam_sadiq/src/features/settings/widgets/tax_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:drift/drift.dart' as drift;

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

  void _loadBranchData(Branche branch) {
    _branchNameController.text = branch.branchName;
    _addressController.text = branch.branchAddress ?? '';
    _contactController.text = branch.contact ?? '';
    _managerController.text = branch.branchManagerName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final branchAsync = ref.watch(branchSettingsProvider);

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
            branchAsync.when(
              data: (branch) {
                if (branch != null && !_isLoading) {
                  _loadBranchData(branch);
                }
                final isWide = MediaQuery.of(context).size.width > 900;
                return Column(
                  children: [
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildBranchCard(branch)),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              children: [
                                _buildAccountCard(),
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
                      _buildBranchCard(branch),
                      const SizedBox(height: 24),
                      _buildAccountCard(),
                      const SizedBox(height: 24),
                      _buildSystemCard(),
                      const SizedBox(height: 24),
                      const TaxSettingsCard(),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('Error loading settings: $err')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard(Branche? branch) {
    return FCard(
      title: const Text("Company Profile"),
      subtitle: const Text(
        "Information used for receipts and official reports.",
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildField(
            label: "Branch Name",
            controller: _branchNameController,
            hint: "e.g. Kumasi Central Branch",
            icon: Icons.storefront,
          ),
          const SizedBox(height: 16),
          _buildField(
            label: "Physical Address",
            controller: _addressController,
            hint: "Enter location details",
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 16),
          _buildField(
            label: "Contact Number",
            controller: _contactController,
            hint: "+233 ...",
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 16),
          _buildField(
            label: "Branch Manager",
            controller: _managerController,
            hint: "Full Name",
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 24),
          FButton(
            onPress: () async {
              if (branch == null) return;
              setState(() => _isLoading = true);
              try {
                final companion = BranchesCompanion(
                  branchName: drift.Value(_branchNameController.text),
                  branchAddress: drift.Value(_addressController.text),
                  contact: drift.Value(_contactController.text),
                  branchManagerName: drift.Value(_managerController.text),
                );
                await ref.read(updateBranchSettingsProvider)(
                  branch.id,
                  companion,
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully"),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Update failed: $e")));
                }
              } finally {
                setState(() => _isLoading = false);
              }
            },
            child: const Text("Save Changes"),
          ),
        ],
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
        ],
      ),
    );
  }

  Widget _buildSystemCard() {
    return FCard(
      title: const Text("System & Data"),
      subtitle: const Text("App versioning and data synchronization."),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Synced",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Today at 09:45 AM",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              FButton(
                variant: FButtonVariant.outline,
                onPress: () {},
                child: const Text("Force Sync"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("App Version", style: TextStyle(color: Colors.grey[600])),
              const Text(
                "v1.2.4 (Build 45)",
                style: TextStyle(fontWeight: FontWeight.bold),
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
