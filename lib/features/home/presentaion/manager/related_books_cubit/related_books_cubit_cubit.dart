import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';
import 'package:my_bookly/features/home/data/repos/home_repo.dart';
part 'related_books_cubit_state.dart';

// class RelatedBooksCubit extends Cubit<RelatedBooksState> {
//   RelatedBooksCubit( this.homeRepo, this.category) :super (RelatedBooksCubitInitial());
//   String category;
//   HomeRepo homeRepo;
//   Future<void> fetchRelatedBooks( {required category}) async {
//     emit(RelatedBooksCubitLoading());

//    await homeRepo.fetchRelatedBooks(category: category).then((value) {
//       value.fold((books) {
//         emit(RelatedBooksCubitSuccess(books));
//       }, (failure) {
//         emit(RelatedBooksCubitFailed(failure.errorMessage));
//       });
//     });
//   }
// }

class RelatedBooksCubit extends Cubit<RelatedBooksState> {
  RelatedBooksCubit(
    this.homeRepo,
  ) : super(RelatedBooksInitial());

  HomeRepo homeRepo;
  Future<void> fetchRelatedBooks({required String category}) async {
    emit(RelatedBooksLoading());
    await homeRepo.fetchRelatedBooks(category: category).then((value) {
      value.fold((books) {
        
        emit(RelatedBooksSuccess(books));
      }, (failure) {
        emit(RelatedBooksFailed(failure.errorMessage));
      });
    });
  }
}
