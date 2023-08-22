import 'dart:io';

import 'package:devstash/models/Events.dart';
import 'package:devstash/utils/utils.dart' as devstash_utils;
import 'package:devstash/widgets/AppDrawer.dart';
import 'package:devstash/widgets/EventList.dart';
import 'package:devstash/widgets/EventModal.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'events.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT
      )
    ''');
  }

  Future<List<Event>> getEvents() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (index) {
      return Event(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: DateTime.parse(maps[index]['date']),
      );
    });
  }

  Future<void> insertEvent(Event event) async {
    Database db = await instance.database;
    await db.insert(
      'events',
      event.toMap(),
    );
  }

  Future<void> deleteEvent(int id) async {
    Database db = await instance.database;
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}

class CalendarScreen extends StatefulWidget {
  final BuildContext appContext; // Add appContext as a parameter

  CalendarScreen(this.appContext); // Constructor to receive the appContext

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime.utc(2023, 1, 1);
  DateTime _lastDay = DateTime.utc(2023, 12, 31);
  List<Event> _events = [];
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadEvents();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentIndex: 3),
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddEventModal(_focusedDay);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: const CalendarStyle(
              cellMargin: EdgeInsets.all(10),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 174, 183, 254),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xcc758bfd),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            firstDay: _firstDay,
            lastDay: _lastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return devstash_utils.isSameDay(_selectedDay, day) &&
                  devstash_utils.isSameMonth(_selectedDay, _focusedDay);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                if (!devstash_utils.isSameMonth(_focusedDay, _selectedDay)) {
                  _focusedDay = _selectedDay;
                }
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final eventDates = _events.map((event) => event.date).toList();
                if (eventDates.contains(date)) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: getEventsForSelectedDate(_selectedDay).length,
              itemBuilder: (context, index) {
                Event event = getEventsForSelectedDate(_selectedDay)[index];
                return EventList(
                  events: getEventsForSelectedDate(_selectedDay),
                  onDeleteEvent: (event) {
                    _deleteEvent(event);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Event> getEventsForSelectedDate(DateTime selectedDate) {
    return _events
        .where((event) => isSameDay(event.date, selectedDate))
        .toList();
  }

  void _showAddEventModal(DateTime day) {
    showModalBottomSheet(
      context: widget.appContext, // Access the context from the widget
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EventModal(
          selectedDate: day,
          onEventAdded: (title, description, date) {
            setState(() {
              _events.add(Event(
                title: title,
                description: description,
                date: date,
              ));
              _saveEvents();
            });
          },
        );
      },
    );
  }

  void _loadEvents() async {
    List<Event> events = await DatabaseHelper.instance.getEvents();
    setState(() {
      _events = events.toSet().toList(); // Remove duplicates using a Set
    });
  }

  void _saveEvents() async {
    List<Event> existingEvents = await DatabaseHelper.instance.getEvents();

    for (Event event in _events) {
      bool eventExists = existingEvents.any((existingEvent) =>
          existingEvent.title == event.title &&
          isSameDay(existingEvent.date, event.date));

      if (!eventExists) {
        await DatabaseHelper.instance.insertEvent(event);
      }
    }
  }

  void _deleteEvent(Event event) async {
    // Delete event from the database
    if (event.id != null) {
      await DatabaseHelper.instance.deleteEvent(event.id!);
      _loadEvents();
    }
  }
}
