import 'package:dio/dio.dart';

abstract class Failure {
  const Failure(
    this.errorMessage,
  );
  final String errorMessage;
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioException(DioException dioException) {
    
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive timeout with API server');
      case DioExceptionType.badCertificate:
        return ServerFailure('bad certificate with API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data!);
      case DioExceptionType.cancel:
        return ServerFailure('Request to API server was cancelled');
      case DioExceptionType.connectionError:
        if (dioException.message!.contains('connection error')) {
          return ServerFailure('No internet connection');
        }
        return ServerFailure('internet error');
      case DioExceptionType.unknown:
        return ServerFailure('Unknown error with API server');

      default:
        return ServerFailure('Unknown error');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Resource not found');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error');
    } else {
      return ServerFailure('Unknown error');
    }
  }
}
