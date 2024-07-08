import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserController {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }

  Future<UserModel> getUserById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar usuário');
    }
  }
}
