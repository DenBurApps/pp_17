import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '/widgets/screens/lessons.dart';
import '/widgets/screens/news.dart';
import '/widgets/screens/settings.dart';
import '../../helpers/image/image_helper.dart';
import '../../services/event_bus.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int bottomSelectedIndex = 0;
  late StreamSubscription<Event> sub;
  final eventBus = GetIt.instance<EventBus>();

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    sub = eventBus.stream<Event>().listen((event) {
      if (event is News) {
        bottomTapped(1);
      } else if (event is Settings) {
        bottomTapped(2);
      }
    });
    super.initState();
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        LessonsView(),
        NewsView(),
        SettingsView(),
      ],
    );
  }

  Widget bottomNavigationBar() {
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              height: 65.0,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: const Color(0xFF8CA1C0),
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          selectedLabelStyle:
              TextStyle(color: Theme.of(context).colorScheme.onSurface),
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageHelper.getSvg(SvgNames.lessonsNotActive),
              activeIcon: ImageHelper.getSvg(SvgNames.lessonsActive),
              label: 'Lessons',
            ),
            BottomNavigationBarItem(
              icon: ImageHelper.getSvg(SvgNames.newsNotActive),
              activeIcon: ImageHelper.getSvg(SvgNames.newsActive),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: ImageHelper.getSvg(SvgNames.settingsNotActive),
              activeIcon: ImageHelper.getSvg(SvgNames.settingsActive),
              label: 'Settings',
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildPageView(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomNavigationBar(),
          )
        ],
      ),
    );
  }
}
