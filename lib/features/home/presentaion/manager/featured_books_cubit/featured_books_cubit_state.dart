part of 'featured_books_cubit_cubit.dart';

sealed class FeaturedBooksCubitState extends Equatable {
  const FeaturedBooksCubitState();

  @override
  List<Object> get props => [];
}

final class FeaturedBooksCubitInitial extends FeaturedBooksCubitState {}

final class FeaturedBooksCubitLoading extends FeaturedBooksCubitState {}

final class FeaturedBooksCubitSuccess extends FeaturedBooksCubitState {
  const FeaturedBooksCubitSuccess(this.booksList);
  final List<BookModel> booksList;
}

final class FeaturedBooksCubitFailed extends FeaturedBooksCubitState {
  const FeaturedBooksCubitFailed(this.errorMessage);
  final String errorMessage;
}
