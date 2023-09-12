import 'package:flutter/material.dart';

class Messages {
  String sender;
  String subject;
  String description;
  DateTime date;

  Messages({
    required this.sender,
    required this.subject,
    required this.description,
    required this.date,
  });
}

class InboxScreen extends StatelessWidget {
  final List<Messages> messages = [
    Messages(
      sender: "Prakhar Sahu",
      subject: "Important",
      description: "This is hereby inform that, tommorrow is day after today, this is day of day and day",
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 25,
                  right: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Inbox",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.notifications_none_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TabBar(
              labelPadding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.all(
                0,
              ),
              isScrollable: true,
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: "All"),
                Tab(text: "Important"),
                Tab(text: "Invitations"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      return Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.sender,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    message.description.length <= 100
                                        ? message.description
                                        : '${message.description.substring(0, 100)}...',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${message.date.hour}:${message.date.minute}",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Center(
                    child: Text("Important Tab Content"),
                  ),
                  const Center(
                    child: Text("Invitations Tab Content"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
