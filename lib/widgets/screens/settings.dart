import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../services/navigation/route_names.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 33),
                SettingsButton(
                  text: 'Privacy Policy',
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.privacy);
                  },
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  text: 'Terms of use',
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.terms);
                  },
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  text: 'Share App',
                  onTap: () async {
                    if (await inAppReview.isAvailable()) {
                      await inAppReview.requestReview();
                    }
                  },
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  text: 'Rate App',
                  onTap: () async {
                    if (await inAppReview.isAvailable()) {
                      await inAppReview.requestReview();
                    }
                  },
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  text: 'Contact developer',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteNames.contactDeveloper);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          )
        ],
      ),
    );
  }
}
