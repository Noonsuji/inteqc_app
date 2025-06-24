import 'package:dio/dio.dart';

import 'package:inteqc_app/models/contract_model.dart';

class AppService {
  final String baseUrl = 'http://192.168.130.51:3000';

  Future<List<ContractModel>> fetchContracts({
    int page = 1,
    int pageSize = 20,
    String searchQuery = '',
  }) async {
    try {
      final response = await Dio().get(
        '$baseUrl/search/employees',
        queryParameters: {
          'q': searchQuery,
          'page': page,
          'pageSize': pageSize,
        },
      );

      final List<dynamic> data = response.data['data'];
      return data.map((e) => ContractModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('โหลดข้อมูลไม่สำเร็จ: $e');
    }
  }
}
