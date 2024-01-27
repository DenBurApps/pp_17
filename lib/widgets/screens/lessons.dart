import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pp_17/helpers/text_helper.dart';

import '../../helpers/image/image_helper.dart';
import '../../services/navigation/route_names.dart';

class LessonsView extends StatelessWidget {
  LessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SafeArea(
          child: ListView(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
                items: carouselImages
                    .map((item) => Container(
                          child: Center(
                              child: ImageHelper.getImage(item,
                                  fit: BoxFit.cover, width: 1000)),
                        ))
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    for (int i = 0; i < headlines.length; i++)
                      LessonButton(
                        text: headlines[i],
                        icon: icons[i % 5],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouteNames.selectedNews,
                            arguments: {'index': i},
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonButton extends StatelessWidget {
  LessonButton(
      {super.key, required this.text, required this.icon, required this.onTap});

  final String text;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ImageHelper.getSvg(icon),
                    const SizedBox(width: 15),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
