import 'package:flutter/material.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

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
              const SizedBox(height: 5),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 51,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Privacy Policy',
                      style:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Privacy Policy for "bfair store" Mobile Application\nThis Privacy Policy outlines how your information is collected, used, and shared when you use the "bfair store" mobile application (referred to as the "App").\nCollection of Information: When you use the App, certain information may be collected from you, including:\nPersonal Information: Your name, email address, and other contact information you voluntarily provide when creating an account or contacting us through the App.\nUsage Information: Information about how you use the App, your device\'s internet protocol (IP) address, and statistics about your activities within the App.\nDevice Information: Information about the device you are using, including its make, model, operating system, and unique device identifiers.\nUse of Information: The information collected may be used to:\nProvide and maintain the App\'s functionality and services.\nPersonalize your experience with the App and improve its features.\nCommunicate with you, including responding to inquiries or providing updates.\nAnalyze usage and trends to improve the App\'s performance and optimize user experience.\nSharing of Information: We may share your information with third parties for limited purposes, including:\nService Providers: We may engage third-party companies or individuals to perform functions on our behalf, such as hosting, data storage, and analysis. These service providers will have access to your information only to perform these functions and are obligated to keep it confidential.\nLegal Compliance and Protection: We may disclose your information if required by law or in response to valid requests from authorized law enforcement or government agencies.\nData Security: The security of your information is important to us, and we take reasonable precautions to protect it. However, no data transmission over the internet or electronic storage is entirely secure, and we cannot guarantee absolute security.\nData Retention: We will retain your information for as long as necessary to fulfill the purposes outlined in this Privacy Policy or as required by law.\nYour Choices: You have the right to access and control your personal information. You may update or delete your account information by contacting us through the contact details provided below.\nChanges to this Privacy Policy: We reserve the right to modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy within the App. Your continued use of the App after any modifications will constitute your acknowledgment and acceptance of the modified Privacy Policy.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
