import 'package:flutter/material.dart';

class ComplaintsAndSuggestionsScreen extends StatefulWidget {
  const ComplaintsAndSuggestionsScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsAndSuggestionsScreen> createState() =>
      _ComplaintsAndSuggestionsScreenState();
}

class _ComplaintsAndSuggestionsScreenState
    extends State<ComplaintsAndSuggestionsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'Complaint';
  String _category = 'Academic';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _categories = [
    'Academic',
    'Infrastructure',
    'Faculty',
    'Administrative',
    'Facilities',
    'Other'
  ];

  final List<Map<String, dynamic>> _recentSubmissions = [
    {
      'id': 'CS2023001',
      'type': 'Complaint',
      'title': 'Lab Equipment Issue',
      'status': 'In Progress',
      'date': '01-11-2025',
      'category': 'Infrastructure',
      'color': Colors.orange,
    },
    {
      'id': 'CS2023002',
      'type': 'Suggestion',
      'title': 'Library Hours Extension',
      'status': 'Under Review',
      'date': '28-10-2025',
      'category': 'Facilities',
      'color': Colors.blue,
    },
    {
      'id': 'CS2023003',
      'type': 'Complaint',
      'title': 'Canteen Food Quality',
      'status': 'Resolved',
      'date': '25-10-2025',
      'category': 'Facilities',
      'color': Colors.green,
    },
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Complaints & Suggestions'),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Submit New'),
              Tab(text: 'My Submissions'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSubmissionForm(),
            _buildSubmissionsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmissionForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type Selection
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
                    const Text(
                      'What would you like to submit?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTypeButton(
                            title: 'Complaint',
                            icon: Icons.warning_rounded,
                            isSelected: _type == 'Complaint',
                            onTap: () => setState(() => _type = 'Complaint'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTypeButton(
                            title: 'Suggestion',
                            icon: Icons.lightbulb_outline,
                            isSelected: _type == 'Suggestion',
                            onTap: () => setState(() => _type = 'Suggestion'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
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
                    // Category Dropdown
                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _category = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Title
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
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

  Widget _buildSubmissionsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _recentSubmissions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final submission = _recentSubmissions[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID: ${submission['id']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: submission['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        submission['status'],
                        style: TextStyle(
                          color: submission['color'],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  submission['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        submission['type'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        submission['category'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Submitted on: ${submission['date']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement submission logic
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: Text(
              'Your ${_type.toLowerCase()} has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Clear form
                setState(() {
                  _titleController.clear();
                  _descriptionController.clear();
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
