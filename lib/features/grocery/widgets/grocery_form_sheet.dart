import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';

class GroceryFormSheet extends StatefulWidget {
  final GroceryItem? item;
  const GroceryFormSheet({super.key, this.item});

  @override
  State<GroceryFormSheet> createState() => _GroceryFormSheetState();
}

class _GroceryFormSheetState extends State<GroceryFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _unitController;

  late GroceryCategory _selectedCategory;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _quantityController = TextEditingController(
      text: widget.item?.quantity.toInt().toString() ?? '',
    );
    _unitController = TextEditingController(text: widget.item?.unit ?? '');

    _selectedCategory = widget.item?.category ?? GroceryCategory.others;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.cardPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item != null ? 'Edit Grocery Item' : 'Add Grocery Item',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            AppSpacing.verticalMD,

            const Divider(),

            AppSpacing.verticalMD,

            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a grocery name';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g Chicken Breast',
              ),
            ),

            AppSpacing.verticalMD,

            DropdownButtonFormField(
              initialValue: _selectedCategory,
              items: GroceryCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.displayName),
                );
              }).toList(),
              onChanged: (category) {
                if (category == null) return;

                setState(() {
                  _selectedCategory = category;
                });
              },
            ),

            AppSpacing.verticalMD,

            TextFormField(
              controller: _quantityController,
              validator: (value) {
                final quantity = double.tryParse(value ?? '');

                if (quantity == null || quantity <= 0) {
                  return 'Enter a valid quantity.';
                }

                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),

            AppSpacing.verticalSM,

            TextField(
              controller: _unitController,
              decoration: InputDecoration(
                labelText: 'Unit',
                hintText: 'e.g kg, pcs, pack',
              ),
            ),

            AppSpacing.verticalLG,

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  context.pop(
                    widget.item == null
                        ? GroceryItem(
                            name: _nameController.text.trim(),
                            category: _selectedCategory,
                            quantity: double.tryParse(
                              _quantityController.text,
                            )!,
                            unit: _unitController.text.trim(),
                            emoji: _selectedCategory.emoji,
                          )
                        : widget.item!.copyWith(
                            name: _nameController.text.trim(),
                            category: _selectedCategory,
                            quantity: double.tryParse(
                              _quantityController.text,
                            )!,
                            unit: _unitController.text.trim(),
                            emoji: _selectedCategory.emoji,
                          ),
                  );
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
