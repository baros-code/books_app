import 'package:flutter/material.dart';

import '../../../../../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../stack/base/presentation/sub_view.dart';
import '../../../constants/custom_images.dart';
import '../controllers/splash_page_controller.dart';

class SplashPage extends ControlledView<SplashPageController, Object> {
  SplashPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C242A),
      body: SafeArea(
        child: Center(child: _Logo()),
      ),
    );
  }
}

class _Logo extends SubView<SplashPageController> {
  @override
  Widget buildView(BuildContext context, controller) {
    return SizedBox(
      height: 200,
      child: RotationTransition(
        turns:
            Tween(begin: 0.0, end: 1.0).animate(controller.animationController),
        child: Image.asset(CustomImages.bookPlaceHolder),
      ),
    );
  }
}
