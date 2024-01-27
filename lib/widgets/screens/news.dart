import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_17/helpers/image/image_helper.dart';
import '../../controller/news_controller.dart';
import '/widgets/screens/selected_info.dart';

class NewsView extends StatefulWidget {
  NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    _newsController.fetchNews();
  }

  final _newsController = GetIt.instance<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: AnimatedBuilder(
            builder: (context, child) {
              if (_newsController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                itemCount: _newsController.newsList.length - 1,
                itemBuilder: (context, index) {
                  final news = _newsController.newsList[index];
                  {
                    return NewsCard(
                      news: news['body'],
                      title: news['title'],
                      image: news['image'],
                    );
                  }
                },
              );
              }
            },
            animation: _newsController,
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key,
      required this.news,
      required this.title,
      required this.image});

  final String news;
  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
    // != null
                            image: (image!.isNotEmpty) ? NetworkImage(image!) : ImageHelper.getImage(ImageNames.plug).image,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DescriptionTextWidget(text: news),
              ],
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}

class NewsTextWidget extends StatefulWidget {
  final String text;

  const NewsTextWidget({super.key, required this.text});

  @override
  _NewsTextWidgetState createState() => _NewsTextWidgetState();
}

class _NewsTextWidgetState extends State<NewsTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
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
