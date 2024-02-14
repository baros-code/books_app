import 'package:books_app/features/books/presentation/bloc/books_cubit.dart';
import 'package:books_app/features/books/presentation/bloc/books_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../stack/base/presentation/controlled_view.dart';
import '../controllers/splash_page_controller.dart';

class SplashPage extends ControlledView<SplashPageController, Object> {
  SplashPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BooksCubit, BooksState>(
      listener: (context, state) => controller.handleStates(state),
      child: const Placeholder(),
    );
  }
}
