import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/post_controller.dart';
import 'post_form.dart';
import 'components/post_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostController>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ClickPosts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<PostController>(
        builder: (context, postProvider, child) {
          if (postProvider.posts.isEmpty) {
            return const Center(child: Text("Nenhum post disponível"));
          } else {
            final sortedPosts = List.from(postProvider.posts)
              ..sort((a, b) => b.id.compareTo(a.id));

            return ListView.builder(
              itemCount: sortedPosts.length,
              itemBuilder: (context, index) {
                return PostComponent(post: sortedPosts[index]);
              },
            );
          }
        },
      ),
    );
  }
}
