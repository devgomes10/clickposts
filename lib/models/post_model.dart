import 'package:clickposts/models/user_model.dart';

class PostModel {
  final String id;
  final UserModel user;
  final String description;
  final String? imageUrl;
  final DateTime date;

  PostModel({
    required this.id,
    required this.user,
    required this.description,
    this.imageUrl,
    required this.date,
  });

  // named constructor from json for object (PostModel)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      description: json['description'],
      imageUrl: json['imageUrl'],
      date: DateTime.parse(json['date']),
    );
  }
}
