import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostController with ChangeNotifier {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _posts = body.map((dynamic item) => PostModel.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Erro ao carregar post');
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

    if (response.statusCode == 201) {
      final newPost = PostModel(
        id: json.decode(response.body)['id'],
        userId: post.userId,
        title: post.title,
        body: post.body,
      );
      _posts.add(newPost);
      notifyListeners();
    } else {
      throw Exception('Erro ao criar post');
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

    if (response.statusCode == 200) {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = post;
        notifyListeners();
      }
    } else {
      throw Exception('Erro ao atualizar post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      _posts.removeWhere((post) => post.id == id);
      notifyListeners();
    } else {
      throw Exception('Erro ao deletar post');
    }
  }
}
