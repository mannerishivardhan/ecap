import 'package:flutter/material.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  String _leaveType = 'Sick Leave';
  final _reasonController = TextEditingController();

  final List<String> _leaveTypes = [
    'Sick Leave',
    'Personal Leave',
    'Family Emergency',
    'Academic Leave',
    'Other'
  ];

  final List<Map<String, dynamic>> _recentApplications = [
    {
      'type': 'Sick Leave',
      'status': 'Approved',
      'dates': '01-11-2025 to 03-11-2025',
      'color': Colors.green
    },
    {
      'type': 'Personal Leave',
      'status': 'Pending',
      'dates': '25-10-2025 to 26-10-2025',
      'color': Colors.orange
    },
    {
      'type': 'Academic Leave',
      'status': 'Rejected',
      'dates': '15-10-2025 to 16-10-2025',
      'color': Colors.red
    },
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Application'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leave Balance Card
            _buildLeaveBalanceCard(),
            const SizedBox(height: 24),

            // Application Form
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Leave Application',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Leave Type Dropdown
                      DropdownButtonFormField<String>(
                        value: _leaveType,
                        decoration: InputDecoration(
                          labelText: 'Leave Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: _leaveTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _leaveType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Date Selection
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateField(
                              label: 'Start Date',
                              value: _startDate,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() {
                                    _startDate = date;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDateField(
                              label: 'End Date',
                              value: _endDate,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate ?? DateTime.now(),
                                  firstDate: _startDate ?? DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() {
                                    _endDate = date;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Reason TextField
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Reason',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter reason for leave';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitApplication,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Submit Application'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Recent Applications
            const Text(
              'Recent Applications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentApplications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final application = _recentApplications[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          application['type'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: application['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            application['status'],
                            style: TextStyle(
                              color: application['color'],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        application['dates'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveBalanceCard() {
    return Card(
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
              'Leave Balance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLeaveTypeBalance(
                  type: 'Sick Leave',
                  used: 3,
                  total: 10,
                  color: Colors.blue,
                ),
                _buildLeaveTypeBalance(
                  type: 'Personal',
                  used: 2,
                  total: 5,
                  color: Colors.purple,
                ),
                _buildLeaveTypeBalance(
                  type: 'Academic',
                  used: 1,
                  total: 5,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveTypeBalance({
    required String type,
    required int used,
    required int total,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${total - used}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          type,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Used: $used/$total',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value != null
                  ? '${value.day}/${value.month}/${value.year}'
                  : 'Select Date',
              style: TextStyle(
                fontSize: 16,
                color: value != null ? Colors.black87 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select both start and end dates'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // TODO: Submit application logic
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text(
              'Your leave application has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Clear form
                setState(() {
                  _startDate = null;
                  _endDate = null;
                  _leaveType = 'Sick Leave';
                  _reasonController.clear();
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
