import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Contacts Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.emergency,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Emergency Contacts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildContactTile(
                      title: 'Campus Emergency',
                      contact: '+1 234 567 890',
                      icon: Icons.local_hospital,
                      color: Colors.red,
                    ),
                    _buildContactTile(
                      title: 'Security Office',
                      contact: '+1 234 567 891',
                      icon: Icons.security,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Department Contacts
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.business,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Department Contacts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDepartmentTile(
                      title: 'Academic Affairs',
                      email: 'academic@university.edu',
                      phone: '+1 234 567 892',
                      timings: '9:00 AM - 5:00 PM',
                    ),
                    _buildDepartmentTile(
                      title: 'Student Services',
                      email: 'student@university.edu',
                      phone: '+1 234 567 893',
                      timings: '9:00 AM - 4:00 PM',
                    ),
                    _buildDepartmentTile(
                      title: 'Library',
                      email: 'library@university.edu',
                      phone: '+1 234 567 894',
                      timings: '8:00 AM - 8:00 PM',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Location Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Our Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '123 University Avenue\nCity, State 12345\nCountry',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement map navigation
                          _launchMaps();
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('Get Directions'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Social Media Links
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.purple.shade700,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Connect With Us',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton(
                          icon: Icons.facebook,
                          label: 'Facebook',
                          color: Colors.blue,
                          onTap: () {
                            // TODO: Implement Facebook link
                          },
                        ),
                        _buildSocialButton(
                          icon: Icons.phone_android,
                          label: 'Twitter',
                          color: Colors.lightBlue,
                          onTap: () {
                            // TODO: Implement Twitter link
                          },
                        ),
                        _buildSocialButton(
                          icon: Icons.camera_alt,
                          label: 'Instagram',
                          color: Colors.purple,
                          onTap: () {
                            // TODO: Implement Instagram link
                          },
                        ),
                        _buildSocialButton(
                          icon: Icons.video_library,
                          label: 'YouTube',
                          color: Colors.red,
                          onTap: () {
                            // TODO: Implement YouTube link
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required String title,
    required String contact,
    required IconData icon,
    required Color color,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(contact),
      trailing: IconButton(
        icon: const Icon(Icons.phone),
        color: color,
        onPressed: () {
          _launchPhone(contact);
        },
      ),
    );
  }

  Widget _buildDepartmentTile({
    required String title,
    required String email,
    required String phone,
    required String timings,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.email, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                email,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                phone,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                timings,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchMaps() async {
    // Replace with actual coordinates
    const String googleMapsUrl =
        'https://maps.google.com/?q=university+location';
    final Uri mapsUri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    }
  }
}
