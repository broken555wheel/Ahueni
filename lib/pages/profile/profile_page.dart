import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ahueni/models/user_profile.dart';
import 'package:ahueni/providers/user_profile_provider.dart';
import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final userProfile = userProfileProvider.userProfile;

    if (userProfile == null) {
      return const Scaffold(
        appBar: MyAppBar(title: 'Profile'),
        drawer: MyDrawer(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    _nameController.text = userProfile.name;
    _usernameController.text = userProfile.username;
    _emailController.text = userProfile.email;
    _phoneNumberController.text = userProfile.phoneNumber;
    _bioController.text = userProfile.bio;
    _locationController.text = userProfile.location;

    return Scaffold(
      appBar: const MyAppBar(title: 'Profile'),
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userProfile.profileImageUrl),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        await userProfileProvider.updateProfileImage(image);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          // Edit Profile Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
    onPressed: () {
      if (_isEditing) {
        _saveProfile(userProfileProvider);
      } else {
        setState(() {
          _isEditing = true;
        });
      }
              },
              child: Text(_isEditing ? 'Save Profile' : 'Edit Profile'),
            ),
          ),

          // Profile Fields
          const ProfileSectionTitle('Name'),
          _buildProfileTile('Name', _nameController, _isEditing),
          const ProfileSectionTitle('Username'),
          _buildProfileTile('Username', _usernameController, _isEditing),
          const ProfileSectionTitle('Email'),
          _buildProfileTile('Email', _emailController, _isEditing),
          const ProfileSectionTitle('Phone Number'),
          _buildProfileTile('Phone Number', _phoneNumberController, _isEditing),
          const ProfileSectionTitle('Bio'),
          _buildProfileTile('Bio', _bioController, _isEditing),
          const ProfileSectionTitle('Location'),
          _buildProfileTile('Location', _locationController, _isEditing),
        ],
      ),
    );
  }

  Widget _buildProfileTile(String label, TextEditingController controller, bool isEditing) {
    return ListTile(
      leading: Icon(_getIconForLabel(label)),
      title: isEditing
          ? TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
              ),
            )
          : Text(controller.text),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Name':
        return Icons.person;
      case 'Username':
        return Icons.alternate_email;
      case 'Email':
        return Icons.email;
      case 'Phone Number':
        return Icons.phone;
      case 'Bio':
        return Icons.info;
      case 'Location':
        return Icons.location_on;
      default:
        return Icons.edit;
    }
  }

  void _saveProfile(UserProfileProvider userProfileProvider) {
    final updatedProfile = UserProfile(
      uid: userProfileProvider.userProfile!.uid,
      email: _emailController.text,
      name: _nameController.text,
      username: _usernameController.text,
      phoneNumber: _phoneNumberController.text,
      bio: _bioController.text,
      location: _locationController.text,
      profileImageUrl: userProfileProvider.userProfile!.profileImageUrl,
    );

    userProfileProvider.updateProfile(updatedProfile);
    setState(() {
      _isEditing = false;
    });
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
