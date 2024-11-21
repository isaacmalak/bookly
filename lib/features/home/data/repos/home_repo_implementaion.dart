import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_bookly/core/errors/failures.dart';
import 'package:my_bookly/core/utils/api_services.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';
import 'package:my_bookly/features/home/data/repos/home_repo.dart';

class HomeRepoImplementation implements HomeRepo {
  HomeRepoImplementation(
    this.apiServices,
  );
  late var dataTotalItems;
  final ApiServices apiServices;
  @override
  Future<Either<List<BookModel>, Failure>> fetchNewestBooks() async {
    try {
      var data = await apiServices.get(
          endPiontPath: '/volumes?q=subject:computer science&Sorting=newest');

      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }

      return left(books);
    } catch (e) {
      if (e is DioException) {
        return right(ServerFailure.fromDioException(e));
      } else {
        return right(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<List<BookModel>, Failure>> fetchFeaturedBooks() async {
    try {
      var data =
          await apiServices.get(endPiontPath: '/volumes?q=subject:Programming');

      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }

      return left(books);
    } catch (e) {
      if (e is DioException) {
        return right(ServerFailure.fromDioException(e));
      } else {
        return right(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<List<BookModel>, Failure>> fetchRelatedBooks(
      {required String category}) async {
    try {
      var data = await apiServices.get(
          endPiontPath: '/volumes?q=subject:$category&Sorting=relevance');
      dataTotalItems = data['totalItems'];

      List<BookModel> books = [];
      if (data["items"] is List) {
        for (var item in data['items']) {
          books.add(BookModel.fromJson(item));
        }
      }

      return left(books);
    } catch (e) {
      if (e is DioException) {
        return right(ServerFailure.fromDioException(e));
      } else {
        return right(ServerFailure(e.toString()));
      }
    }
  }
}
