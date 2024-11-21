import 'package:dio/dio.dart';

class ApiServices {
  ApiServices(this.dio);
  final String baseUrl = 'https://www.googleapis.com/books/v1';
  final Dio dio;

  Future<Map<String, dynamic>> get({required String endPiontPath}) async {
    var response =
        await dio.get('$baseUrl$endPiontPath').then((value) => value.data);


        // response.data
    return response;
  }
}
