
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/domain/enums/category_type_enum.dart';
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';
import 'package:hesabuapp/domain/enums/product_type_enum.dart';
import 'package:hesabuapp/presentation/controllers/add_product_controller.dart';

class AddProductScreen extends GetView<AddProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: controller.saveProduct,
                ),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.errors.containsKey('general'))
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.errors['general']!,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            _buildTextField(
              label: 'Product Name *',
              hint: 'Enter product name',
              onChanged: controller.setTitle,
              error: controller.errors['title'],
              icon: Icons.title,
            ),
            const SizedBox(height: 16),

            Obx(() => DropdownButtonFormField<ProductTypeEnum>(
              value: controller.type.value,
              decoration: InputDecoration(
                labelText: 'Product Type *',
                errorText: controller.errors['type'],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: controller.errors.containsKey('type')
                        ? Colors.red.shade700
                        : Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                prefixIcon: const Icon(Icons.category_outlined),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              items: controller.typeOptions.map((type) {
                return DropdownMenuItem<ProductTypeEnum>(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.setType(value);
                }
              },
            )),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'Description',
              hint: 'Enter product description (optional)',
              onChanged: controller.setDescription,
              maxLines: 3,
              icon: Icons.description,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'Buying Price *',
              hint: '0.00',
              onChanged: controller.setBuyingPrice,
              error: controller.errors['buyingPrice'],
              keyboardType: TextInputType.number,
              icon: Icons.shopping_cart,
              prefixText: 'KES ',
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'Selling Price *',
              hint: '0.00',
              onChanged: controller.setSellingPrice,
              error: controller.errors['sellingPrice'],
              keyboardType: TextInputType.number,
              icon: Icons.attach_money,
              prefixText: 'KES ',
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'Max Price (Optional)',
              hint: '0.00',
              onChanged: controller.setMaxPrice,
              keyboardType: TextInputType.number,
              icon: Icons.trending_up,
              prefixText: 'KES ',
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'Initial Quantity *',
              hint: '0',
              onChanged: controller.setQuantity,
              error: controller.errors['quantity'],
              keyboardType: TextInputType.number,
              icon: Icons.inventory,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'SKU (Optional)',
              hint: 'Enter product SKU',
              onChanged: controller.setSku,
              icon: Icons.tag,
            ),
            const SizedBox(height: 16),

            Obx(() {
              if (controller.isLoadingCategories.value) {
                return const SizedBox(
                  height: 56,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.categories.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'No Categories Available',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Please create a category first in the Categories tab',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return DropdownButtonFormField<String>(
                value: controller.categoryId.value.isEmpty ? null : controller.categoryId.value,
                decoration: InputDecoration(
                  labelText: 'Category *',
                  prefixIcon: const Icon(Icons.folder_outlined),
                  errorText: controller.errors['categoryId'],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: controller.errors.containsKey('categoryId')
                          ? Colors.red.shade700
                          : Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                hint: const Text('Select category'),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('None'),
                  ),
                  ...controller.categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Row(
                        children: [
                          Icon(
                            category.type == CategoryTypeEnum.income
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 16,
                            color: category.type == CategoryTypeEnum.income
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              category.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  controller.setCategoryId(value ?? '');
                },
              );
            }),
            const SizedBox(height: 16),

            _buildTextField(
              label: 'Discount (Optional)',
              hint: '0',
              onChanged: controller.setDiscount,
              keyboardType: TextInputType.number,
              icon: Icons.percent,
              prefixText: '% ',
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Add Product',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: controller.cancel,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    String? error,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? icon,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 14,
                  color: Colors.red.shade700,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixText: prefixText,
            prefixIcon: icon != null ? Icon(icon, size: 20) : null,
            errorText: error,
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: error != null ? Colors.red.shade700 : Theme.of(Get.context!).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade700, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade700, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            errorStyle: TextStyle(
              color: Colors.red.shade700,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}