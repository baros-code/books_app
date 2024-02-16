import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/extensions/build_context_ext.dart';

class BooksPageTitle extends StatelessWidget {
  const BooksPageTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
