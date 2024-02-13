import 'package:books_app/features/books/data/data_sources/remote/books_remote_service.dart';
import 'package:books_app/features/books/data/repositories/books_repository_impl.dart';
import 'package:books_app/features/books/domain/repositories/books_repository.dart';
import 'package:books_app/features/books/domain/use_cases/get_books.dart';
import 'package:books_app/features/books/presentation/bloc/books_cubit.dart';
import 'package:books_app/features/books/presentation/ui/controllers/books_page_controller.dart';
import 'package:books_app/stack/core/ioc/service_locator.dart';

abstract class DependencyConfig {
  static void register() {
    _registerControllers();
    _registerCubits();
    _registerUseCases();
    _registerRepositories();
    _registerRemoteServices();
    // Local Storages
    // _registerLocalStorages();
  }

  static void _registerControllers() {
    locator.registerFactory(
      () => BooksPageController(locator(), locator()),
    );
  }

  static void _registerCubits() {
    locator.registerFactory(
      () => BooksCubit(locator()),
    );
  }

  static void _registerUseCases() {
    locator.registerFactory(
      () => GetBooks(locator(), locator()),
    );
  }

  static void _registerRepositories() {
    locator.registerLazySingleton<BooksRepository>(
      () => BooksRepositoryImpl(locator()),
    );
  }

  static void _registerRemoteServices() {
    locator.registerLazySingleton<BooksRemoteService>(
      () => BooksRemoteServiceImpl(locator()),
    );
  }
}
