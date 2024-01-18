class AutenticacaoExcecao implements Exception {
  static const Map<String, String> erros = {
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado por muitas tentativas. Tente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha inválida.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
  };

  final String key;

  const AutenticacaoExcecao(this.key);

  @override
  String toString() {
    return erros[key] ?? 'Ocorreu um erro no processo de autenticação.';
  }
}
