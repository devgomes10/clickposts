import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostController {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => PostModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<PostModel> getPostById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<void> createPost(PostModel post) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'title': post.title,
        'body': post.body,
        'userId': post.userId,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }

  Future<void> updatePost(PostModel post) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${post.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'title': post.title,
        'body': post.body,
        'userId': post.userId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
