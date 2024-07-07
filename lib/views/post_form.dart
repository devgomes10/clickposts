import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../controllers/user_controller.dart';
import '../controllers/post_controller.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import 'components/show_confirmation_message.dart';
import 'components/show_users_modal.dart';
import '../views/theme/theme_colors.dart';

class PostForm extends StatefulWidget {
  final PostModel? model;

  const PostForm({super.key, this.model});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final UserController userController = UserController();
  final PostController postController = PostController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  UserModel? _userModel;

  final formKey = GlobalKey<FormState>();
  final uniqueId = const Uuid().v1();

  Future<void> _loadUserModel(int userModelId) async {
    try {
      UserModel userModel = await userController.getUserById(userModelId);
      setState(() {
        _userModel = userModel;
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  void initState() {
    if (widget.model != null) {
      _titleController.text = widget.model!.title;
      _bodyController.text = widget.model!.body;
      _loadUserModel(widget.model!.userId);
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = widget.model;
    return Scaffold(
      appBar: AppBar(
        title: postModel != null
            ? const Text("Editar post")
            : const Text("Novo post"),
        actions: postModel != null
            ? [
                IconButton(
                  onPressed: () {
                    showConfirmationMessage(
                      context: context,
                      title: "Deseja remover o post?",
                      function: () async {
                        await postController.deletePost(postModel.id);
                        Navigator.of(context).pop(true);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: ThemeColors.errorColor,
                    size: 32,
                  ),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text("Título"),
                  ),
                ),
                const SizedBox(height: 26),
                TextFormField(
                  controller: _bodyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o conteúdo';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text("Conteúdo"),
                  ),
                  maxLength: 2000,
                ),
                const SizedBox(height: 26),
                TextButton(
                  onPressed: () async {
                    final user = await showModalBottomSheet<UserModel>(
                      context: context,
                      builder: (BuildContext context) => ShowUsersModal(),
                    );
                    if (user != null) {
                      setState(() {
                        _userModel = user;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  child: Text(_userModel?.name ?? "Usuário"),
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      PostModel post = PostModel(
                        userId: _userModel?.id ?? 0,
                        id: postModel?.id ?? uniqueId.hashCode,
                        title: _titleController.text,
                        body: _bodyController.text,
                      );

                      if (postModel != null) {
                        showConfirmationMessage(
                          context: context,
                          title: "Deseja atualizar esse post?",
                          function: () async {
                            await postController.updatePost(post);
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pop(true);
                          },
                        );
                      } else {
                        showConfirmationMessage(
                          context: context,
                          title: "Deseja criar um novo post?",
                          function: () async {
                            await postController.createPost(post);
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pop(true);
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  child: postModel != null
                      ? const Text(
                          "ATUALIZAR",
                          style: TextStyle(color: ThemeColors.white),
                        )
                      : const Text(
                          "ADICIONAR",
                          style: TextStyle(color: ThemeColors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
