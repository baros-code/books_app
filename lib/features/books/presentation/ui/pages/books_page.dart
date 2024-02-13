import 'package:books_app/shared/presentation/ui/custom/widgets/custom_text.dart';
import 'package:books_app/shared/presentation/ui/pages/base_page.dart';
import 'package:books_app/stack/base/presentation/sub_view.dart';

import '../controllers/books_page_controller.dart';
import '../../../../../stack/base/presentation/controlled_view.dart';
import 'package:flutter/material.dart';

class BooksPage extends ControlledView<BooksPageController, Object> {
  BooksPage({super.key, required super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: _Title(),
      // TODO(Baran): Add these colors as primary color to the theme
      // Color(0XFF4893EB),
      appBarBackgroundColor: const Color(0xFF1C242A),
      backgroundColor: const Color(0xFF1C242A),
      backButtonEnabled: controller.isFavoritesPage,
      actions: [
        if (!controller.isFavoritesPage)
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () => controller.goToFavoritesPage(),
          ),
      ],
      body: const _Body(),
    );
  }
}

class _Title extends SubView<BooksPageController> {
  @override
  Widget buildView(BuildContext context, BooksPageController controller) {
    return CustomText(
      controller.isFavoritesPage ? 'Favoriler' : 'Kitaplar Uygulamam',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
