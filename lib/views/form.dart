import 'package:clickposts/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Form extends StatefulWidget {
  final PostModel? model;

  const Form({super.key, this.model});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final TextEditingController _descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final uniqueId = const Uuid().v1();

  @override
  void initState() {
    if (widget.model != null) {
      _descriptionController.text = widget.model!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
