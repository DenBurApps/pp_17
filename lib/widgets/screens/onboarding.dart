import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_17/services/storage/storage_service.dart';
import '../../helpers/image/image_helper.dart';
import '../../services/navigation/route_names.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _storageService = GetIt.instance<StorageService>() ;
  var _currentStep = 0;

  final _descriptions = [
    'Learn the history\nof the Olympic Games',
    'Take tests and check\nyour knowledge',
    'Your guide\nto the world\nof heroes and records',
  ];

  final _images = [
    ImageHelper.getImage(ImageNames.onboarding_1).image,
    ImageHelper.getImage(ImageNames.onboarding_2).image,
    ImageHelper.getImage(ImageNames.onboarding_3).image,
  ];

  final _icons = [
    SvgNames.onboardingIcon_1,
    SvgNames.onboardingIcon_2,
    SvgNames.onboardingIcon_3,
  ];

  int currentRating = 0;

  @override
  void initState() {
    _init();
    super.initState();
  }

void _init() {
  _storageService.setBool(StorageKeys.seenOnboarding, true);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: InkWell(
        onTap: () {
          setState(() {
            if (_currentStep == 2) {
              Navigator.of(context).pushReplacementNamed(RouteNames.privacyAgreement);
              return;
            }
            _currentStep++;
          });
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: _images[_currentStep],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 12),
                Text(
                  _descriptions[_currentStep],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 90),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ImageHelper.getSvg(_icons[_currentStep]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
