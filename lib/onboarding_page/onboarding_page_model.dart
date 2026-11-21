import '/flutter_flow/flutter_flow_util.dart';
import 'onboarding_page_widget.dart' show OnboardingPageWidget;
import 'package:flutter/material.dart';

class OnboardingPageModel extends FlutterFlowModel<OnboardingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for OnboardingPager widget.
  PageController? onboardingPagerController;

  int get onboardingPagerCurrentIndex => onboardingPagerController != null &&
          onboardingPagerController!.hasClients &&
          onboardingPagerController!.page != null
      ? onboardingPagerController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
