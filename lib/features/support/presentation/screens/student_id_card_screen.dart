import 'package:flutter/material.dart';
import 'dart:math' as math;

class StudentIdCard extends StatelessWidget {
  const StudentIdCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student ID Card'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Virtual ID Card
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6C5CE7), Color(0xFF8E7FF3)],
                  ),
                ),
                child: Column(
                  children: [
                    // College Logo and Name
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.school,
                            color: Color(0xFF6C5CE7),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SRKR Engineering College',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Student Identity Card',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Student Photo and Details
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              'https://raw.githubusercontent.com/mannerishivardhan/ecap/main/assets/student_photo.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Color(0xFF6C5CE7),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '•••• •••• Doe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Roll No: •••• 123',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Branch: Computer Science',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Mobile: •••• ••• 789',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // QR Code
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const QRCodeWidget(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Valid until: Dec 2025',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.share,
                    label: 'Share ID',
                    onPressed: () {
                      // TODO: Implement share functionality
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.download,
                    label: 'Download',
                    onPressed: () {
                      // TODO: Implement download functionality
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ID Card Information
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Important Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    InfoItem(
                      icon: Icons.info_outline,
                      text:
                          'This virtual ID card is for identification purposes only',
                    ),
                    InfoItem(
                      icon: Icons.warning_amber,
                      text: 'Physical ID card must be carried within campus',
                    ),
                    InfoItem(
                      icon: Icons.block,
                      text: 'Non-transferable and must not be misused',
                    ),
                    InfoItem(
                      icon: Icons.report_problem_outlined,
                      text: 'Report immediately if lost or stolen',
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color(0xFF6C5CE7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QRCodeWidget extends StatelessWidget {
  const QRCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(80, 80),
      painter: QRPainter(),
    );
  }
}

class QRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6C5CE7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final qrSize = size.width;
    final cellSize = qrSize / 8;

    // Draw QR code pattern
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        if (math.Random().nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(i * cellSize, j * cellSize, cellSize, cellSize),
            paint..style = PaintingStyle.fill,
          );
        }
      }
    }

    // Draw position detection patterns
    _drawPositionDetectionPattern(canvas, 0, 0, cellSize);
    _drawPositionDetectionPattern(canvas, 5 * cellSize, 0, cellSize);
    _drawPositionDetectionPattern(canvas, 0, 5 * cellSize, cellSize);
  }

  void _drawPositionDetectionPattern(
      Canvas canvas, double x, double y, double size) {
    final paint = Paint()
      ..color = const Color(0xFF6C5CE7)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(x, y, size * 3, size * 3), paint);
    canvas.drawRect(
      Rect.fromLTWH(x + size, y + size, size, size),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
