import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/ui/custom/widgets/custom_text.dart';

class BooksPageTitle extends StatelessWidget {
  const BooksPageTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      isSingleLine: true,
    );
  }
}
