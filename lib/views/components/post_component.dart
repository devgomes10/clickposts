import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostComponent extends StatelessWidget {
  final PostModel post;

  const PostComponent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(post.user.avatarUrl),
              ),
              title: Text(post.user.name),
              subtitle: Text(post.date.toIso8601String()),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Editar'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Deletar'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    // Edit post logic
                  } else if (value == 'delete') {
                    // Delete post logic
                  }
                },
              ),
            ),
            if (post.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(post.description),
              ),
            if (post.imageUrl != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.network(post.imageUrl!),
              ),
          ],
        ),
      ),
    );
  }
}
