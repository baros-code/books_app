import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/router/route_manager.dart';
import 'base_page.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const Text('Error'),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to home page'),
          onPressed: () => context.goNamed(RouteConfig.homeRoute.name),
        ),
      ),
    );
  }
}
