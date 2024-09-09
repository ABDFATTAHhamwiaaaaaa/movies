import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../home/pages/home_screen.dart';
import '../widget/class_onnoarding_scrren.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<ClassOnnoardingScrren> _onboardingScreens = [
    ClassOnnoardingScrren(
      title: 'The biggest international and local film streaming',
      subtitle: 'MOVIZONE brings you the best of both international and local cinema. Start your cinematic journey with us today!',
      image: 'assets/onboarding0.png',
    ),
    ClassOnnoardingScrren(
      title: 'Offers ad-free viewing of high quality',
      subtitle: 'Experience your favorite movies without interruptions. With MOVIZON',
      image: 'assets/onboarding1.png',
    ),
    ClassOnnoardingScrren(
      title: 'Our service brings together your favorite series',
      subtitle: 'Our service brings together your favorite series and films in one easy-to-use platform. Stream anytime, anywhere, and never miss an episode of the shows you love.',
      image: 'assets/onboarding2.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: _onboardingScreens.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Image.asset(
                  _onboardingScreens[index].image,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                );
              },
            ).animate().fade(),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: const Color(0xff1F1D2B),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: MediaQuery.of(context).size.height * .45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      _onboardingScreens[_currentIndex].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().slideX(),
                    Text(
                      _onboardingScreens[_currentIndex].subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().slideX(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: _onboardingScreens.length,
                          effect: ExpandingDotsEffect(
                            dotColor: const Color(0xff12CDD9).withOpacity(.5),
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 20,
                            activeDotColor: const Color(0xff12CDD9),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff12CDD9),
                            fixedSize: const Size(70, 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (_currentIndex < _onboardingScreens.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: const Color(0xff1F1D2B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
