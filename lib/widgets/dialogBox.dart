import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final title;
  final content;
  final VoidCallback? callback;
  final actionText;
  DialogBox({
    this.title,
    this.content,
    this.callback,
    this.actionText = "Restart",
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      content: Text(content),
      actions: [ElevatedButton(onPressed: callback, child: Text(actionText))],
    );
  }
}
