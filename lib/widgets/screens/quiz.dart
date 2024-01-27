import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pp_17/helpers/text_helper.dart';

import '../../helpers/image/image_helper.dart';
import '../../services/navigation/route_names.dart';

class QuizView extends StatefulWidget {
  QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final _quizBox = Hive.box('appBox');

  late int index;

  int trying = 0;

  int correctAnswers = 0;

  int incorrectAnswers = 0;

  bool canShowResult = false;

  int? _yourAnswer = null;

  var _questions = [];

  @override
  void initState() {
    super.initState();
    _quizBox.put('chance', 10);
    index = 0;
  }

  void validate(choice) async {
    setState(() {
      _yourAnswer = choice;
    });

    if (choice == _questions[index]["answer"]) {
      setState(() {
        correctAnswers++;
        trying++;
      });
    } else {
      setState(() {
        incorrectAnswers++;
        trying++;
        _quizBox.put('chance', _quizBox.get('chance') - 1);
      });
    }

    if (trying == _questions.length ||
        _quizBox.get('chance') == 0 ||
        index == _questions.length - 1) {
      canShowResult = true;
    }
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _yourAnswer = null;
    });
    if(index >= _questions.length - 1) return;
    index++;
  }

  final _background = [
    ImageNames.quizBg_1,
    ImageNames.quizBg_2,
    ImageNames.quizBg_3,
    ImageNames.quizBg_4,
    ImageNames.quizBg_5,
  ];

  final _resultBackground = [
    ImageNames.win,
    ImageNames.lose,
  ];

  @override
  Widget build(BuildContext context) {
    final indexOfQuestions =
    ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final i = indexOfQuestions['index'];
    var questions = allQuestions[i!];
    _questions = questions;
    print(questions);
    print(index);
    final question = questions[index] as Map<String, dynamic>;
    final options = question['options'] as List<String>;
    if (canShowResult == true) {
      return QuizResultView(
        totalAnswers: 5,
        correctAnswers: correctAnswers,
        onPressed: () {
          setState(() {
            canShowResult = false;
            index = 0;
            trying = 0;
            correctAnswers = 0;
            incorrectAnswers = 0;
            canShowResult = false;
            Navigator.of(context).pushNamed(RouteNames.quiz);
          });
        }, resultBg: (correctAnswers == 5) ? _resultBackground.first : _resultBackground.last,
      );
    } else {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ImageHelper.getImage(_background[index]).image,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  QuizQuestionCard(
                    question: question["question"],
                    step: index + 1,
                  ),
                  QuizAnswerCard(
                    answer: options[0],
                    isCorrectAnswer: questions[index]['answer'] == 0,
                    isYourAnswer: _yourAnswer == 0,
                    isProcessing: _yourAnswer != null,
                    onPressed: () {
                      validate(0);
                    },
                  ),
                  QuizAnswerCard(
                    answer: options[1],
                    onPressed: () {
                      validate(1);
                    },
                    isYourAnswer: _yourAnswer == 1,
                    isProcessing: _yourAnswer != null,
                    isCorrectAnswer: questions[index]['answer'] == 1,
                  ),
                  QuizAnswerCard(
                    answer: options[2],
                    onPressed: () {
                      validate(2);
                    },
                    isYourAnswer: _yourAnswer == 2,
                    isProcessing: _yourAnswer != null,
                    isCorrectAnswer: questions[index]['answer'] == 2,
                  ),
                  QuizAnswerCard(
                    answer: options[3],
                    onPressed: () {
                      validate(3);
                    },
                    isYourAnswer: _yourAnswer == 3,
                    isProcessing: _yourAnswer != null,
                    isCorrectAnswer: questions[index]['answer'] == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class QuizAnswerCard extends StatelessWidget {
  const QuizAnswerCard({
    super.key,
    required this.answer,
    required this.onPressed,
    required this.isCorrectAnswer,
    required this.isYourAnswer,
    required this.isProcessing,
  });

  final String answer;
  final VoidCallback onPressed;
  final bool isCorrectAnswer;
  final bool isYourAnswer;
  final bool isProcessing;

  Color _getColor() {
    if (!isProcessing) return Colors.white;
    if (isYourAnswer && !isCorrectAnswer) return Colors.red;
    if (isCorrectAnswer) return const Color(0xFF60DC26);
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(_getColor()),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 1),
                    borderRadius: BorderRadius.circular(12)))),
            child: Center(
                child: Text(answer,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary))),
          )),
    );
  }
}

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard(
      {super.key, required this.question, required this.step});

  final String question;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$step/5',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                question,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizResultView extends StatelessWidget {
  QuizResultView(
      {super.key,
      required this.totalAnswers,
      required this.correctAnswers,
      required this.onPressed, required this.resultBg});

  final int totalAnswers;
  final String resultBg;
  final int correctAnswers;
  final VoidCallback onPressed;

  final _titles = [
    'You\'re good. That\'s a great result!',
    'Good result, you can try again!'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ImageHelper.getImage(resultBg).image,
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  _titles[0],
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(height: 19),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 51,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '$correctAnswers/$totalAnswers answers are correct',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height:20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onPressed;
                          Navigator.of(context).pushNamed(RouteNames.home);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.surface,
                            onPrimary: Theme.of(context).colorScheme.primary,
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        child: const Text('home'),
                      ),
                    ),
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
