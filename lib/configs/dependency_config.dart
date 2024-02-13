import 'package:books_app/features/books/presentation/ui/controllers/books_page_controller.dart';
import 'package:books_app/stack/core/ioc/service_locator.dart';

abstract class DependencyConfig {
  static void register() {
    // Controllers
    _registerControllers();
    // Cubits
    _registerCubits();
    // Use Cases
    _registerUseCases();
    // Repositories
    _registerRepositories();
    // Remote Services
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
    // locator.registerFactory(
    //   () => AuthCubit(locator(), locator(), locator()),
    // );
  }

  static void _registerUseCases() {
    // locator.registerFactory(
    //   () => Login(locator(), locator()),
    // );
  }

  static void _registerRepositories() {
    // locator.registerLazySingleton<AuthRepository>(
    //   () => AuthRepositoryImpl(locator(), locator(), locator()),
    // );
  }

  static void _registerRemoteServices() {
    // locator.registerLazySingleton<AuthRemoteService>(
    //   () => AuthRemoteServiceImpl(locator(), locator()),
    // );
  }
}
