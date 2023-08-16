import 'package:flutter/material.dart';

class Medalha extends StatelessWidget {
  const Medalha({
    super.key,
    required this.child,
    required this.valor,
    this.cor,
  });

  final Widget child;
  final String valor;
  final Color? cor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cor ?? Theme.of(context).colorScheme.tertiary,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              valor,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
