import 'dart:developer';

import 'package:devstash/controllers/github_controller.dart';
import 'package:devstash/models/github/githubRepoContributerResponse.dart';
import 'package:devstash/models/github/githubRepoIssueResponse.dart';
import 'package:devstash/models/github/githubRepoPullResponse.dart';
import 'package:devstash/services/GithubServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
                PullRequestTab(),
                ContributorsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageChart extends StatelessWidget {
  Future<Map<String, dynamic>?> _getRepoLanguage() async {
    late Map<String, dynamic> languageData;
    dynamic res = await GithubServices().getRepoLanguages();
    if (res['success']) {
      languageData = res['data'];
    } else {
      Fluttertoast.showToast(
        msg: res["data"].message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }

    return languageData;
  }

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
    return FutureBuilder<Map<String, dynamic>?>(
        future: _getRepoLanguage(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, dynamic>? languages = snapshot.data;
            if (languages == null) {
              return const Text('Not able to fetch data');
            }
            calc(languages);
            return GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              childAspectRatio: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: languages.entries
                  .map(
                    (item) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          color: predefinedColors[
                              languages.keys.toList().indexOf(item.key) %
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
        });
  }

  final List<Color> predefinedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];
}

class IssueTab extends StatelessWidget {
  Future<List<GithubRepoIssueResponse>?> _getRepoIssue() async {
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
      return null;
    }

    return repoIssue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GithubRepoIssueResponse>?>(
        future: _getRepoIssue(),
        builder: (BuildContext context,
            AsyncSnapshot<List<GithubRepoIssueResponse>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GithubRepoIssueResponse>? issues = snapshot.data;
            if (issues == null) {
              return const Text('Not able to fetch data');
            } else if (issues.isEmpty) {
              return const Text('No data found');
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

class PullRequestTab extends StatelessWidget {
  Future<List<GithubRepoPullResponse>?> _getRepoPull() async {
    late List<GithubRepoPullResponse> repoPull;

    dynamic res = await GithubServices().getRepoPull();
    if (res['success']) {
      repoPull = res['data'];
    } else {
      Fluttertoast.showToast(
        msg: res["data"].message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }

    return repoPull;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GithubRepoPullResponse>?>(
      future: _getRepoPull(),
      builder: (BuildContext context,
          AsyncSnapshot<List<GithubRepoPullResponse>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<GithubRepoPullResponse>? pulls = snapshot.data;
          if (pulls == null) {
            return const Text('Not able to fetch data');
          } else if (pulls.isEmpty) {
            return const Text('No data found');
          }
          return ListView.builder(
            itemCount: pulls.length,
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
                                      text: pulls[index].title,
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          '#${pulls[index].number.toString()}',
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
                              if (pulls[index].user != null)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundImage: NetworkImage(
                                        pulls[index].user.avatar_url,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index < pulls.length - 1)
                    const Divider(
                      color: Colors.black26,
                      height: 0,
                    )
                ],
              );
            },
          );
        }
      },
    );
  }
}

class ContributorsTab extends StatelessWidget {
  Future<List<GithubRepoContributerResponse>?> _getRepoContributer() async {
    late List<GithubRepoContributerResponse> repoContributer;

    dynamic res = await GithubServices().getRepoContributors();
    if (res['success']) {
      repoContributer = res['data'];
    } else {
      Fluttertoast.showToast(
        msg: res["data"].message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }

    return repoContributer;
  }

  List<GithubRepoIssueResponse> contributer = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GithubRepoContributerResponse>?>(
      future: _getRepoContributer(),
      builder: (BuildContext context,
          AsyncSnapshot<List<GithubRepoContributerResponse>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<GithubRepoContributerResponse>? contributers = snapshot.data;
          if (contributers == null) {
            return const Text('Not able to fetch data');
          } else if (contributers.isEmpty) {
            return const Text('No data found');
          }
          return ListView.builder(
            itemCount: contributers.length,
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
                            contributers[index].avatar_url,
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
                                contributers[index].login,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                              Text(
                                'Contributons: ${contributers[index].contributions}',
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
                  if (index < contributers.length - 1)
                    const Divider(
                      color: Colors.black26,
                      height: 0,
                    )
                ],
              );
            },
          );
        }
      },
    );
  }
}
