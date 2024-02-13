import 'package:books_app/configs/router/route_manager.dart';
import 'package:books_app/stack/base/presentation/controller.dart';
import 'package:go_router/go_router.dart';

class BooksPageController extends Controller<bool> {
  BooksPageController(super.logger, super.popupManager);

  late final bool isFavoritesPage;

  @override
  void onStart() {
    super.onStart();
    isFavoritesPage = params!;
  }

  void goToFavoritesPage() {
    context.goNamed(RouteConfig.favoritesRouteName);
  }
}
