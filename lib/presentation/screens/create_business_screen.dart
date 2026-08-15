import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/create_business_controller.dart';
import 'package:hesabuapp/presentation/widgets/custom_button.dart';
import 'package:hesabuapp/presentation/widgets/custom_textfield_widget.dart';

class CreateBusinessScreen extends GetView<CreateBusinessController> {
  const CreateBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Set up your business'),
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
              _buildBusinessNameField(),
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
          'Create your business',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your business name to get started',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBusinessNameField() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Business Name',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          label: '',
          hint: 'Enter your business name',
          prefixIcon: Icons.storefront_outlined,
          onChanged: controller.setBusinessName,
          errorText: controller.businessNameError.value.isEmpty ? null : controller.businessNameError.value,
        ),
      ],
    ));
  }

  Widget _buildCreateButton(BuildContext context) {
    return Obx(() => CustomButton(
      text: 'Create Business',
      onPressed: controller.createBusiness,
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