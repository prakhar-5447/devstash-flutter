import 'dart:math';

import 'package:devstash/models/Events.dart';
import 'package:devstash/screens/tasks/CalendarScreen.dart';
import 'package:devstash/utils/utils.dart' as devstash_utils;
import 'package:flutter/material.dart';

class WeekdayTaskScreen extends StatefulWidget {
  @override
  _WeekdayTaskScreenState createState() => _WeekdayTaskScreenState();
}

class _WeekdayTaskScreenState extends State<WeekdayTaskScreen> {
  int _selectedDay = DateTime.now().weekday; // Initialize with current weekday
  final List<List<Event>> _tasks = List.generate(7, (index) => []);
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _loadEvents();
    _selectedDay =
        DateTime.now().weekday; // Set selected day to current weekday
  }

  void _loadEvents() async {
    List<Event> events = await _databaseHelper.getEvents();
    _populateTasks(events);
  }

  void _populateTasks(List<Event> events) {
    _tasks.forEach(
        (weekdayTasks) => weekdayTasks.clear()); // Clear existing tasks

    for (Event event in events) {
      if (devstash_utils.isDateInRange(
          event.date, _getFirstDayOfWeek(), _getLastDayOfWeek())) {
        int weekday = event.date.weekday;
        _tasks[weekday - 1].add(event);
      }
    }
  }

  DateTime _getFirstDayOfWeek() {
    DateTime now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  DateTime _getLastDayOfWeek() {
    DateTime now = DateTime.now();
    return now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Plans for this week",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 165, 165, 165),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: WeekdaySwitchButton(
                selectedDay: _selectedDay,
                onDaySelected: (day) {
                  setState(() {
                    _selectedDay = day;
                  });
                },
              ),
            )
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: max(0, constraints.maxHeight),
                minHeight: 0,
              ),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 500,
                  minHeight: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                  child: ListView.builder(
                    itemCount: _tasks[_selectedDay - 1].length,
                    itemBuilder: (context, index) {
                      List<Event> tasksForDay = _tasks[_selectedDay - 1];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                tasksForDay[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              tasksForDay[index].description,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 165, 165, 165),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class WeekdaySwitchButton extends StatelessWidget {
  final int selectedDay;
  final Function(int) onDaySelected;

  const WeekdaySwitchButton({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          renderBorder: false,
          isSelected: List.generate(7, (index) => index + 1 == selectedDay),
          fillColor: Colors.transparent,
          selectedColor: const Color.fromARGB(255, 241, 242, 246),
          splashColor: Colors.transparent,
          onPressed: (int newIndex) {
            onDaySelected(newIndex + 1);
          },
          children: [
            buildToggleButton('M', 1),
            buildToggleButton('T', 2),
            buildToggleButton('W', 3),
            buildToggleButton('T', 4),
            buildToggleButton('F', 5),
            buildToggleButton('S', 6),
            buildToggleButton('S', 7),
          ],
        ),
      ],
    );
  }

  Widget buildToggleButton(String label, int dayIndex) {
    final isSelected = dayIndex == selectedDay;
    final borderSide = BorderSide(
      color:
          isSelected ? const Color.fromARGB(255, 117, 140, 253) : Colors.grey,
      width: 2.0,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: isSelected ? borderSide : BorderSide.none,
          bottom: isSelected ? borderSide : BorderSide.none,
          left: isSelected ? borderSide : BorderSide.none,
          right: isSelected ? borderSide : BorderSide.none,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: isSelected
            ? const Color.fromARGB(255, 117, 140, 253)
            : Colors.transparent,
      ),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
            ),
          ],
        ),
      ),
    );
  }
}
