import 'package:flutter/material.dart';
import 'package:pp_17/helpers/email_helper.dart';

class ContactDeveloperView extends StatefulWidget {
  const ContactDeveloperView({super.key});

  @override
  State<ContactDeveloperView> createState() => _ContactDeveloperViewState();
}

class _ContactDeveloperViewState extends State<ContactDeveloperView> {
  final TextEditingController _inputController_1 = TextEditingController();

  final TextEditingController _inputController_2 = TextEditingController();

  void _send() => EmailHelper.launchEmailSubmission(
        toEmail: 'toEmail',
        subject: _inputController_1.text,
        body: _inputController_2.text,
        errorCallback: () {},
        doneCallback: () => setState(() {
          _inputController_1.clear();
          _inputController_2.clear();
        }),
      );

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
                    Container(
                      width: double.infinity,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Contact developer',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _inputController_1,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Message subject',
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _inputController_2,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Message text',
                      ),
                    ),
                    const SizedBox(height: 60),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _inputController_2,
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: (_inputController_1.text.isNotEmpty &&
                                  _inputController_2.text.isNotEmpty)
                              ? _send
                              : null,
                          child: const Text('SEND'),
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
