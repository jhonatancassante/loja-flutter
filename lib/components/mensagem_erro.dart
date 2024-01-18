import 'package:flutter/material.dart';

Future<void> mensagemErro<T>({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
