import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CampusEventsScreen extends StatefulWidget {
  const CampusEventsScreen({Key? key}) : super(key: key);

  @override
  State<CampusEventsScreen> createState() => _CampusEventsScreenState();
}

class _CampusEventsScreenState extends State<CampusEventsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<Map<String, dynamic>>> _events = {
    DateTime(2025, 11, 8): [
      {
        'title': 'Tech Symposium 2025',
        'time': '10:00 AM - 4:00 PM',
        'location': 'Main Auditorium',
        'type': 'Technical',
      }
    ],
    DateTime(2025, 11, 15): [
      {
        'title': 'Annual Cultural Fest',
        'time': '5:00 PM - 10:00 PM',
        'location': 'College Ground',
        'type': 'Cultural',
      }
    ],
    DateTime(2025, 11, 20): [
      {
        'title': 'Campus Recruitment Drive',
        'time': '9:00 AM - 6:00 PM',
        'location': 'Placement Cell',
        'type': 'Career',
      }
    ],
  };

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case 'Technical':
        return Colors.blue;
      case 'Cultural':
        return Colors.purple;
      case 'Career':
        return Colors.green;
      default:
        return Colors.grey;
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
        title: const Text('Campus Events'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
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
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _selectedDay != null &&
                    _getEventsForDay(_selectedDay!).isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _getEventsForDay(_selectedDay!).length,
                    itemBuilder: (context, index) {
                      final event = _getEventsForDay(_selectedDay!)[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getEventTypeColor(event['type'])
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      event['type'],
                                      style: TextStyle(
                                        color:
                                            _getEventTypeColor(event['type']),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                        Icons.notifications_outlined),
                                    onPressed: () {
                                      // TODO: Implement reminder functionality
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.share_outlined),
                                    onPressed: () {
                                      // TODO: Implement share functionality
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                event['title'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    event['time'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    event['location'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
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
                          'No events for ${DateFormat('MMMM d, y').format(_selectedDay!)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement add event functionality
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Event'),
        backgroundColor: const Color(0xFF6C5CE7),
      ),
    );
  }
}
