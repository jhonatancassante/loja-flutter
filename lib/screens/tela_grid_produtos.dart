import 'package:flutter/material.dart';

import '../components/grid_produto.dart';

enum OpcoesFiltro {
  favoritos,
  todos,
}

class TelaGridProdutos extends StatefulWidget {
  const TelaGridProdutos({super.key});

  @override
  State<TelaGridProdutos> createState() => _TelaGridProdutosState();
}

class _TelaGridProdutosState extends State<TelaGridProdutos> {
  bool _filtrarFavoritos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: OpcoesFiltro.favoritos,
                child: Text('Favoritos'),
              ),
              const PopupMenuItem(
                value: OpcoesFiltro.todos,
                child: Text('Todos'),
              ),
            ],
            onSelected: (OpcoesFiltro valorSelecionado) {
              setState(() {
                if (valorSelecionado == OpcoesFiltro.favoritos) {
                  _filtrarFavoritos = true;
                } else {
                  _filtrarFavoritos = false;
                }
              });
            },
          ),
        ],
      ),
      body: GridProduto(_filtrarFavoritos),
    );
  }
}
