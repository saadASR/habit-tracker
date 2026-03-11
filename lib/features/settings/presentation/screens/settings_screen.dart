import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../services/hive_service.dart';
import '../../../../services/notification_service.dart';
import '../../../../main.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = HiveService.getSettings().notificationsEnabled;
  }

  Future<void> _requestNotificationPermission() async {
    await NotificationService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDarkMode = ref.watch(themeProvider);
    final currentThemeType = ref.watch(themeTypeProvider);
    final settings = HiveService.getSettings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Appearance Section
          _SectionHeader(title: 'Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Switch between light and dark theme'),
            value: isDarkMode,
            onChanged: (value) async {
              ref.read(themeProvider.notifier).setDarkMode(value);
              final newSettings = settings.copyWith(isDarkMode: value);
              await HiveService.saveSettings(newSettings);
            },
            secondary: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.primary,
            ),
          ),
          
          // Theme Color
          ListTile(
            title: const Text('Theme Color'),
            subtitle: const Text('Choose your preferred color'),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeColorPicker(context),
          ),
          const Divider(),

          // Notifications Section
          _SectionHeader(title: 'Notifications'),
          SwitchListTile(
            title: const Text('Enable Reminders'),
            subtitle: const Text('Receive daily habit reminders'),
            value: _notificationsEnabled,
            onChanged: (value) async {
              if (value) {
                await _requestNotificationPermission();
              }
              setState(() {
                _notificationsEnabled = value;
              });
              final newSettings = settings.copyWith(notificationsEnabled: value);
              await HiveService.saveSettings(newSettings);
              if (!value) {
                await NotificationService.cancelAllNotifications();
              }
            },
            secondary: Icon(
              Icons.notifications,
              color: AppColors.primary,
            ),
          ),
          const Divider(),

          // Data Section
          _SectionHeader(title: 'Data'),
          ListTile(
            leading: Icon(
              Icons.delete_outline,
              color: AppColors.error,
            ),
            title: const Text('Clear All Data'),
            subtitle: const Text('Delete all habits and progress'),
            onTap: () => _showClearDataDialog(context),
          ),
          const Divider(),

          // About Section
          _SectionHeader(title: 'About'),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: AppColors.primary,
            ),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: AppColors.primary,
            ),
            title: const Text('Developed by SaadASR'),
            subtitle: const Text('Click to visit Instagram'),
            onTap: () => _openInstagram(),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  void _showThemeColorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final currentTheme = ref.watch(themeTypeProvider);
            
            return Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Theme Color',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: AppThemeType.values.map((themeType) {
                      final isSelected = currentTheme == themeType;
                      return GestureDetector(
                        onTap: () async {
                          ref.read(themeTypeProvider.notifier).setThemeType(themeType);
                          final settings = HiveService.getSettings();
                          await HiveService.saveSettings(
                            settings.copyWith(themeTypeIndex: themeType.index),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: AnimatedContainer(
                          duration: AppDurations.fast,
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: themeType.color,
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: themeType.color.withOpacity(0.5),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 32,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: AppThemeType.values.map((themeType) {
                      return Text(
                        themeType.displayName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your habits and progress. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Clear all boxes
              await HiveService.habitsBox.clear();
              await HiveService.completionsBox.clear();
              
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('All data cleared'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _openInstagram() async {
    final Uri instagramUrl = Uri.parse('https://www.instagram.com/saadasr1/');
    try {
      // Try to open Instagram app first
      final Uri nativeUrl = Uri.parse('instagram://user?username=saadasr1');
      await Future.delayed(const Duration(milliseconds: 100));
      // Fallback to web if app not available
      await Future.any([
        Future.delayed(const Duration(milliseconds: 500)),
        Future.value(true),
      ]);
      // Use web URL as fallback
      await launchUrl(instagramUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Fallback to web
      await launchUrl(instagramUrl, mode: LaunchMode.externalApplication);
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
