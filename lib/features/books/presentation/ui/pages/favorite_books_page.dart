import '../custom/widgets/favorites_list_view.dart';

import '../../bloc/books_cubit.dart';
import '../../bloc/books_state.dart';
import '../controllers/favorite_books_page_controller.dart';
import '../custom/widgets/books_page_title.dart';
import '../../../../../shared/presentation/ui/custom/widgets/custom_search_bar.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../stack/base/presentation/controlled_view.dart';

class FavoriteBooksPage
    extends ControlledView<FavoriteBooksPageController, Object> {
  FavoriteBooksPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const BooksPageTitle('Favoriler'),
      // TODO(Baran): Add these colors as primary color to the theme
      // Color(0XFF4893EB),
      backButtonEnabled: true,
      appBarBackgroundColor: const Color(0xFF1C242A),
      backgroundColor: const Color(0xFF1C242A),
      body: _Body(),
    );
  }
}

class _Body extends SubView<FavoriteBooksPageController> {
  @override
  Widget buildView(
      BuildContext context, FavoriteBooksPageController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          CustomSearchBar(
            hintStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            leading: const Icon(Icons.search, color: Colors.white),
            onChange: (value) => controller.searchBooks(value),
          ),
          const SizedBox(height: 8),
          BlocBuilder<BooksCubit, BooksState>(
            buildWhen: (previous, current) => current is BooksUpdated,
            builder: (context, state) {
              final books = state is BooksUpdated
                  ? state.favoriteBooks
                  : controller.books;
              return Expanded(
                child: FavoritesListView(
                  books,
                  onBookLongPress: controller.removeFavorite,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
