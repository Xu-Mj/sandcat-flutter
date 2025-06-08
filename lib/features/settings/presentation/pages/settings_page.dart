import 'package:flutter/cupertino.dart';

/// Settings page
class SettingsPage extends StatefulWidget {
  /// Creates a settings page
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  double _textSize = 1.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            // Profile section
            _buildProfileSection(),

            const SizedBox(height: 20),

            // Notifications section
            _buildSection(
              title: 'Notifications',
              children: [
                _buildSwitchRow(
                  title: 'Enable Notifications',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildNavigationRow(
                  title: 'Notification Sounds',
                  onTap: () {
                    // TODO: Navigate to notification sounds page
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Appearance section
            _buildSection(
              title: 'Appearance',
              children: [
                _buildSwitchRow(
                  title: 'Dark Mode',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                _buildSliderRow(
                  title: 'Text Size',
                  value: _textSize,
                  min: 0.8,
                  max: 1.4,
                  onChanged: (value) {
                    setState(() {
                      _textSize = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Privacy section
            _buildSection(
              title: 'Privacy',
              children: [
                _buildNavigationRow(
                  title: 'Blocked Users',
                  onTap: () {
                    // TODO: Navigate to blocked users page
                  },
                ),
                _buildNavigationRow(
                  title: 'Data & Storage',
                  onTap: () {
                    // TODO: Navigate to data & storage page
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // About section
            _buildSection(
              title: 'About',
              children: [
                _buildNavigationRow(
                  title: 'Terms of Service',
                  onTap: () {
                    // TODO: Navigate to terms of service page
                  },
                ),
                _buildNavigationRow(
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO: Navigate to privacy policy page
                  },
                ),
                _buildNavigationRow(
                  title: 'Version',
                  subtitle: '1.0.0',
                  onTap: null,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoButton(
                color: CupertinoColors.destructiveRed,
                child: const Text('Logout'),
                onPressed: () {
                  _showLogoutConfirmationDialog();
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.systemBlue,
            ),
            child: const Icon(
              CupertinoIcons.person_fill,
              color: CupertinoColors.white,
              size: 60,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'john.doe@example.com',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text('Edit Profile'),
            onPressed: () {
              // TODO: Navigate to edit profile page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            border: Border(
              top: BorderSide(color: CupertinoColors.systemGrey5),
              bottom: BorderSide(color: CupertinoColors.systemGrey5),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRow({
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: CupertinoColors.systemGrey5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(
              children: [
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                if (onTap != null) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: CupertinoColors.systemGrey,
                    size: 18,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderRow({
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 8),
          CupertinoSlider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'A',
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                'A',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement logout logic
            },
            child: const Text('Logout'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
