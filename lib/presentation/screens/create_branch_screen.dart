import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/create_branch_controller.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';
import 'package:hesabuapp/presentation/widgets/custom_textfield_widget.dart';

class CreateBranchScreen extends GetView<CreateBranchController> {
  const CreateBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Set up your first branch'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildBranchNameField(),
              const SizedBox(height: 16),
              _buildBranchLocationField(),
              const SizedBox(height: 16),
              _buildBranchDescriptionField(),
              const SizedBox(height: 32),
              _buildCreateButton(context),
              const SizedBox(height: 16),
              _buildErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Create your first branch',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Branches help you manage multiple locations',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBranchNameField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Branch Name',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Enter branch name',
          prefixIcon: Icons.storefront_outlined,
          onChanged: controller.setBranchName,
          errorText: controller.branchNameError.value.isEmpty ? null : controller.branchNameError.value,
        ),
      ],
    ));
  }

  Widget _buildBranchLocationField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Branch Location',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Enter branch address',
          prefixIcon: Icons.location_on_outlined,
          onChanged: controller.setBranchLocation,
          errorText: controller.branchLocationError.value.isEmpty ? null : controller.branchLocationError.value,
        ),
      ],
    ));
  }

  Widget _buildBranchDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Branch Description (optional)',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Tell us about this branch',
          prefixIcon: Icons.description_outlined,
          onChanged: controller.setBranchDescription,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Create Branch',
      onPressed: controller.createBranch,
      isLoading: controller.isLoading.value,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderRadius: 8,
    ));
  }

  Widget _buildErrorMessage() {
    return Obx(() => controller.generalError.value.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              controller.generalError.value,
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          )
        : const SizedBox.shrink());
  }
}