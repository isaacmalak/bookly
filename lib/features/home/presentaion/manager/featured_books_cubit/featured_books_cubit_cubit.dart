import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';
import 'package:my_bookly/features/home/data/repos/home_repo.dart';

part 'featured_books_cubit_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksCubitState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksCubitInitial());
  HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksCubitLoading  ());
    await homeRepo.fetchFeaturedBooks().then((value) {
      value.fold((books) {
        emit(FeaturedBooksCubitSuccess(books));
      }, (failure) {
        emit(FeaturedBooksCubitFailed(failure.errorMessage));
      });
    });
  }
}
