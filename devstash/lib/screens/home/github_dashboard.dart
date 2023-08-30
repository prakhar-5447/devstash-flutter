import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Repo {
  final int id;
  final String name;
  final String fullName;
  final Owner owner;
  final String htmlUrl;
  final String? description;
  final bool fork;

  Repo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.htmlUrl,
    required this.description,
    required this.fork,
  });
}

class Owner {
  final String login;
  final int id;
  final String avatarUrl;

  Owner({
    required this.login,
    required this.id,
    required this.avatarUrl,
  });
}

List<Repo> mockRepos = [
  Repo(
    id: 542113002,
    name: "html-css-javascript",
    fullName: "pixel8cloud/html-css-javascript",
    owner: Owner(
      login: "pixel8cloud",
      id: 111991143,
      avatarUrl: "https://avatars.githubusercontent.com/u/111991143?v=4",
    ),
    htmlUrl: "https://github.com/pixel8cloud/html-css-javascript",
    description: null,
    fork: false,
  ),
  Repo(
    id: 531539336,
    name: "Learn-Git-and-Github",
    fullName: "pixel8cloud/Learn-Git-and-Github",
    owner: Owner(
      login: "pixel8cloud",
      id: 111991143,
      avatarUrl: "https://avatars.githubusercontent.com/u/111991143?v=4",
    ),
    htmlUrl: "https://github.com/pixel8cloud/Learn-Git-and-Github",
    description: null,
    fork: false,
  ),
];


class GithubDashboardContainer extends StatelessWidget {
  final controller = Get.put(GithubController());
  final List<String> _tabs = ['Issues', 'Pull Requests', 'Contributors'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: TabBar(
            controller: controller.tabController,
            dividerColor: Colors.transparent,
            tabs: _tabs
                .map(
                  (String tab) => Tab(
                    child: Text(
                      tab,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 75, 73, 70),
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 117, 140, 253),
                width: 3,
              ),
              insets: EdgeInsets.symmetric(
                horizontal: 0,
              ),
            ),
            automaticIndicatorColorAdjustment: true,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              RepoDetailsTab(repo: mockRepos[0]),
              PlaceholderTab(tabName: 'Pull Requests'),
              PlaceholderTab(tabName: 'Contributors'),
            ],
          ),
        ),
      ],
    );
  }
}

class GithubController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  void toggleTab(int newIndex) {
    selectedTabIndex.value = newIndex;
    tabController.animateTo(newIndex); // Switch to the selected tab
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class RepoDetailsTab extends StatelessWidget {
  final Repo repo;

  RepoDetailsTab({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(repo.owner.avatarUrl),
          radius: 40,
        ),
        const SizedBox(height: 16),
        Text(
          repo.fullName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          repo.description ?? 'No description available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Text(
          'Repository URL:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          repo.htmlUrl,
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ],
    );
  }
}

class PlaceholderTab extends StatelessWidget {
  final String tabName;

  PlaceholderTab({required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$tabName content goes here'),
    );
  }
}
