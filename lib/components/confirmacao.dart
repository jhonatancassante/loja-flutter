import 'package:flutter/material.dart';

Future<T?> confirmacao<T>({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showDialog(
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
