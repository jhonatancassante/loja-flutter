import 'package:flutter/material.dart';

Future<bool?> confirmacao<T>({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
          child: const Text('Sim'),
        ),
      ],
    ),
  );
}
