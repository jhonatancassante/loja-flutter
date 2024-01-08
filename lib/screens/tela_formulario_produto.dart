import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_flutter/models/produto.dart';

class TelaFormularioProduto extends StatefulWidget {
  const TelaFormularioProduto({super.key});

  @override
  State<TelaFormularioProduto> createState() => _TelaFormularioProdutoState();
}

class _TelaFormularioProdutoState extends State<TelaFormularioProduto> {
  final _focoPreco = FocusNode();
  final _focoDescricao = FocusNode();
  final _focoUrlImagem = FocusNode();
  final _controladorImagemUrl = TextEditingController();
  final _keyFormulario = GlobalKey<FormState>();
  final _dadosFormulario = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _focoUrlImagem.addListener(atualizarImagem);
  }

  @override
  void dispose() {
    super.dispose();
    _focoPreco.dispose();
    _focoDescricao.dispose();
    _focoUrlImagem.dispose();
    _focoUrlImagem.removeListener(atualizarImagem);
  }

  void atualizarImagem() {
    setState(() {});
  }

  void _enviarFormulario() {
    _keyFormulario.currentState?.save();
    final produtoNovo = Produto(
      id: Random().nextDouble().toString(),
      nome: _dadosFormulario['nome'] as String,
      descricao: _dadosFormulario['descricao'] as String,
      preco: _dadosFormulario['preco'] as double,
      imagemUrl: _dadosFormulario['imagemUrl'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _enviarFormulario,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _keyFormulario,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focoPreco);
                },
                onSaved: (nome) => _dadosFormulario['nome'] = nome ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _focoPreco,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focoDescricao);
                },
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSaved: (preco) =>
                    _dadosFormulario['preco'] = double.parse(preco ?? '0'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                focusNode: _focoDescricao,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (descricao) =>
                    _dadosFormulario['descricao'] = descricao ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      focusNode: _focoUrlImagem,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _controladorImagemUrl,
                      onFieldSubmitted: (_) => _enviarFormulario(),
                      onSaved: (imagemUrl) =>
                          _dadosFormulario['imagemUrl'] = imagemUrl ?? '',
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _controladorImagemUrl.text.isEmpty
                        ? const Text(
                            'Informe a URL...',
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_controladorImagemUrl.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
