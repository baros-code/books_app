import 'package:books_app/configs/router/route_manager.dart';
import 'package:books_app/shared/presentation/ui/custom/widgets/primary_button.dart';
import 'package:books_app/shared/presentation/ui/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const Text('Error'),
      body: Center(
          child: PrimaryButton(
        text: 'Go to home page',
        onPressed: () => context.goNamed(RouteConfig.homeRouteName),
      )),
    );
  }
}
