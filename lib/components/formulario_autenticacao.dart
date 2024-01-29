import 'package:flutter/material.dart';
import 'package:loja_flutter/components/mensagem_erro.dart';
import 'package:loja_flutter/models/autenticacao.dart';
import 'package:loja_flutter/utils/tamanho_box_login.dart';
import 'package:loja_flutter/utils/validador.dart';
import 'package:provider/provider.dart';

enum ModoAutenticacao { signup, login }

class FormularioAutenticacao extends StatefulWidget {
  const FormularioAutenticacao({super.key});

  @override
  State<FormularioAutenticacao> createState() => _FormularioAutenticacaoState();
}

class _FormularioAutenticacaoState extends State<FormularioAutenticacao> {
  final _controladorSenha = TextEditingController();
  ModoAutenticacao _modoAutenticacao = ModoAutenticacao.login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _estaCarregando = false;
  final Map<String, String> _dadosAutenticacao = {
    'email': '',
    'senha': '',
  };
  double _tamanhoBox = 0;
  int _tamanhoErro = 0;

  bool _eLogin() => _modoAutenticacao == ModoAutenticacao.login;
  bool _eSignup() => _modoAutenticacao == ModoAutenticacao.signup;

  void _trocarModo() {
    setState(() {
      _eLogin()
          ? _modoAutenticacao = ModoAutenticacao.signup
          : _modoAutenticacao = ModoAutenticacao.login;

      _tamanhoBox = tamanhoBoxLogin(
        _tamanhoErro,
        _eLogin(),
      );
    });
    _formKey.currentState?.reset();
    _controladorSenha.clear();
  }

  Future<void> _enviar() async {
    final estaValido = _formKey.currentState?.validate() ?? false;

    setState(
      () => _tamanhoBox = tamanhoBoxLogin(
        _tamanhoErro,
        _eLogin(),
      ),
    );

    _tamanhoErro = 0;

    if (!estaValido) return;

    setState(() => _estaCarregando = true);

    _formKey.currentState?.save();
    Autenticacao autenticacao = Provider.of<Autenticacao>(
      context,
      listen: false,
    );

    try {
      if (_eLogin()) {
        await autenticacao.signIn(
          _dadosAutenticacao['email']!,
          _dadosAutenticacao['senha']!,
        );
      } else {
        await autenticacao.signUp(
          _dadosAutenticacao['email']!,
          _dadosAutenticacao['senha']!,
        );
      }
    } catch (erro) {
      if (!context.mounted) return;
      mensagemErro(
        context: context,
        title: 'Ocorreu um erro!',
        content: erro.toString(),
      );
    }

    setState(() => _estaCarregando = false);
  }

  @override
  void initState() {
    super.initState();
    _tamanhoBox = tamanhoBoxLogin(
      _tamanhoErro,
      _eLogin(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoDispositivo = MediaQuery.of(context).size;
    final temaBotao = Theme.of(context).buttonTheme.colorScheme;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        curve: Curves.easeIn,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: _tamanhoBox,
          width: tamanhoDispositivo.width * 0.75,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    final retorno = Validador.campoEmail(email);
                    _tamanhoErro += (retorno?.length ?? 0);
                    return retorno;
                  },
                  onSaved: (email) => _dadosAutenticacao['email'] = email ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Senha",
                  ),
                  obscureText: true,
                  controller: _controladorSenha,
                  validator: (senha) {
                    final retorno = Validador.campoSenha(
                      senha,
                      _eLogin(),
                    );
                    _tamanhoErro += (retorno?.length ?? 0);
                    return retorno;
                  },
                  onSaved: (senha) => _dadosAutenticacao['senha'] = senha ?? '',
                ),
                if (_eSignup())
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Confirmar senha",
                      ),
                      obscureText: true,
                      validator: (senha) {
                        final retorno = Validador.campoConfirmaSenha(
                          senha,
                          _controladorSenha,
                        );
                        _tamanhoErro += (retorno?.length ?? 0);
                        return retorno;
                      }),
                const SizedBox(height: 20),
                _estaCarregando
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _enviar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: temaBotao?.background,
                          foregroundColor: temaBotao?.surface,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          _eLogin() ? 'ENTRAR' : 'REGISTRAR',
                        ),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: _trocarModo,
                  child: Text(
                      _eLogin() ? 'Deseja registrar?' : 'Já possui conta?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
