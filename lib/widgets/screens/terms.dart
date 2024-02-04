import 'package:flutter/material.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

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
                      'Terms of use',
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
                  'Please read these Terms of Use ("Terms") carefully before using the "bfair store" mobile application (the "App") operated by [Your Company Name] ("us", "we", or "our").\nBy accessing or using the App, you agree to be bound by these Terms. If you disagree with any part of the Terms, then you may not access the App.\nUse of the App 1.1. The App allows users to browse, purchase, and manage products and services provided by [Your Company Name]. 1.2. You must be at least 18 years old to use the App or have consent from a legal guardian.\nIntellectual Property 2.1. All the content, graphics, logos, trademarks, and intellectual property rights within the App are owned by us or our licensors. 2.2. You may not copy, modify, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any part of the App without our prior written consent.\nUser Accounts 3.1. To access certain features or make purchases through the App, you may be required to create a user account. 3.2. You are solely responsible for maintaining the confidentiality of your account information, including your username and password. 3.3. If you suspect any unauthorized access to your account, you must immediately notify us. 3.4. We reserve the right to terminate or suspend any user accounts at our discretion without prior notice.\nPrivacy Policy 4.1. Our Privacy Policy governs the collection, use, and disclosure of personal information you provide while using the App. 4.2. By using the App, you consent to the collection and use of your information in accordance with our Privacy Policy.\nProhibited Activities 5.1. You agree not to engage in any of the following activities: a) Violating any applicable laws or regulations. b) Interfering with the security or functionality of the App. c) Transmitting any viruses, worms, or other malicious code. d) Impersonating any person or entity. e) Engaging in any fraudulent activity.\nDisclaimer of Warranties 6.1. The App is provided on an "as-is" and "as available" basis without any warranties or representations, express or implied. 6.2. We do not guarantee that the App will be error-free, secure, or uninterrupted. 6.3. Your use of the App is at your own risk, and you agree that we shall not be liable for any damages arising out of or in connection with the use of the App.\nLimitation of Liability 7.1. To the fullest extent permitted by law, we shall not be liable for any indirect, consequential, incidental, or punitive damages arising out of or in connection with the App. 7.2. In no event shall our total liability exceed the amount paid by you (if any) for using the App.\nModifications to Terms 8.1. We reserve the right to modify or replace these Terms at any time without prior notice. 8.2. By continuing to access or use the App after any revisions, you agree to be bound by the updated Terms.\nGoverning Law 9.1. These Terms shall be governed and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law provisions. 9.2. Any disputes arising out of or relating to these Terms shall be subject to the exclusive jurisdiction of the courts located in [Your Country/State].\nBy using the "bfair store" App, you acknowledge that you have read, understood, and agree to be bound by these Terms of Use.',
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
