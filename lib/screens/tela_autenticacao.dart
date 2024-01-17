import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_flutter/components/formulario_autenticacao.dart';

class TelaAutenticacao extends StatelessWidget {
  const TelaAutenticacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 70,
                  ),
                  transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.error,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Minha Loja',
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Anton',
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
                const FormularioAutenticacao(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
