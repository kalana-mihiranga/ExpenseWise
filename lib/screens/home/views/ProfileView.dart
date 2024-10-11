import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure bottom sheet only takes necessary space
        crossAxisAlignment: CrossAxisAlignment.center, // Center-align content
        children: [
          // Avatar with gradient background
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  CupertinoIcons.person_fill,
                  color: Colors.white,
                  size: 60,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Profile Name
          const Center(
            child: Text(
              "Kalana Mi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Email
          Center(
            child: Text(
              "kalana.mi@example.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Buttons for profile options with shadow and rounded edges
          _buildProfileOption(
            icon: CupertinoIcons.person_crop_circle,
            text: "Edit Profile",
            color: Colors.blueAccent,
            onTap: () {
              // Handle edit profile functionality
            },
          ),
          const SizedBox(height: 10),

          _buildProfileOption(
            icon: CupertinoIcons.lock,
            text: "Change Password",
            color: Colors.purpleAccent,
            onTap: () {
              // Handle change password functionality
            },
          ),
          const SizedBox(height: 10),

          _buildProfileOption(
            icon: CupertinoIcons.square_arrow_right,
            text: "Log Out",
            color: Colors.redAccent,
            onTap: () {
              // Handle log out functionality
            },
          ),
        ],
      ),
    );
  }

  // Helper function to build each profile option with custom styling
  Widget _buildProfileOption({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
        trailing: const Icon(
          CupertinoIcons.forward,
          color: Colors.grey,
        ),
      ),
    );
  }
}
