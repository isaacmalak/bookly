import 'package:equatable/equatable.dart';

class ResponseGeneralInfo extends Equatable {
  final int totalItems;
  
  const ResponseGeneralInfo({required this.totalItems});

  factory ResponseGeneralInfo.fromJson(Map<String, dynamic> json) {
    return ResponseGeneralInfo(
      totalItems: json['totalItems'] as int,
    );
  }

  @override
  List<Object?> get props => [totalItems];
}
