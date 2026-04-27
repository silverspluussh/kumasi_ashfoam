import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/features/management/providers/management_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

class BrandCategoryManagementPage extends ConsumerStatefulWidget {
  const BrandCategoryManagementPage({super.key});

  @override
  ConsumerState<BrandCategoryManagementPage> createState() => _BrandCategoryManagementPageState();
}

class _BrandCategoryManagementPageState extends ConsumerState<BrandCategoryManagementPage> {
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _addBrand() async {
    final name = _brandController.text.trim();
    if (name.isEmpty) return;

    final companion = db.ProductBrandsCompanion(
      id: drift.Value(const Uuid().v4()),
      name: drift.Value(name),
      createdAt: drift.Value(DateTime.now()),
    );

    await ref.read(addBrandProvider)(companion);
    _brandController.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Brand added locally")));
    }
  }

  void _addCategory() async {
    final name = _categoryController.text.trim();
    if (name.isEmpty) return;

    final companion = db.ProductCategoriesCompanion(
      id: drift.Value(const Uuid().v4()),
      name: drift.Value(name),
      createdAt: drift.Value(DateTime.now()),
    );

    await ref.read(addCategoryProvider)(companion);
    _categoryController.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Category added locally")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandsAsync = ref.watch(brandListProvider);
    final categoriesAsync = ref.watch(categoryListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Brands & Categories",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            Text(
              "Manage labels used for grouping your inventory products.",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAddCard(
                        title: "New Brand",
                        controller: _brandController,
                        hint: "Enter brand name...",
                        onPress: _addBrand,
                      ),
                      const SizedBox(height: 24),
                      _buildListCard(
                        title: "Existing Brands",
                        itemsAsync: brandsAsync,
                        onDelete: (id) {
                          // TODO: Implement delete if needed
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAddCard(
                        title: "New Category",
                        controller: _categoryController,
                        hint: "Enter category name...",
                        onPress: _addCategory,
                      ),
                      const SizedBox(height: 24),
                      _buildListCard(
                        title: "Existing Categories",
                        itemsAsync: categoriesAsync,
                        onDelete: (id) {
                          // TODO: Implement delete if needed
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCard({
    required String title,
    required TextEditingController controller,
    required String hint,
    required VoidCallback onPress,
  }) {
    return FCard(
      title: Text(title),
      child: Column(
        children: [
          FTextField(
            control: FTextFieldControl.managed(controller: controller),
            hint: hint,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FButton(
              onPress: onPress,
              child: const Text("Create Locally"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard({
    required String title,
    required AsyncValue<List<dynamic>> itemsAsync,
    required Function(String) onDelete,
  }) {
    return FCard(
      title: Text(title),
      child: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: Text("No items found.")),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.name),
                subtitle: Text("ID: ${item.id.substring(0, 8)}...", style: const TextStyle(fontSize: 10)),
                // No delete for now to keep it safe, but UI is ready
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Text("Error: $e"),
      ),
    );
  }
}
