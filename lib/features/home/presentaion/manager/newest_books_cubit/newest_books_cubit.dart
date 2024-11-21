import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';
import 'package:my_bookly/features/home/data/repos/home_repo.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitial());

  HomeRepo homeRepo;
  Future<void> fetchNewestBooks() async {
    emit(NewestBooksLoading());
    await homeRepo.fetchNewestBooks().then((value) {
      value.fold((books) {
        emit(NewestBooksSuccess(books));
      }, (failure) {
        emit(NewestBooksFailed(failure.errorMessage));
      });
    });
  }
}
