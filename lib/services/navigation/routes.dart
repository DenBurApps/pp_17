import 'package:flutter/material.dart';
import 'package:pp_17/widgets/screens/privacy_agreement_view.dart';
import '/widgets/screens/privacy.dart';
import '/widgets/screens/selected_info.dart';
import '/widgets/screens/terms.dart';

import '../../widgets/screens/contact_developer.dart';
import '../../widgets/screens/home.dart';
import '../../widgets/screens/no_connection.dart';
import '../../widgets/screens/onboarding.dart';
import '../../widgets/screens/quiz.dart';
import '../../widgets/screens/splash.dart';
import 'route_names.dart';

typedef ScreenBuilding = Widget Function(BuildContext context);

class Routes {
  static Map<String, ScreenBuilding> get(BuildContext context) {
    return {
      RouteNames.splash: (context) => const SplashView(),
      RouteNames.onboarding: (context) => const OnboardingView(),
      RouteNames.home: (context) => const HomeView(),
      RouteNames.noConnection: (context) => NoConnectionView(),
      RouteNames.privacy: (context) => const PrivacyView(),
      RouteNames.terms: (context) => const TermsView(),
      RouteNames.selectedNews: (context) => const SelectedInfoView(),
      RouteNames.contactDeveloper: (context) => const  ContactDeveloperView(),
      RouteNames.quiz: (context) =>  QuizView(),
      RouteNames.privacyAgreement:(context) => const  PrivacyAgreementView(), 
    };
  }
}
