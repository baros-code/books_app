part of 'dependency_imports.dart';

abstract class DependencyConfig {
  static void register() {
    _registerControllers();
    _registerCubits();
    _registerUseCases();
    _registerRepositories();
    _registerRemoteServices();
    _registerLocalStorages();
    _registerModels();
  }

  static void _registerControllers() {
    locator.registerFactory(
      () => SplashPageController(locator(), locator()),
    );
    locator.registerFactory(
      () => BooksPageController(locator(), locator()),
    );
    locator.registerFactory(
      () => FavoriteBooksPageController(locator(), locator()),
    );
  }

  static void _registerCubits() {
    locator.registerFactory(
      () => BooksCubit(locator(), locator(), locator(), locator()),
    );
  }

  static void _registerUseCases() {
    locator.registerFactory(
      () => GetBooks(locator(), locator()),
    );
    locator.registerFactory(
      () => GetFavorites(locator(), locator()),
    );
    locator.registerFactory(
      () => AddFavorite(locator(), locator()),
    );
    locator.registerFactory(
      () => RemoveFavorite(locator(), locator()),
    );
  }

  static void _registerRepositories() {
    locator.registerLazySingleton<BooksRepository>(
      () => BooksRepositoryImpl(locator(), locator()),
    );
  }

  static void _registerRemoteServices() {
    locator.registerLazySingleton<BooksRemoteService>(
      () => BooksRemoteServiceImpl(locator()),
    );
  }

  static void _registerLocalStorages() {
    locator.registerLazySingleton<BooksLocalStorage>(
      () => BooksLocalStorageImpl(locator()),
    );
  }

  static void _registerModels() {
    locator.registerFactoryParam<BookModel, Map<String, dynamic>, void>(
      (json, _) => BookModel.fromJson(json),
    );
  }
}
