import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/ui/custom/widgets/custom_search_bar.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../bloc/books_cubit.dart';
import '../../bloc/books_state.dart';
import '../controllers/books_page_controller.dart';
import '../custom/widgets/books_list_view.dart';
import '../custom/widgets/books_page_title.dart';

class BooksPage extends ControlledView<BooksPageController, Object> {
  BooksPage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const BooksPageTitle('Favori Kitaplarım'),
      // TODO(Baran): Add these colors as primary color to the theme
      // Color(0XFF4893EB),
      appBarBackgroundColor: const Color(0xFF1C242A),
      backgroundColor: const Color(0xFF1C242A),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          color: Colors.white,
          onPressed: () => controller.goToFavoritesPage(),
        ),
      ],
      body: _Body(),
    );
  }
}

class _Body extends SubView<BooksPageController> {
  @override
  Widget buildView(BuildContext context, BooksPageController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          CustomSearchBar(
            hintStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            leading: const Icon(Icons.search, color: Colors.white),
            onSubmitted: (value) => controller.searchBooks(value),
          ),
          const SizedBox(height: 8),
          _ListView(),
        ],
      ),
    );
  }
}

class _ListView extends SubView<BooksPageController> {
  _ListView();

  @override
  Widget buildView(BuildContext context, BooksPageController controller) {
    return BlocBuilder<BooksCubit, BooksState>(
      buildWhen: (previous, current) =>
          current is BooksUpdated || current is BooksLoading,
      builder: (context, state) {
        final books = state is BooksUpdated ? state.books : controller.books;
        return Expanded(
          child: state is BooksLoading
              ? const Center(child: CircularProgressIndicator())
              : BooksListView(
                  books,
                  onBookDoubleTap: controller.addFavorite,
                  onBookLongPress: controller.removeFavorite,
                ),
        );
      },
    );
  }
}
