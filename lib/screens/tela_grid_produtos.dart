import 'package:flutter/material.dart';
import 'package:loja_flutter/components/app_drawer.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/models/lista_produto.dart';
import 'package:loja_flutter/utils/atualiza_lista_produtos.dart';
import 'package:loja_flutter/utils/rotas.dart';
import 'package:provider/provider.dart';

import '../components/grid_produto.dart';
import '../components/medalha.dart';

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
  bool _estaCarregando = true;

  @override
  initState() {
    super.initState();

    Provider.of<ListaProduto>(
      context,
      listen: false,
    ).carregarProdutos().then((value) {
      setState(() {
        _estaCarregando = false;
      });
    });
  }

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
          Consumer<Carrinho>(
            builder: (ctx, carrinho, child) => Medalha(
              valor: carrinho.contadorItensTotal.toString(),
              child: child!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Rotas.carrinho);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => atualizarListaProdutos(context),
        child: _estaCarregando
            ? const Center(child: CircularProgressIndicator())
            : GridProduto(_filtrarFavoritos),
      ),
      drawer: const AppDrawer(),
    );
  }
}
