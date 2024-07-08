import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';

class ShowUsersModal extends StatelessWidget {
  final UserController userController = UserController();

  ShowUsersModal({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: userController.getUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 60),
                Text(
                  "Erro ao carregar usuários",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        }
        final users = snapshot.data;
        if (users == null || users.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time_outlined, size: 60),
                Text(
                  "Não há usuários",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        }
        return ListView.separated(
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              onTap: () {
                Navigator.pop(context, users[i]);
              },
              title: Text(users[i].name),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            indent: 20,
            endIndent: 20,
          ),
          itemCount: users.length,
        );
      },
    );
  }
}
