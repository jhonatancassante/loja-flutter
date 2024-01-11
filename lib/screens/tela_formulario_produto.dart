import 'package:flutter/material.dart';
import 'package:loja_flutter/models/lista_produto.dart';
import 'package:loja_flutter/models/produto.dart';
import 'package:loja_flutter/utils/validador.dart';
import 'package:provider/provider.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_dadosFormulario.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final produto = arg as Produto;

        _dadosFormulario['id'] = produto.id;
        _dadosFormulario['nome'] = produto.nome;
        _dadosFormulario['preco'] = produto.preco;
        _dadosFormulario['descricao'] = produto.descricao;
        _dadosFormulario['imagemUrl'] = produto.imagemUrl;

        _controladorImagemUrl.text = produto.imagemUrl;
      }
    }
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
    Validador.campoUrlImagem(_controladorImagemUrl.text) ?? setState(() {});
  }

  void _enviarFormulario() {
    final eValido = _keyFormulario.currentState?.validate() ?? false;

    if (!eValido) return;

    _keyFormulario.currentState?.save();

    Provider.of<ListaProduto>(
      context,
      listen: false,
    ).salvarProduto(_dadosFormulario);
    Navigator.of(context).pop();
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
                initialValue: _dadosFormulario['nome']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focoPreco);
                },
                onSaved: (nome) => _dadosFormulario['nome'] = nome ?? '',
                validator: (nome) => Validador.campoString(nome, 3),
              ),
              TextFormField(
                initialValue: _dadosFormulario['preco']?.toString(),
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
                validator: (preco) => Validador.campoNumerico(preco),
              ),
              TextFormField(
                initialValue: _dadosFormulario['descricao']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                focusNode: _focoDescricao,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (descricao) =>
                    _dadosFormulario['descricao'] = descricao ?? '',
                validator: (descricao) => Validador.campoString(descricao, 10),
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
                      validator: (url) => Validador.campoUrlImagem(url),
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
