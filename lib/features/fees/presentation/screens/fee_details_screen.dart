import 'package:flutter/material.dart';
import '../../models/fee_details.dart';

class FeeDetailsScreen extends StatelessWidget {
  const FeeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fee Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Fee Overview Card
              _buildTotalFeeCard(),
              const SizedBox(height: 24),

              // Fee Breakdown Section
              const Text(
                'Fee Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildFeeBreakdownList(),

              const SizedBox(height: 24),

              // Payment Schedule Section
              const Text(
                'Payment Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildPaymentScheduleList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalFeeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Fee',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '₹1,20,000',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paid: ₹84,000',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Due: ₹36,000',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeBreakdownList() {
    final feeItems = [
      {'name': 'Tuition Fee', 'amount': '₹80,000'},
      {'name': 'Library Fee', 'amount': '₹10,000'},
      {'name': 'Lab Fee', 'amount': '₹15,000'},
      {'name': 'Sports Fee', 'amount': '₹8,000'},
      {'name': 'Development Fee', 'amount': '₹7,000'},
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: feeItems.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              feeItems[index]['name']!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              feeItems[index]['amount']!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentScheduleList() {
    final scheduleItems = [
      {
        'installment': '1st Installment',
        'dueDate': '2023-08-01',
        'amount': '₹40,000',
        'status': 'Paid'
      },
      {
        'installment': '2nd Installment',
        'dueDate': '2023-11-01',
        'amount': '₹40,000',
        'status': 'Paid'
      },
      {
        'installment': '3rd Installment',
        'dueDate': '2024-02-01',
        'amount': '₹40,000',
        'status': 'Due'
      },
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: scheduleItems.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = scheduleItems[index];
          return ListTile(
            title: Text(
              item['installment']!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('Due Date: ${item['dueDate']!}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item['amount']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  item['status']!,
                  style: TextStyle(
                    color: item['status'] == 'Paid' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
