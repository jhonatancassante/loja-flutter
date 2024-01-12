import 'package:flutter/material.dart';

Future<void> mensagemErro<T>({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
