
import 'package:devstash/models/Project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    List<Project> projects = [
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      )
    ];

    List<String> tech = [
      "React",
      "Golang",
      "Javascript",
      "Angular",
      "C++",
      "Typescript",
      "React Native",
    ];

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 500,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                        image: const AssetImage(
                          "assets/banner.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 25,
                    child: SvgPicture.asset(
                      'assets/arrow.svg',
                      height: 15.0,
                      width: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                      offset: const Offset(0, 75),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(-0.01, 2.25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://avatars.githubusercontent.com/u/80202909?s=400&u=eb9dc715363d2d16941b2a809567e7fb685a9a16&v=4',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.93, 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'PORTFOLIO',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          'assets/redirect.svg',
                          height: 10.0,
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    children: [
                      Text(
                        'PRAKHAR SAHU',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '@prakhar-5447',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 165, 165, 165)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                        child: Text(
                          "I am Full Stack Developer and React Native Developer. Pursuing BTech CSE'24 from Shri Shankaracharya Technical Campus, Bhilai.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 165, 165, 165)),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/google.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/linkedin.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/github.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/linkedin.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Projects",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: GridView.builder(
                          shrinkWrap:
                              true, // Allow the GridView to take only the necessary height
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns in the grid
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: projects.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.darken,
                                    ),
                                    image: const AssetImage(
                                      "assets/banner.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Education",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 241, 242, 246),
                        ),
                        child: const ListTile(
                          title: Text(
                            "Shri Shankaracharya Technical Campus, Junwani, Bhilai",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            "Computer Science and Engineering\n2020 - 2024",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 165, 165, 165),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 241, 242, 246),
                        ),
                        child: const ListTile(
                          title: Text(
                            "Gyandeep Higher Secondary school, Janjgir-Champa",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            "12th - Maths\n2020",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 165, 165, 165),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Projects",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: tech
                            .map(
                              (item) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    margin:
                                        const EdgeInsets.only(top: 6, right: 6),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 75, 73, 70),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 241, 242, 246),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    'assets/navigator.svg',
                                    height: 15.0,
                                    width: 15.0,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Janjgir-Champa, Chhattisgarh',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 75, 73, 70),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/email.svg',
                                      height: 15.0,
                                      width: 15.0,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'sahuprakhar022003@gmail.com',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 75, 73, 70),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    'assets/phone.svg',
                                    height: 15.0,
                                    width: 15.0,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      '+91 9826412657',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 75, 73, 70),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
