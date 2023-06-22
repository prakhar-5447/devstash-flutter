import 'package:flutter/material.dart';

class Task {
  final String day;
  final String taskName;

  Task(this.day, this.taskName);
}

class WeekdayTaskScreen extends StatefulWidget {
  @override
  _WeekdayTaskScreenState createState() => _WeekdayTaskScreenState();
}

class _WeekdayTaskScreenState extends State<WeekdayTaskScreen> {
  int _selectedDay = DateTime.now().weekday; // Initialize with current weekday
  List<Task> _tasks = [
    Task('Monday', 'Task 1'),
    Task('Tuesday', 'Task 2'),
    Task('Wednesday', 'Task 3'),
    Task('Thursday', 'Task 4'),
    Task('Friday', 'Task 5'),
    Task('Saturday', 'Task 6'),
    Task('Sunday', 'Task 7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 55, 0, 15),
              child: Text(
                "Plans for this week",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 165, 165, 165),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Tasks for ${_tasks[_selectedDay - 1].day}:',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(_tasks[_selectedDay - 1].taskName),
      ],
    );
  }
}

class WeekdaySwitchButton extends StatelessWidget {
  final int selectedDay;
  final Function(int) onDaySelected;

  const WeekdaySwitchButton({
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
