import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeePaymentScreen extends StatefulWidget {
  const FeePaymentScreen({Key? key}) : super(key: key);

  @override
  State<FeePaymentScreen> createState() => _FeePaymentScreenState();
}

class _FeePaymentScreenState extends State<FeePaymentScreen> {
  String selectedPaymentMethod = 'Credit Card';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fee Payment',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Summary Card
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
                        Text(
                          'Payment Summary',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow('Tuition Fee', '₹50,000'),
                        _buildSummaryRow('Library Fee', '₹5,000'),
                        _buildSummaryRow('Lab Fee', '₹10,000'),
                        const Divider(height: 32),
                        _buildSummaryRow('Total Amount', '₹65,000',
                            isTotal: true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Payment Method Selection
                Text(
                  'Select Payment Method',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPaymentMethodSelector(),
                const SizedBox(height: 24),

                // Payment Details Form
                Text(
                  'Payment Details',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPaymentDetailsForm(),
                const SizedBox(height: 32),

                // Pay Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process payment
                        _showPaymentSuccessDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Pay Now',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        _buildPaymentMethodTile(
          'Credit Card',
          Icons.credit_card,
          'Pay securely with your credit card',
        ),
        _buildPaymentMethodTile(
          'Debit Card',
          Icons.credit_card,
          'Pay directly from your bank account',
        ),
        _buildPaymentMethodTile(
          'Net Banking',
          Icons.account_balance,
          'Pay using net banking',
        ),
        _buildPaymentMethodTile(
          'UPI',
          Icons.payment,
          'Pay using UPI',
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(String title, IconData icon, String subtitle) {
    return RadioListTile<String>(
      value: title,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Card Number',
            labelStyle: GoogleFonts.poppins(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card number';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Payment Successful',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Your payment has been processed successfully.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}
