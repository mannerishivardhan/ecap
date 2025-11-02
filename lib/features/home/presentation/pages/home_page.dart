import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecap/features/home/presentation/pages/profile_page.dart';
import 'package:ecap/features/home/presentation/pages/course_detail_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:ecap/features/home/domain/models/course.dart';

enum AttendanceStatus {
  present,
  absent,
  partial,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _DashboardPage(key: Key('dashboard')),
    const _TimetablePage(key: Key('timetable')),
    const _AssignmentsPage(key: Key('assignments')),
    const _MorePage(key: Key('more')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz_outlined),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatefulWidget {
  const _DashboardPage({super.key});

  @override
  State<_DashboardPage> createState() => _DashboardPageState();
}

class UserLocation {
  final String id;
  final String name;
  final double x;
  final double y;
  final Color color;

  UserLocation({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
    required this.color,
  });
}

class HeatmapPainter extends CustomPainter {
  final List<UserLocation> locations;

  HeatmapPainter(this.locations);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid lines
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.shade200
      ..strokeWidth = 0.5;

    // Draw vertical grid lines
    for (var i = 0; i < 10; i++) {
      final x = size.width * (i / 10);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    // Draw horizontal grid lines
    for (var i = 0; i < 10; i++) {
      final y = size.height * (i / 10);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Draw heat areas
    for (final location in locations) {
      final paint = Paint()
        ..color = location.color.withOpacity(0.1)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(location.x * size.width, location.y * size.height),
        30,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _DashboardPageState extends State<_DashboardPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _startDate;
  DateTime? _endDate;

  final List<UserLocation> _mockLocations = [
    UserLocation(
      id: '1',
      name: 'Bhimavaram City Center',
      x: 0.5,
      y: 0.5,
      color: const Color(0xFF76B900), // NVIDIA green color
    ),
  ];
  DateTime _attendanceMonth = DateTime.now();
  final PageController _monthController = PageController(
      initialPage: 1000); // Start from middle point for "infinite" scrolling

  @override
  void dispose() {
    _monthController.dispose();
    super.dispose();
  }

  // Mock attendance data - replace with real data from backend
  final Map<DateTime, AttendanceStatus> _attendanceData = {
    DateTime(2025, 11, 1): AttendanceStatus.present,
    DateTime(2025, 11, 2): AttendanceStatus.present,
    DateTime(2025, 11, 3): AttendanceStatus.absent,
    DateTime(2025, 11, 4): AttendanceStatus.present,
    DateTime(2025, 11, 5): AttendanceStatus.partial,
  };

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildLocationLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: _mockLocations.map((location) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: location.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    location.name,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLocationMarkers() {
    final size = MediaQuery.of(context).size;
    return _mockLocations.map((location) {
      return Positioned(
        left: location.x * (size.width - 40),
        top: location.y * 380,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: location.color,
                    width: 2,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: location.color.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            location.name.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: location.color,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "GROOT AI ACTIVE",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white70,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 100,
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  location.color.withOpacity(0.3),
                                  location.color,
                                  location.color.withOpacity(0.3),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: 0.8 +
                    (value *
                        0.2 *
                        (math
                            .sin(DateTime.now().millisecondsSinceEpoch / 500))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Image.network(
                      'https://raw.githubusercontent.com/mannerishivardhan/ecap/main/assets/groot.png',
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: location.color,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              "🌱",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }).toList();
  }

  DateTime _calculateMonthOffset(DateTime baseDate, int monthOffset) {
    int year = baseDate.year;
    int month = baseDate.month + monthOffset;

    // Adjust year based on month overflow/underflow
    year += (month - 1) ~/ 12;
    month = ((month - 1) % 12) + 1;

    if (month < 1) {
      month = 12 + month;
      year--;
    }

    return DateTime(year, month);
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 32,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                'Hi Rakib',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              Text(
                'Manage your academics',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E8E),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                size: 28,
                color: Color(0xFF4A4A4A),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.person_2_outlined,
                size: 28,
                color: Color(0xFF4A4A4A),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 16)
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildStorageCard(),
              const SizedBox(height: 24),
              _buildCalendar(),
              const SizedBox(height: 24),
              _buildQuickAccess(),
              const SizedBox(height: 24),
              _buildDateRangeAttendance(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Calendar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _calendarFormat =
                              _calendarFormat == CalendarFormat.month
                                  ? CalendarFormat.week
                                  : CalendarFormat.month;
                        });
                      },
                      child: Text(
                        _calendarFormat == CalendarFormat.month
                            ? 'Week'
                            : 'Month',
                        style: const TextStyle(color: Color(0xFF6C5CE7)),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today, size: 20),
                      color: const Color(0xFF6C5CE7),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime.now();
                          _selectedDay = _focusedDay;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Color(0xFF6C5CE7),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3,
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: Color(0xFF6C5CE7)),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: Color(0xFF6C5CE7)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageCard() {
    final List<Map<String, String>> carouselItems = [
      {
        'image':
            'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=2070&auto=format&fit=crop',
        'title': 'Campus Life',
        'subtitle': 'Experience the vibrant college atmosphere',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=2086&auto=format&fit=crop',
        'title': 'Academic Excellence',
        'subtitle': 'Pursue your academic goals',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?q=80&w=2069&auto=format&fit=crop',
        'title': 'Innovation Hub',
        'subtitle': 'Discover new possibilities',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?q=80&w=2070&auto=format&fit=crop',
        'title': 'Research Center',
        'subtitle': 'Explore cutting-edge research',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=2070&auto=format&fit=crop',
        'title': 'Tech Labs',
        'subtitle': 'State-of-the-art facilities',
      },
    ];

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF6C5CE7),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayCurve: Curves.easeInOutCubic,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            pauseAutoPlayOnTouch: true,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          items: carouselItems
              .map((item) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item['subtitle']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 2),
                          color: Colors.grey.shade400,
                          blurRadius: 16,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Attendance',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            Text(
                              '${_getMonthName(_attendanceMonth.month)} ${_attendanceMonth.year}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('M',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text('T',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text('W',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text('T',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text('F',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text('S',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text('S',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: PageView.builder(
                            controller: _monthController,
                            onPageChanged: (page) {
                              final now = DateTime.now();
                              final difference = page - 1000;
                              setState(() {
                                _attendanceMonth =
                                    _calculateMonthOffset(now, difference);
                              });
                            },
                            itemBuilder: (context, pageIndex) {
                              final now = DateTime.now();
                              final difference = pageIndex - 1000;
                              final currentMonth =
                                  _calculateMonthOffset(now, difference);

                              return GridView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 4,
                                  childAspectRatio: 1,
                                ),
                                itemCount: _getDaysInMonth(currentMonth),
                                itemBuilder: (context, index) {
                                  final date = DateTime(currentMonth.year,
                                      currentMonth.month, index + 1);
                                  final attendance = _attendanceData[date];

                                  Color dotColor;
                                  switch (attendance) {
                                    case AttendanceStatus.present:
                                      dotColor = const Color.fromARGB(
                                          255, 43, 164, 77);
                                      break;
                                    case AttendanceStatus.absent:
                                      dotColor = const Color(0xFFFF7675);
                                      break;
                                    case AttendanceStatus.partial:
                                      dotColor = const Color(0xFF9BE9A8);
                                      break;
                                    default:
                                      dotColor =
                                          Colors.grey.shade300; // No data
                                  }

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: dotColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: dotColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                            color: dotColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        // const SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     _buildLegendItem(
                        //         'Present', const Color(0xFF40C463)),
                        //     const SizedBox(width: 16),
                        //     _buildLegendItem(
                        //         'Partial', const Color(0xFF9BE9A8)),
                        //     const SizedBox(width: 16),
                        //     _buildLegendItem('Absent', const Color(0xFFFF7675)),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.grey.shade400,
                          blurRadius: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.grey.shade400,
                          blurRadius: 8,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 2),
                          color: Colors.grey.shade400,
                          blurRadius: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        //container for heatmap
        Container(
          height: 460,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: Colors.grey.shade200,
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Live Location Heatmap',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_mockLocations.length} Active',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Stack(
                    children: [
                      Image.network(
                        'https://raw.githubusercontent.com/mannerishivardhan/ecap/main/assets/bhimavaram_map.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return CustomPaint(
                            size: const Size(double.infinity, double.infinity),
                            painter: HeatmapPainter(_mockLocations),
                          );
                        },
                      ),
                      ..._buildLocationMarkers(),
                    ],
                  ),
                ),
              ),
              _buildLocationLegend(),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'My Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: demoCourses.length,
                itemBuilder: (context, index) {
                  final course = demoCourses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailPage(course: course),
                        ),
                      );
                    },
                    child: Container(
                      key: Key(index.toString()),
                      height: 260,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            color: course.color.withOpacity(0.1),
                            blurRadius: 12,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: course.color.withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: course.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: course.color,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    course.code,
                                    style: TextStyle(
                                      color: course.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Text(
                                  course.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D3436),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: course.color.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          course.professor[0],
                                          style: TextStyle(
                                            color: course.color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course.professor,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF2D3436),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Professor',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Progress',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        Text(
                                          '${(course.progress * 100).toInt()}%',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: course.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: course.progress,
                                        backgroundColor:
                                            course.color.withOpacity(0.1),
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            course.color),
                                        minHeight: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRangeAttendance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attendance Analysis',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      label: 'Start Date',
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _startDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            _startDate = date;
                            _calculateAttendance();
                          });
                        }
                      },
                      date: _startDate,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDatePicker(
                      label: 'End Date',
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _endDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            _endDate = date;
                            _calculateAttendance();
                          });
                        }
                      },
                      date: _endDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildAttendanceStats(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required String label,
    required VoidCallback onTap,
    DateTime? date,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  date != null
                      ? DateFormat('MMM d, y').format(date)
                      : 'Select date',
                  style: TextStyle(
                    fontSize: 14,
                    color: date != null ? Colors.black87 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceStats() {
    if (_startDate == null || _endDate == null) {
      return Center(
        child: Text(
          'Select date range to view attendance',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      );
    }

    final totalDays = _endDate!.difference(_startDate!).inDays + 1;
    final presentDays = _calculatePresentDays();
    final attendancePercentage = (presentDays / totalDays * 100).toStringAsFixed(1);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              label: 'Total Days',
              value: totalDays.toString(),
              color: const Color(0xFF6C5CE7),
            ),
            _buildStatItem(
              label: 'Present Days',
              value: presentDays.toString(),
              color: const Color(0xFF00B894),
            ),
            _buildStatItem(
              label: 'Absent Days',
              value: (totalDays - presentDays).toString(),
              color: const Color(0xFFFF7675),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF00B894).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.pie_chart,
                color: Color(0xFF00B894),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Attendance: $attendancePercentage%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00B894),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  int _calculatePresentDays() {
    if (_startDate == null || _endDate == null) return 0;
    
    int presentDays = 0;
    DateTime currentDate = _startDate!;
    
    while (currentDate.isBefore(_endDate!.add(const Duration(days: 1)))) {
      if (_attendanceData[currentDate] == AttendanceStatus.present) {
        presentDays++;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    
    return presentDays;
  }

  void _calculateAttendance() {
    // This method will be called when date range changes
    // You can add additional logic here if needed
    setState(() {});
  }
}

class _TimetablePage extends StatefulWidget {
  const _TimetablePage({super.key});

  @override
  State<_TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<_TimetablePage> {
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  final List<String> _periods = [
    '9:00 - 9:50',
    '9:50 - 10:40',
    'Short Break (10:40 - 11:00)',
    '11:00 - 11:50',
    '11:50 - 12:40',
    'Lunch Break (12:40 - 1:30)',
    '1:30 - 2:20',
    '2:20 - 3:10',
    '3:10 - 4:00',
    '4:00 - 4:50'
  ];

  // Sample timetable data
  final Map<String, List<String>> _timetableData = {
    'Monday': ['Mathematics', 'Physics', 'Break', 'Chemistry', 'English', 'Lunch', 'Computer Science', 'Biology', 'Physical Education', 'Library'],
    'Tuesday': ['Physics', 'Mathematics', 'Break', 'English', 'Chemistry', 'Lunch', 'Biology', 'Computer Science', 'Art', 'Sports'],
    'Wednesday': ['Chemistry', 'English', 'Break', 'Mathematics', 'Physics', 'Lunch', 'Computer Science', 'Biology', 'Music', 'Counseling'],
    'Thursday': ['English', 'Chemistry', 'Break', 'Physics', 'Mathematics', 'Lunch', 'Biology', 'Computer Science', 'Dance', 'Club Activities'],
    'Friday': ['Computer Science', 'Biology', 'Break', 'Mathematics', 'Physics', 'Lunch', 'Chemistry', 'English', 'Yoga', 'Career Guidance'],
    'Saturday': ['Biology', 'Computer Science', 'Break', 'Physics', 'Chemistry', 'Lunch', 'Mathematics', 'English', 'Meditation', 'Sports'],
  };

  Color _getSubjectColor(String subject) {
    if (subject.contains('Break') || subject.contains('Lunch')) {
      return Colors.grey.shade100;
    }
    switch (subject) {
      case 'Mathematics':
        return Colors.blue.shade100;
      case 'Physics':
        return Colors.purple.shade100;
      case 'Chemistry':
        return Colors.green.shade100;
      case 'Biology':
        return Colors.orange.shade100;
      case 'English':
        return Colors.red.shade100;
      case 'Computer Science':
        return Colors.teal.shade100;
      default:
        return Colors.indigo.shade50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Class Timetable',
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with time periods
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(_periods.length, (index) {
                      final bool isBreak = _periods[index].contains('Break') || _periods[index].contains('Lunch');
                      return Container(
                        width: 120,
                        height: 60,
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isBreak ? Colors.grey.shade200 : const Color(0xFF6C5CE7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _periods[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isBreak ? Colors.black87 : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                // Timetable rows
                ...List.generate(_days.length, (dayIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C5CE7).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _days[dayIndex],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C5CE7),
                            ),
                          ),
                        ),
                        ...List.generate(_timetableData[_days[dayIndex]]!.length, (periodIndex) {
                          final subject = _timetableData[_days[dayIndex]]![periodIndex];
                          final isBreak = subject.contains('Break') || subject.contains('Lunch');
                          return Container(
                            width: 120,
                            height: 80,
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _getSubjectColor(subject),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isBreak ? Colors.grey.shade300 : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                subject,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isBreak ? FontWeight.normal : FontWeight.bold,
                                  color: isBreak ? Colors.grey.shade700 : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AssignmentsPage extends StatelessWidget {
  const _AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Assignments Page'));
  }
}

class _MorePage extends StatelessWidget {
  const _MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('More Page'));
  }
}
