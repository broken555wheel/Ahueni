import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Profile',
      ),
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Picture
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with the user's profile picture
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      // Implement profile picture change functionality
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          // Name
          const ProfileSectionTitle('Name'),
          ProfileTile(
            title: 'John Doe', // Replace with the user's name
            icon: Icons.person,
            onTap: () {
              // Implement edit name functionality
            },
          ),

          // Username
          const ProfileSectionTitle('Username'),
          ProfileTile(
            title: 'john_doe', // Replace with the user's username
            icon: Icons.alternate_email,
            onTap: () {
              // Implement edit username functionality
            },
          ),

          // Email
          const ProfileSectionTitle('Email'),
          ProfileTile(
            title: 'johndoe@example.com', // Replace with the user's email
            icon: Icons.email,
            onTap: () {
              // Implement edit email functionality
            },
          ),

          // Phone Number
          const ProfileSectionTitle('Phone Number'),
          ProfileTile(
            title: '+1234567890', // Replace with the user's phone number
            icon: Icons.phone,
            onTap: () {
              // Implement edit phone number functionality
            },
          ),

          // Bio
          const ProfileSectionTitle('Bio'),
          ProfileTile(
            title: 'Lover of tech, coding enthusiast, and coffee addict.', // Replace with the user's bio
            icon: Icons.info,
            onTap: () {
              // Implement edit bio functionality
            },
          ),
          
          // Additional Information
          const ProfileSectionTitle('Location'),
          ProfileTile(
            title: 'Nairobi, Kenya', // Replace with the user's location
            icon: Icons.location_on,
            onTap: () {
              // Implement edit location functionality
            },
          ),
          
          // Other potential sections (e.g., Date of Birth, Gender, etc.) can be added similarly
        ],
      ),
    );
  }
}

class ProfileSectionTitle extends StatelessWidget {
  final String title;

  const ProfileSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileTile({required this.title, required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
