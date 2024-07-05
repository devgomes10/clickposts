class UserModel {
  final String id;
  final String name;
  final String avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
    );
  }
}