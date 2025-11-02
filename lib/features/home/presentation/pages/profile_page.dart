import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C5CE7),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCollegeHeader(),
            _buildProfileCard(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildSection('Academic Information', _buildAcademicInfo()),
                  const SizedBox(height: 16),
                  _buildSection('Personal Information', _buildPersonalInfo()),
                  const SizedBox(height: 16),
                  _buildSection('Contact Information', _buildContactInfo()),
                  const SizedBox(height: 16),
                  _buildSection('Parents Information', _buildParentsInfo()),
                  const SizedBox(height: 16),
                  _buildSection('Address', _buildAddress()),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollegeHeader() {
    return Container(
      color: const Color(0xFF6C5CE7),
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Image.network(
            'https://example.com/college_logo.png', // Replace with actual logo URL
            height: 80,
            width: 80,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.school,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'VASAVI COLLEGE OF ENGINEERING',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Autonomous Institution',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://example.com/student_photo.jpg', // Replace with actual photo URL
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'B.Tech - Computer Science',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Roll No: 21B81A05J1',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C5CE7),
              ),
            ),
          ),
          const Divider(height: 1),
          content,
        ],
      ),
    );
  }

  Widget _buildAcademicInfo() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _InfoRow('Admission No', '21BTECH0001'),
          _InfoRow('Roll No', '21B81A05J1'),
          _InfoRow('Course', 'B.Tech'),
          _InfoRow('Branch', 'Computer Science & Engineering'),
          _InfoRow('Semester', '5th Semester'),
          _InfoRow('Entrance Type', 'EAPCET'),
          _InfoRow('EAPCET Rank', '1234'),
          _InfoRow('Joining Date', '16/08/2021'),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _InfoRow('Date of Birth', '01/01/2003'),
          _InfoRow('Gender', 'Male'),
          _InfoRow('Blood Group', 'O+'),
          _InfoRow('Caste', 'BC-A'),
          _InfoRow('SSC Marks', '98%'),
          _InfoRow('Inter Marks', '96.8%'),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _InfoRow('Mobile', '+91 9876543210'),
          _InfoRow('Email', 'john.doe@example.com'),
        ],
      ),
    );
  }

  Widget _buildParentsInfo() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _InfoRow('Father\'s Name', 'James Doe'),
          _InfoRow('Father\'s Mobile', '+91 9876543211'),
          _InfoRow('Father\'s Occupation', 'Business'),
          _InfoRow('Mother\'s Name', 'Jane Doe'),
          _InfoRow('Mother\'s Mobile', '+91 9876543212'),
          _InfoRow('Mother\'s Occupation', 'Teacher'),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _InfoRow('Address', '123, Example Street'),
          _InfoRow('City', 'Hyderabad'),
          _InfoRow('State', 'Telangana'),
          _InfoRow('Pin Code', '500081'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
