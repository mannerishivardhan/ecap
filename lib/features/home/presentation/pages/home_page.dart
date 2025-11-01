import 'package:flutter/material.dart';

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

class _DashboardPage extends StatelessWidget {
  const _DashboardPage({super.key});

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
              SizedBox(
                height: 5,
              ),
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
              icon: Icon(
                Icons.person_2_outlined,
                size: 28,
                color: Color(0xFF4A4A4A),
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 16,
            )
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
}

Widget _buildStorageCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF6C5CE7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Academic Storage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.more_vert, color: Colors.white),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.cloud, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Storage',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '128 GB',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '65% used',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.65,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 10,
          ),
        ),
      ],
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
                        color: Colors.blue,
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 2),
                            color: Colors.grey.shade400,
                            blurRadius: 16,
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 6,
                  ),
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
                            offset: Offset(0, 2),
                            color: Colors.grey.shade400,
                            blurRadius: 8,
                          )
                        ]),
                  )
                ],
              )),
          SizedBox(
            width: 6,
          ),
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
                            offset: Offset(0, 2),
                            color: Colors.grey.shade400,
                            blurRadius: 8,
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 6,
                  ),
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
                            offset: Offset(1, 2),
                            color: Colors.grey.shade400,
                            blurRadius: 8,
                          )
                        ]),
                  )
                ],
              ))
        ],
      ),
      SizedBox(
        height: 32,
      ),
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
                offset: Offset(1, 2),
                color: Colors.grey.shade400,
                blurRadius: 16,
              )
            ]),
      ),
      SizedBox(
        height: 26,
      ),
      SizedBox(
        height: 260,
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
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
                        offset: Offset(1, 2),
                        color: Colors.grey.shade200,
                        blurRadius: 16,
                      )
                    ]),
              );
            }),
      ),
    ],
  );
}

Widget _buildQuickAccessItem({
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Container(
    width: 100,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
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
