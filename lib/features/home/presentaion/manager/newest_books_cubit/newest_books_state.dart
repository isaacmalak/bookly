part of 'newest_books_cubit.dart';

sealed class NewestBooksState extends Equatable {
  const NewestBooksState();

  @override
  List<Object> get props => [];
}

final class NewestBooksInitial extends NewestBooksState {}
final class NewestBooksLoading extends NewestBooksState {}
final class NewestBooksSuccess extends NewestBooksState {
  const NewestBooksSuccess(this.booksList);
  final List<BookModel> booksList;
}
final class NewestBooksFailed extends NewestBooksState {
  const NewestBooksFailed(this.errorMessage);
  final String errorMessage;
} 

