import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Favourites', 'Bookmarks'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                Text("FAVOURITES",
                    style: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ],
            ),
          )),
      TabBar(
        controller: _tabController,
        tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text('Tab 1 Content'),
              ),
            ),
            Container(
              color: Colors.green,
              child: const Center(
                child: Text('Tab 2 Content'),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
