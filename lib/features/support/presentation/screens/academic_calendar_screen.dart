import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AcademicCalendarScreen extends StatefulWidget {
  const AcademicCalendarScreen({Key? key}) : super(key: key);

  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, dynamic>>> _academicEvents = {
    DateTime(2025, 11, 1): [
      {
        'title': 'Mid-Term Examinations Begin',
        'type': 'Exam',
      }
    ],
    DateTime(2025, 11, 15): [
      {
        'title': 'Mid-Term Examinations End',
        'type': 'Exam',
      }
    ],
    DateTime(2025, 11, 20): [
      {
        'title': 'Project Submissions Due',
        'type': 'Deadline',
      }
    ],
    DateTime(2025, 12, 1): [
      {
        'title': 'Winter Break Begins',
        'type': 'Holiday',
      }
    ],
  };

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _academicEvents[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case 'Exam':
        return Colors.red;
      case 'Deadline':
        return Colors.orange;
      case 'Holiday':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Calendar'),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilters(),
          _buildCalendar(),
          _buildEventsList(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildFilterChip('Exams', Colors.red),
          const SizedBox(width: 8),
          _buildFilterChip('Deadlines', Colors.orange),
          const SizedBox(width: 8),
          _buildFilterChip('Holidays', Colors.green),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, Color color) {
    return FilterChip(
      label: Text(label),
      labelStyle: const TextStyle(color: Colors.white),
      selected: true,
      selectedColor: color,
      onSelected: (bool selected) {
        // TODO: Implement filter functionality
      },
    );
  }

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2025, 1, 1),
        lastDay: DateTime.utc(2025, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        eventLoader: _getEventsForDay,
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: Color(0xFF6C5CE7),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Color(0xFF6C5CE7),
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    final events = _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    return Expanded(
      child: events.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No academic events today',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final color = _getEventTypeColor(event['type']);

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getEventIcon(event['type']),
                        color: color,
                      ),
                    ),
                    title: Text(
                      event['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          event['type'],
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'Exam':
        return Icons.edit_note;
      case 'Deadline':
        return Icons.timer;
      case 'Holiday':
        return Icons.event;
      default:
        return Icons.calendar_today;
    }
  }
}
