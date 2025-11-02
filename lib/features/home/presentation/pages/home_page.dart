import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecap/features/home/presentation/pages/profile_page.dart';
import 'package:table_calendar/table_calendar.dart';

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

class _DashboardPageState extends State<_DashboardPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _attendanceMonth = DateTime.now();

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
              _buildRecentFiles(),
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF8E8E8E),
          ),
        ),
      ],
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
                            Row(
                              spacing: 2,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _attendanceMonth = DateTime(
                                        _attendanceMonth.year,
                                        _attendanceMonth.month - 1,
                                      );
                                    });
                                  },
                                  child: const Icon(Icons.chevron_left,
                                      size: 20),
                                ),
                                Text(
                                  _getMonthName(_attendanceMonth.month),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _attendanceMonth = DateTime(
                                        _attendanceMonth.year,
                                        _attendanceMonth.month + 1,
                                      );
                                    });
                                  },
                                  child: const Icon(Icons.chevron_right,
                                      size: 20),
                                ),
                              ],
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                              Text('T',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                              Text('W',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                              Text('T',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                              Text('F',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                              Text('S',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                              Text('S',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 4,
                              childAspectRatio: 1,
                            ),
                            itemCount: _getDaysInMonth(_attendanceMonth),
                            itemBuilder: (context, index) {
                              final date = DateTime(_attendanceMonth.year,
                                  _attendanceMonth.month, index + 1);
                              final attendance = _attendanceData[date];

                              Color dotColor;
                              switch (attendance) {
                                case AttendanceStatus.present:
                                  dotColor = const Color(0xFF40C463);
                                  break;
                                case AttendanceStatus.absent:
                                  dotColor = const Color(0xFFFF7675);
                                  break;
                                case AttendanceStatus.partial:
                                  dotColor = const Color(0xFF9BE9A8);
                                  break;
                                default:
                                  dotColor = Colors.grey.shade300; // No data
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
                                      fontSize: 12
                                    ),
                                  ),
                                ),
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
        Container(
          height: 460,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.lightGreenAccent,
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
        ),
        const SizedBox(height: 26),
        SizedBox(
          height: 260,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                key: Key(index.toString()),
                height: 260,
                width: 200,
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
                      color: Colors.grey.shade200,
                      blurRadius: 16,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentFiles() {
    final recentFiles = [
      _RecentFile(
        name: 'DS Assignment',
        type: 'PDF',
        size: '2.5 MB',
        icon: Icons.picture_as_pdf,
        color: const Color(0xFFFF7675),
      ),
      _RecentFile(
        name: 'DBMS Lecture',
        type: 'Video',
        size: '45 MB',
        icon: Icons.video_library,
        color: const Color(0xFF74B9FF),
      ),
      _RecentFile(
        name: 'Course Material',
        type: 'Folder',
        size: '120 MB',
        icon: Icons.folder,
        color: const Color(0xFF55EFC4),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Files',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...recentFiles.map((file) => _buildRecentFileItem(file)),
      ],
    );
  }

  Widget _buildRecentFileItem(_RecentFile file) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: file.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(file.icon, color: file.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${file.type} • ${file.size}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _RecentFile {
  final String name;
  final String type;
  final String size;
  final IconData icon;
  final Color color;

  _RecentFile({
    required this.name,
    required this.type,
    required this.size,
    required this.icon,
    required this.color,
  });
}

class _TimetablePage extends StatelessWidget {
  const _TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Timetable Page'));
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
