import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/settings/providers/settings_provider.dart';
import 'package:mealflow/features/settings/widgets/user_form_sheet.dart';
import 'package:provider/provider.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  void showEditUserDetails(BuildContext context, user) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UserFormSheet(user: user);
      },
    );
  }

  void openPickAvatar(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: AppSpacing.cardPadding,
                child: Text(
                  'Meal Photo',
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
              ),

              AppSpacing.verticalMD,

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () async {
                  sheetContext.pop();

                  final settingsProvider = parentContext
                      .read<SettingsProvider>();

                  await _pickAvatar(settingsProvider, ImageSource.camera);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  sheetContext.pop();

                  final settingsProvider = parentContext
                      .read<SettingsProvider>();

                  await _pickAvatar(settingsProvider, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickAvatar(
    SettingsProvider settingsProvider,
    ImageSource source,
  ) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      await settingsProvider.changeAvatar(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<SettingsProvider>().user;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.medium,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              openPickAvatar(context);
            },
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              backgroundImage: user.imagePath != null
                  ? FileImage(File(user.imagePath!))
                  : const AssetImage('assets/images/default_user.png'),
            ),
          ),

          AppSpacing.horizontalMD,

          Expanded(
            child: Column(
              children: [
                Text(user.name, style: Theme.of(context).textTheme.titleLarge),

                AppSpacing.verticalXS,

                Text(
                  user.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              showEditUserDetails(context, user);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
