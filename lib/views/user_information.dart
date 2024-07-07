import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class UserInformation extends StatelessWidget {
  final int userId;
  final UserController userController = UserController();

  UserInformation({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações do usuário"),
      ),
      body: FutureBuilder<UserModel>(
        future: userController.getUserById(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Erro ao carregar dados do usuário"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Usuário não encontrado"));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Informações básicas:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Nome: ${user.name}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Nome do usuário: ${user.username}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Email: ${user.email}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Telefone: ${user.phone}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Website: ${user.website}",
                      style: const TextStyle(fontSize: 18)),
                  if (user.address != null) ...[
                    const SizedBox(height: 16),
                    const Text("Endereço:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Rua: ${user.address!.street}",
                        style: const TextStyle(fontSize: 18)),
                    Text("Suite: ${user.address!.suite}",
                        style: const TextStyle(fontSize: 18)),
                    Text("Cidade: ${user.address!.city}",
                        style: const TextStyle(fontSize: 18)),
                    Text("CEP: ${user.address!.zipcode}",
                        style: const TextStyle(fontSize: 18)),
                    Text(
                        "Geo: Lat ${user.address!.geo.lat}, Lng ${user.address!.geo.lng}",
                        style: const TextStyle(fontSize: 18)),
                  ],
                  if (user.company != null) ...[
                    const SizedBox(height: 16),
                    const Text("Empresa:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Nome: ${user.company!.name}",
                        style: const TextStyle(fontSize: 18)),
                    Text("Frase: ${user.company!.catchPhrase}",
                        style: const TextStyle(fontSize: 18)),
                    Text("BS: ${user.company!.bs}",
                        style: const TextStyle(fontSize: 18)),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
