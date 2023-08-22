import 'package:devstash/models/Events.dart';
import 'package:devstash/screens/tasks/CalendarScreen.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final Function(Event) onDeleteEvent;

  const EventList({
    required this.events,
    required this.onDeleteEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: events.map((event) => _buildEventItem(event)).toList(),
    );
  }

  Widget _buildEventItem(Event event) {
    return ListTile(
      title: Text(event.title),
      subtitle: Text(event.description),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          onDeleteEvent(event);
        },
      ),
    );
  }
}
