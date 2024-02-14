import 'package:books_app/features/books/data/models/book_model.dart';
import 'package:books_app/shared/presentation/ui/controllers/splash_page_controller.dart';

import '../../features/books/data/data_sources/local/books_local_storage.dart';
import '../../features/books/data/data_sources/remote/books_remote_service.dart';
import '../../features/books/data/repositories/books_repository_impl.dart';
import '../../features/books/domain/repositories/books_repository.dart';
import '../../features/books/domain/use_cases/add_favorite.dart';
import '../../features/books/domain/use_cases/get_books.dart';
import '../../features/books/domain/use_cases/get_favorites.dart';
import '../../features/books/domain/use_cases/remove_favorite.dart';
import '../../features/books/presentation/bloc/books_cubit.dart';
import '../../features/books/presentation/ui/controllers/books_page_controller.dart';
import '../../features/books/presentation/ui/controllers/favorite_books_page_controller.dart';
import '../../stack/core/ioc/service_locator.dart';

part 'dependency_config.dart';
