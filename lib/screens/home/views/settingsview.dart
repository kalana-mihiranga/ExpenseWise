import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Subtle background color
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: 150,
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // For spacing from top

                // Settings Header
                const Center(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Account Section
                _buildSettingsSection(
                  title: "Account",
                  iconColor: Colors.blue,
                  cardColor: Colors.white,
                  options: [
                    _buildSettingsItem(
                      icon: CupertinoIcons.person,
                      text: "Edit Profile",
                      onTap: () {
                        // Handle edit profile
                      },
                    ),
                    _buildSettingsItem(
                      icon: CupertinoIcons.lock,
                      text: "Privacy & Security",
                      onTap: () {
                        // Handle privacy settings
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Preferences Section
                _buildSettingsSection(
                  title: "Preferences",
                  iconColor: Colors.purple,
                  cardColor: Colors.white,
                  options: [
                    _buildSettingsItem(
                      icon: CupertinoIcons.moon,
                      text: "Dark Mode",
                      trailing: Switch(
                        value: false, // Update based on app state
                        onChanged: (value) {
                          // Handle dark mode toggle
                        },
                      ),
                    ),
                    _buildSettingsItem(
                      icon: CupertinoIcons.bell,
                      text: "Notifications",
                      trailing: Switch(
                        value: true, // Update based on app state
                        onChanged: (value) {
                          // Handle notifications toggle
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // App Info Section
                _buildSettingsSection(
                  title: "App Info",
                  iconColor: Colors.redAccent,
                  cardColor: Colors.white,
                  options: [
                    _buildSettingsItem(
                      icon: CupertinoIcons.info,
                      text: "About",
                      onTap: () {
                        // Handle about section
                      },
                    ),
                    _buildSettingsItem(
                      icon: CupertinoIcons.doc_text,
                      text: "Terms & Conditions",
                      onTap: () {
                        // Handle terms and conditions
                      },
                    ),
                    _buildSettingsItem(
                      icon: CupertinoIcons.mail,
                      text: "Contact Support",
                      onTap: () {
                        // Handle contact support
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build each section with card-like appearance
  Widget _buildSettingsSection({
    required String title,
    required Color iconColor,
    required Color cardColor,
    required List<Widget> options,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Divider(),
          ...options,
        ],
      ),
    );
  }

  // Helper to build each individual setting item with colored icons and custom trailing
  Widget _buildSettingsItem({
    required IconData icon,
    required String text,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.blueAccent),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, color: Colors.grey),
      onTap: onTap,
    );
  }
}
