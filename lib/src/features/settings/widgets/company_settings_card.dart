import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:drift/drift.dart' as drift;

class CompanySettingsCard extends ConsumerStatefulWidget {
  const CompanySettingsCard({super.key});

  @override
  ConsumerState<CompanySettingsCard> createState() =>
      _CompanySettingsCardState();
}

class _CompanySettingsCardState extends ConsumerState<CompanySettingsCard> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _postalController = TextEditingController();
  final _commercialController = TextEditingController();
  final _phonePrimaryController = TextEditingController();
  final _phoneSecondaryController = TextEditingController();
  final _faxController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _postalController.dispose();
    _commercialController.dispose();
    _phonePrimaryController.dispose();
    _phoneSecondaryController.dispose();
    _faxController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _populateFields(CompanyModel? settings) {
    if (settings != null) {
      _nameController.text = settings.name;
      _postalController.text = settings.postalAddress ?? '';
      _commercialController.text = settings.commercialAddress ?? '';
      _phonePrimaryController.text = settings.phonePrimary ?? '';
      _phoneSecondaryController.text = settings.phoneSecondary ?? '';
      _faxController.text = settings.faxId ?? '';
      _emailController.text = settings.email ?? '';
      _websiteController.text = settings.website ?? '';
    }
  }

  Future<void> _saveSettings() async {
    final dbService = ref.read(databaseServiceProvider);
    await dbService.updateCompanySettings(
      db.CompanySettingsCompanion(
        name: drift.Value(_nameController.text),
        postalAddress: drift.Value(_postalController.text),
        commercialAddress: drift.Value(_commercialController.text),
        phonePrimary: drift.Value(_phonePrimaryController.text),
        phoneSecondary: drift.Value(_phoneSecondaryController.text),
        faxId: drift.Value(_faxController.text),
        email: drift.Value(_emailController.text),
        website: drift.Value(_websiteController.text),
      ),
    );

    // Refresh the provider
    ref.invalidate(companySettingsProvider);

    setState(() {
      _isEditing = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Company information updated successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(companySettingsProvider);

    return FCard(
      title: const Text("Company Information"),
      subtitle: const Text(
        "Details appearing on receipts and official documents.",
      ),
      child: settingsAsync.when(
        data: (settings) {
          if (!_isEditing) {
            return _buildDisplay(settings);
          } else {
            // Populate on first edit enter
            return _buildForm();
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildDisplay(CompanyModel? settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          Icons.business,
          "Company Name",
          settings?.name ?? "Not set",
        ),
        _buildInfoRow(
          Icons.mail_outline,
          "Postal Address",
          settings?.postalAddress ?? "Not set",
        ),
        _buildInfoRow(
          Icons.location_on_outlined,
          "Commercial Address",
          settings?.commercialAddress ?? "Not set",
        ),
        _buildInfoRow(
          Icons.phone,
          "Phone (Primary)",
          settings?.phonePrimary ?? "Not set",
        ),
        _buildInfoRow(
          Icons.phone_iphone,
          "Phone (Secondary)",
          settings?.phoneSecondary ?? "Not set",
        ),
        _buildInfoRow(Icons.fax, "Fax ID", settings?.faxId ?? "Not set"),
        _buildInfoRow(
          Icons.email_outlined,
          "Email",
          settings?.email ?? "Not set",
        ),
        _buildInfoRow(
          Icons.language,
          "Website",
          settings?.website ?? "Not set",
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FButton(
            onPress: () {
              _populateFields(settings);
              setState(() {
                _isEditing = true;
              });
            },
            child: const Text("Update Information"),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[800], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            "Company Name",
            _nameController,
            "Enter company name",
          ),
          _buildTextField("Postal Address", _postalController, "P.O. Box ..."),
          _buildTextField(
            "Commercial Address",
            _commercialController,
            "Enter physical address",
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  "Phone (Primary)",
                  _phonePrimaryController,
                  "+233...",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTextField(
                  "Phone (Secondary)",
                  _phoneSecondaryController,
                  "+233...",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  "Fax ID",
                  _faxController,
                  "Enter Fax ID",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTextField(
                  "Email",
                  _emailController,
                  "info@company.com",
                ),
              ),
            ],
          ),
          _buildTextField("Website", _websiteController, "www.company.com"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FButton(
                  variant: FButtonVariant.outline,
                  onPress: () => setState(() => _isEditing = false),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FButton(
                  onPress: _saveSettings,
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          FTextField(
            control: FTextFieldControl.managed(controller: controller),
            hint: hint,
          ),
        ],
      ),
    );
  }
}
