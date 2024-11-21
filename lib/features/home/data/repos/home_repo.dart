import 'package:dartz/dartz.dart';
import 'package:my_bookly/core/errors/failures.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';

abstract class HomeRepo {
  Future<Either<List<BookModel>, Failure>> fetchNewestBooks();
  Future<Either<List<BookModel>, Failure>> fetchFeaturedBooks();
  Future<Either<List<BookModel>, Failure>> fetchRelatedBooks(
      {required String category});
}
