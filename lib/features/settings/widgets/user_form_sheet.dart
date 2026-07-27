import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/settings/models/user.dart';
import 'package:mealflow/features/settings/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class UserFormSheet extends StatefulWidget {
  final User user;
  const UserFormSheet({super.key, required this.user});

  @override
  State<UserFormSheet> createState() => _UserFormSheetState();
}

class _UserFormSheetState extends State<UserFormSheet> {
  final _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _titleController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user.name);
    _titleController = TextEditingController(text: widget.user.title);

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.cardPadding,
      child: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit User Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            AppSpacing.verticalLG,

            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name cannot be empty.';
                }

                return null;
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),

            AppSpacing.verticalMD,

            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title cannot be empty.';
                }

                return null;
              },
              decoration: InputDecoration(labelText: 'Title'),
            ),

            AppSpacing.verticalLG,

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (!_key.currentState!.validate()) return;

                  context.read<SettingsProvider>().changeUserDetails(
                    name: _nameController.text.trim(),
                    title: _titleController.text.trim(),
                  );

                  context.pop();
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
