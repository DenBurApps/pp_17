import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/storage/storage_service.dart';
import '/services/navigation/route_names.dart';

import '../../helpers/constants.dart';

class SelectedInfoView extends StatefulWidget {
  const SelectedInfoView({super.key});

  @override
  State<SelectedInfoView> createState() => _SelectedInfoViewState();
}

class _SelectedInfoViewState extends State<SelectedInfoView> {
  final _storageService = GetIt.instance<StorageService>();
  var _completedLessons = <String>{};

  @override
  void initState() {
    super.initState();
    _completedLessons = (_storageService.getStringList(StorageKeys.completedLessons) ?? <String>[]).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final index =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final i = index['index'];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ))),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      headlines[i!],
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: DescriptionTextWidget(text: infoTexts[i]),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _completedLessons.add(i.toString());
                          _storageService.setStringList(StorageKeys.completedLessons, _completedLessons.toList());
                        });
                        Navigator.of(context).pushNamed(
                          RouteNames.quiz,
                          arguments: {'index': i},
                        );
                      },
                      child: Container(
                        height: 51,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text(
                                'Check knowledge',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({super.key, required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 500) {
      firstHalf = widget.text.substring(0, 500);
      secondHalf = widget.text.substring(500, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  child: Row(
                    children: [
                      Text(flag ? 'Read more' : "Show less",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: const Color(0xFFBDD6DE),
                                  )),
                      const Spacer(),
                      Icon(Icons.chevron_right_rounded,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
