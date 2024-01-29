import 'package:flutter/material.dart';
import 'package:loja_flutter/models/produto.dart';
import 'package:loja_flutter/utils/formatar.dart';

class TelaDetalheProduto extends StatelessWidget {
  const TelaDetalheProduto({super.key});

  @override
  Widget build(BuildContext context) {
    final Produto produto =
        ModalRoute.of(context)!.settings.arguments as Produto;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
              opacity: 1.0,
              size: 30,
              shadows: List.of(
                <Shadow>[
                  const Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                  ),
                  const Shadow(
                    color: Colors.black,
                    blurRadius: 5,
                  ),
                  const Shadow(
                    color: Colors.black,
                    blurRadius: 10,
                  ),
                  const Shadow(
                    color: Colors.black,
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
            shadowColor: Colors.red,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(produto.nome),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: produto.id,
                    child: Image.network(
                      produto.imagemUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  'R\$ ${Formatar.moeda(
                    produto.preco,
                  )}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: double.infinity,
                  child: Text(
                    produto.descricao,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
