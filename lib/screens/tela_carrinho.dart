import 'package:flutter/material.dart';
import 'package:loja_flutter/components/item_carrinho.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/utils/formatar.dart';
import 'package:provider/provider.dart';

import '../components/botao_carrinho.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({super.key});

  @override
  Widget build(BuildContext context) {
    final Carrinho carrinho = Provider.of(context);
    final itens = carrinho.itens.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$ ${Formatar.moeda(
                        carrinho.total,
                      )}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  BotaoCarrinho(carrinho: carrinho),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => ItemCarrinhoWidget(itens[index]),
              itemCount: itens.length,
            ),
          ),
        ],
      ),
    );
  }
}
