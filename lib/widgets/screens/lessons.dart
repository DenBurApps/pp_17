import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/storage/storage_service.dart';
import '/helpers/text_helper.dart';

import '../../helpers/image/image_helper.dart';
import '../../services/navigation/route_names.dart';

class LessonsView extends StatefulWidget {
  LessonsView({super.key});

  @override
  State<LessonsView> createState() => _LessonsViewState();
}

class _LessonsViewState extends State<LessonsView> {
  final _storageService = GetIt.instance<StorageService>();
  late final _completedLessons;

  @override
  void initState() {
    super.initState();
    _completedLessons =
        (_storageService.getStringList(StorageKeys.completedLessons) ??
                <String>[])
            .toSet();
  }

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
                          // setState(() {
                          //   _completedLessons.add(i.toString());
                          //   _storageService.setStringList(StorageKeys.completedLessons, _completedLessons.toList());
                          // });
                          Navigator.of(context).pushNamed(
                            RouteNames.selectedNews,
                            arguments: {'index': i},
                          );
                        },
                        textColor: (_completedLessons.contains(i.toString()))
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onSurface,
                        boxColor: (_completedLessons.contains(i.toString()))
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.background,
                      ),
                    const SizedBox(height: 60),
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
      {super.key,
      required this.text,
      required this.icon,
      required this.onTap,
      required this.textColor,
      required this.boxColor});

  final String text;
  final String icon;
  final VoidCallback onTap;
  final Color textColor;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(
              width: 1.0,
              color: textColor,
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
                    ImageHelper.getSvg(icon, color: textColor),
                    const SizedBox(width: 15),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              text,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: textColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: textColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
