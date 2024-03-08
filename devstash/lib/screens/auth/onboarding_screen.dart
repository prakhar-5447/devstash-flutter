import 'package:devstash/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  List<OnboardingPage> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      const OnboardingPage(
        title: 'Connect',
        subtitle: '& Chat',
        description: '"Find and chat with developers from all over the world."',
        image: 'assets/chat_connect.png',
      ),
      const OnboardingPage(
        title: 'Create',
        subtitle: 'Profile',
        description:
            '"Add your skills and projects and share with your friends."',
        image: 'assets/profile.png',
      ),
      const OnboardingPage(
        title: 'Meet New',
        subtitle: 'Peoples',
        description: '"Find Simmilar peoples based on your skills."',
        image: 'assets/meet_peoples.png',
      ),
      const OnboardingPage(
        title: 'Welcome',
        subtitle: 'to Devstash',
        description:
            '"Join our platform with developers from different places and start new journey."',
        image: 'assets/join.png',
      )
    ];
  }

  void _goToNextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      setState(() {
        _currentPageIndex += 1;
      });
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                top: 25.0,
                bottom: 40.0,
                left: 25.0,
                right: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < _pages.length; i++)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentPageIndex == i ? 12.0 : 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: _currentPageIndex == i
                                  ? const Color.fromARGB(255, 91, 104, 224)
                                  : const Color.fromARGB(255, 225, 224, 224),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    _pages[_currentPageIndex].title,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 66, 157),
                    ),
                  ),
                  _pages[_currentPageIndex].subtitle != ''
                      ? Text(
                          _pages[_currentPageIndex].subtitle,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 66, 157),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      _pages[_currentPageIndex].description,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 171, 171, 171)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  _currentPageIndex != _pages.length - 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _currentPageIndex = _pages.length - 1;
                                });
                                _pageController.jumpToPage(_currentPageIndex);
                              },
                              child: const Text(
                                'Skip Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    const Color.fromARGB(255, 91, 104, 224)
                                        .withOpacity(0.8),
                                    const Color.fromARGB(255, 91, 104, 224),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: _goToNextPage,
                                icon: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 5, 66, 157),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AuthScreen(),
                                      ));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Text(
                                    "Get Started",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String image;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 250,
          margin: const EdgeInsets.only(
            top: 100,
          ),
          child: Image.asset(
            image,
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
