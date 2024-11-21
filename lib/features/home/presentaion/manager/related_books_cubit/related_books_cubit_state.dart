part of 'related_books_cubit_cubit.dart';

sealed class RelatedBooksState extends Equatable {
  const RelatedBooksState();

  @override
  List<Object> get props => [];
}

final class RelatedBooksInitial extends RelatedBooksState {}

final class RelatedBooksLoading extends RelatedBooksState {}

final class RelatedBooksEmpty extends RelatedBooksState {}

final class RelatedBooksSuccess extends RelatedBooksState {
  const RelatedBooksSuccess(this.booksList);
  final List<BookModel> booksList;
}

final class RelatedBooksFailed extends RelatedBooksState {
  const RelatedBooksFailed(this.errorMessage);
  final String errorMessage;
}
