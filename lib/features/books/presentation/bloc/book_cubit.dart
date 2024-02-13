import 'package:books_app/features/books/presentation/bloc/book_state.dart';
import 'package:books_app/stack/base/domain/use_case.dart';
import 'package:books_app/stack/base/presentation/safe_cubit.dart';
import 'package:books_app/stack/common/mixins/use_case_cancel_mixin.dart';

class BookCubit extends SafeCubit<BookState> with UseCaseCancelMixin {
  BookCubit() : super(BookInitial());

  @override
  List<UseCase<dynamic, dynamic, dynamic>> get useCasesToCancel => [];
}
