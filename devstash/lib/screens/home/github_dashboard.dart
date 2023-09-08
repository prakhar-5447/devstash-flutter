import 'dart:developer';

import 'package:devstash/controllers/github_controller.dart';
import 'package:devstash/models/github/githubRepoIssueResponse.dart';
import 'package:devstash/services/GithubServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class Contributor {
  final String login;
  final int id;
  final String avatarUrl;
  final String url;
  final int contributions;

  Contributor({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.url,
    required this.contributions,
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

final List<Contributor> users = [
  Contributor(
    login: "Sahilkumar19",
    id: 124178990,
    avatarUrl: "https://avatars.githubusercontent.com/u/124178990?v=4",
    url: "https://api.github.com/users/Sahilkumar19",
    contributions: 100,
  ),
  Contributor(
    login: "Sahilkumar19",
    id: 124178990,
    avatarUrl: "https://avatars.githubusercontent.com/u/124178990?v=4",
    url: "https://api.github.com/users/Sahilkumar19",
    contributions: 100,
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
                IssueTab(),
                PullRequestTab(
                  issues: [],
                ),
                ContributorsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IssueTab extends StatelessWidget {
  Future<List<GithubRepoIssueResponse>> _getRepoIssue() async {
    late List<GithubRepoIssueResponse> repoIssue;

    dynamic res = await GithubServices().getRepoIssue();
    if (res['success']) {
      repoIssue = res['data'];
    } else {
      Fluttertoast.showToast(
        msg: res["data"].message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    return repoIssue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GithubRepoIssueResponse>>(
        future: _getRepoIssue(),
        builder: (BuildContext context,
            AsyncSnapshot<List<GithubRepoIssueResponse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GithubRepoIssueResponse>? issues = snapshot.data;
            if (issues == null) {
              return const Text('No projects data found.');
            }
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                  if (issues[index].assignees.isNotEmpty)
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  SizedBox(
                                    height: 20,
                                    child: Stack(
                                      children: issues[index]
                                          .assignees
                                          .asMap()
                                          .entries
                                          .map(
                                        (entry) {
                                          final double leftPosition =
                                              entry.key * 10;
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
                                                  entry.value.avatar_url,
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
                      if (index < issues.length - 1)
                        const Divider(
                          color: Colors.black26,
                          height: 0,
                        )
                    ],
                  );
                });
          }
        });
  }
}

class LanguageChart extends StatelessWidget {
  final Map<String, dynamic> languageData = {
    "Dart": 315182,
    "Go": 83562,
    "C++": 24121,
    "CMake": 18860,
    "Swift": 2545,
    "HTML": 1841,
    "Python": 1626,
    "C": 1425,
    "Kotlin": 125,
    "Makefile": 111,
    "Objective-C": 38
  };

  int totalLinesOfCode = 0;
  void calc(Map<String, dynamic> languageData) {
    languageData.forEach(
      (key, value) {
        totalLinesOfCode = totalLinesOfCode + value as int;
      },
    );
  }

  double calcpercentage(int value) {
    return (value / totalLinesOfCode * 100).toPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    calc(languageData);
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 0,
      childAspectRatio: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: languageData.entries
          .map(
            (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  color: predefinedColors[
                      languageData.keys.toList().indexOf(item.key) %
                          predefinedColors.length],
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: item.key,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' (${calcpercentage(item.value)} %)',
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  final List<Color> predefinedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];
}

class PullRequestTab extends StatelessWidget {
  final List<Issue> issues;

  PullRequestTab({required this.issues});

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
                  const Icon(
                    Icons.merge_type_rounded,
                    size: 18,
                    color: Colors.purple,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        CircleAvatar(
                          radius: 8,
                          backgroundImage: NetworkImage(
                            issues[index].user.avatarUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (index < issues.length - 1)
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

class ContributorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      users[index].avatarUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          users[index].login,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        Text(
                          'Contributons: ${users[index].contributions.toString()}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black26,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (index < users.length - 1)
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
