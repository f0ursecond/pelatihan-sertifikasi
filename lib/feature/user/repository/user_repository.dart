import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pelatihan_sertifikasi/model/user_model.dart';

class UserRepository {
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      Uri.parse(
        'https://686b3968e559eba90871c627.mockapi.io/api/v1/users',
      ),
    );

    switch (response.statusCode) {
      case 200:
        return (json.decode(response.body) as List).map((e) => UserModel.fromJson(e)).toList();
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not found: ${response.body}');
      case 500:
        throw Exception('Internal server error: ${response.body}');
      default:
        throw Exception('Failed to load users: ${response.statusCode} ${response.body}');
    }
  }
}
