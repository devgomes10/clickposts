import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/user_controller.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../post_form.dart';
import '../user_information.dart';

class PostComponent extends StatelessWidget {
  final PostModel post;
  final UserController userController = UserController();

  PostComponent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostForm(model: post),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<UserModel>(
                future: userController.getUserById(post.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("Erro ao carregar usuário"));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text("Usuário não encontrado"));
                  } else {
                    final user = snapshot.data!;
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserInformation(userId: post.userId),
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(user.name),
                      subtitle: Text(
                          DateFormat.yMMMMd('pt_BR').format(DateTime.now())),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(post.body),
            ],
          ),
        ),
      ),
    );
  }
}
