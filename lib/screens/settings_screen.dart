import 'package:flutter/material.dart';
import 'dart:io';
import '../utils/responsive_utils.dart';

/// Settings and about screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _autoSyncEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    final maxWidth = ResponsiveUtils.getMaxContentWidth(context);
    final deviceType = ResponsiveUtils.getDeviceType(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: ListView(
            padding: padding,
            children: [
              // Theme Section
              _SectionHeader(title: 'Appearance', spacing: spacing),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle:
                          const Text('Toggle between light and dark theme'),
                      secondary: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      value: Theme.of(context).brightness == Brightness.dark,
                      onChanged: (value) {
                        // Note: This requires ThemeProvider integration in main.dart
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(value
                                ? 'Dark mode enabled'
                                : 'Light mode enabled'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spacing * 2),

              // Preferences Section
              _SectionHeader(title: 'Preferences', spacing: spacing),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Notifications'),
                      subtitle: const Text('Receive app notifications'),
                      secondary: const Icon(Icons.notifications),
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() => _notificationsEnabled = value);
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Auto Sync'),
                      subtitle: const Text('Automatically sync data'),
                      secondary: const Icon(Icons.sync),
                      value: _autoSyncEnabled,
                      onChanged: (value) {
                        setState(() => _autoSyncEnabled = value);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      subtitle: Text(_selectedLanguage),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _showLanguageDialog();
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spacing * 2),

              // Platform Information Section
              _SectionHeader(title: 'Platform Information', spacing: spacing),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone_android),
                      title: const Text('Platform'),
                      subtitle: Text(Platform.operatingSystem),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.devices),
                      title: const Text('Device Type'),
                      subtitle: Text(_getDeviceTypeName(deviceType)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.aspect_ratio),
                      title: const Text('Screen Size'),
                      subtitle: Text(
                        '${MediaQuery.of(context).size.width.toInt()} x ${MediaQuery.of(context).size.height.toInt()} dp',
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.screen_rotation),
                      title: const Text('Orientation'),
                      subtitle: Text(
                        MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 'Portrait'
                            : 'Landscape',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spacing * 2),

              // About Section
              _SectionHeader(title: 'About', spacing: spacing),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Version'),
                      subtitle: const Text('1.0.0+1'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: const Text('Licenses'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showLicensePage(
                          context: context,
                          applicationName: 'Responsive Material App',
                          applicationVersion: '1.0.0',
                          applicationIcon: const Icon(Icons.apps, size: 48),
                          applicationLegalese: '© 2025 Flutter Demo App',
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.code),
                      title: const Text('Technology Stack'),
                      subtitle:
                          const Text('Flutter • Dart • Material Design 3'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spacing * 2),

              // Material Design Section
              _SectionHeader(title: 'Material Design', spacing: spacing),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.palette,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Material Design 3',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This app follows Google Material Design principles with responsive layouts, adaptive UI components, and accessibility features.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: spacing * 3),
            ],
          ),
        ),
      ),
    );
  }

  String _getDeviceTypeName(DeviceType type) {
    switch (type) {
      case DeviceType.mobile:
        return 'Mobile Phone';
      case DeviceType.tablet:
        return 'Tablet';
      case DeviceType.desktop:
        return 'Desktop';
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Spanish'),
              value: 'Spanish',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('French'),
              value: 'French',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final double spacing;

  const _SectionHeader({
    required this.title,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: spacing, bottom: spacing),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
