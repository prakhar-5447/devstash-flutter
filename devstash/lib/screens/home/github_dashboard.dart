import 'package:devstash/controllers/github_controller.dart';
import 'package:devstash/services/GithubServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Issue {
  final String url;
  final String repositoryUrl;
  final String htmlUrl;
  final int id;
  final String title;
  final User user;
  final String state;
  final bool locked;
  final int comments;
  final int number;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? closedAt;
  final String authorAssociation;
  final String body;
  final List<User> assignees;

  Issue({
    required this.url,
    required this.repositoryUrl,
    required this.htmlUrl,
    required this.id,
    required this.title,
    required this.user,
    required this.state,
    required this.locked,
    required this.comments,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    this.closedAt,
    required this.authorAssociation,
    required this.body,
    required this.assignees,
  });
}

class User {
  final String login;
  final int id;
  final String avatarUrl;
  final String url;

  User({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.url,
  });
}

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

final user = User(
  login: "Sahilkumar19",
  id: 124178990,
  avatarUrl: "https://avatars.githubusercontent.com/u/124178990?v=4",
  url: "https://api.github.com/users/Sahilkumar19",
);

final List<Issue> issuelist = [
  Issue(
    url:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java/issues/1146",
    repositoryUrl:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java",
    htmlUrl:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java/issues/1146/labels{/name}",
    id: 1873679614,
    title:
        "General message to all the folks regarding not able to access the files",
    user: user,
    state: "open",
    locked: false,
    comments: 0,
    number: 1152,
    createdAt: DateTime.parse("2023-08-30T13:25:59Z"),
    updatedAt: DateTime.parse("2023-08-30T13:25:59Z"),
    closedAt: null,
    authorAssociation: "NONE",
    body:
        "Those who are raising new issues regarding the notes (pdf) for them please fork the repo and clone it to your local system giving correct path of directory (or where you want to locate this) .You will be able to see all the code files and pdf files. Hope it will help you.Let me know if you are still not able to get the notes.\r\nEdited:\r\nyou can access it by using <>Code button. ",
    assignees: [
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
    ],
  ),
  Issue(
    url:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java/issues/1146",
    repositoryUrl:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java",
    htmlUrl:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java/issues/1146/labels{/name}",
    id: 1873679614,
    title:
        "General message to all the folks regarding not able to access the files",
    user: user,
    state: "open",
    locked: false,
    comments: 0,
    number: 1153,
    createdAt: DateTime.parse("2023-08-30T13:25:59Z"),
    updatedAt: DateTime.parse("2023-08-30T13:25:59Z"),
    closedAt: null,
    authorAssociation: "NONE",
    body:
        "Those who are raising new issues regarding the notes (pdf) for them please fork the repo and clone it to your local system giving correct path of directory (or where you want to locate this) .You will be able to see all the code files and pdf files. Hope it will help you.Let me know if you are still not able to get the notes.\r\nEdited:\r\nyou can access it by using <>Code button. ",
    assignees: [
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
    ],
  ),
  Issue(
    url:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java/issues/1146",
    repositoryUrl:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java",
    htmlUrl:
        "https://api.github.com/repos/kunal-kushwaha/DSA-Bootcamp-Java/issues/1146/labels{/name}",
    id: 1873679614,
    title:
        "General message to all the folks regarding not able to access the files",
    user: user,
    state: "open",
    locked: false,
    comments: 0,
    number: 1153,
    createdAt: DateTime.parse("2023-08-30T13:25:59Z"),
    updatedAt: DateTime.parse("2023-08-30T13:25:59Z"),
    closedAt: null,
    authorAssociation: "NONE",
    body:
        "Those who are raising new issues regarding the notes (pdf) for them please fork the repo and clone it to your local system giving correct path of directory (or where you want to locate this) .You will be able to see all the code files and pdf files. Hope it will help you.Let me know if you are still not able to get the notes.\r\nEdited:\r\nyou can access it by using <>Code button. ",
    assignees: [
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
      User(
        avatarUrl: 'https://avatars.githubusercontent.com/u/124178990?v=4',
        login: 'prakhar-5447',
        url: 'https://github.com/prakhar-5447',
        id: 1234,
      ),
    ],
  ),
];

class GithubDashboardContainer extends StatelessWidget {
  final controller = Get.put(GithubController());
  final List<String> _tabs = ['Issues', 'Pull Requests', 'Contributors'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffbebebe),
              offset: Offset(10, 10),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Obx(
              () => TabBar(
                controller: controller.tabController,
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.all(
                  0,
                ),
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabs: _tabs
                    .map(
                      (String tab) => Tab(
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: controller.selectedTabIndex.value ==
                                    _tabs.indexOf(tab)
                                ? Colors.black
                                : Colors.black26,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: false,
                        ),
                      ),
                    )
                    .toList(),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                  insets: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const ClampingScrollPhysics(),
              controller: controller.tabController,
              children: [
                IssueTab(issues: issuelist),
                PlaceholderTab(tabName: 'Pull Requests'),
                ContributorsLoadingTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IssueTab extends StatelessWidget {
  final List<Issue> issues;

  const IssueTab({required this.issues});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: issues.length,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 18,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/open_issue.svg',
                    width: 15,
                    fit: BoxFit.cover,
                    color: Colors.green,
                    theme: const SvgTheme(
                      currentColor: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: issues[index].title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                              WidgetSpan(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  child: Text(
                                    '#${issues[index].number.toString()}',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Comfortaa',
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 20,
                          child: Stack(
                            children:
                                issues[index].assignees.asMap().entries.map(
                              (entry) {
                                final double leftPosition = entry.key * 10;
                                return Positioned(
                                  left: leftPosition,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: NetworkImage(
                                        entry.value.avatarUrl,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (index < issuelist.length - 1)
              const Divider(
                color: Colors.black26,
                height: 0,
              )
          ],
        );
      },
    );
  }
}

class DonutChartWithLegend extends StatelessWidget {
  final Map<String, dynamic> languageData;

  DonutChartWithLegend({
    required this.languageData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: languageData.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: predefinedColors[
                      languageData.keys.toList().indexOf(entry.key)],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  final List<Color> predefinedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];
}

class PlaceholderTab extends StatelessWidget {
  final String tabName;

  PlaceholderTab({required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Text('$tabName content goes here');
  }
}

class ContributorsLoadingTab extends StatefulWidget {
  @override
  _ContributorsLoadingTabState createState() => _ContributorsLoadingTabState();
}

class _ContributorsLoadingTabState extends State<ContributorsLoadingTab> {
  List<dynamic> contributors = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: GithubServices().fetchContributors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final contributors = snapshot.data!;
          return ListView.builder(
            itemCount: contributors.length,
            itemBuilder: (context, index) {
              final contributor = contributors[index];
              return Column(
                children: [
                  ListTile(
                    dense: true,
                    onTap: () {
                      // Handle tap
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contributor['avatar_url']),
                      radius: 15,
                    ),
                    title: Text(contributor['login']),
                    subtitle:
                        Text('Contributions: ${contributor['contributions']}'),
                  ),
                  if (index < contributors.length - 1)
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black26,
                    ),
                ],
              );
            },
          );
        } else {
          return Center(child: Text('No contributors found.'));
        }
      },
    );
  }
}
