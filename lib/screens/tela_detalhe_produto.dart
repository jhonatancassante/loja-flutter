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
      appBar: AppBar(
        title: Text(produto.nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Hero(
                tag: produto.id,
                child: Image.network(
                  produto.imagemUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'R\$ ${Formatar.moeda(
                produto.preco,
              )}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
            )
          ],
        ),
      ),
    );
  }
}
