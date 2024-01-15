int tamanhoLinha(List<dynamic> produtos) {
  int tamanho = 0;
  const linha = 35;

  for (var produto in produtos) {
    if (produto.nomeProduto.length <= 24) {
      tamanho += linha * 1;
    } else if (produto.nomeProduto.length <= 48) {
      tamanho += linha * 2;
    } else {
      tamanho += linha * 3;
    }
  }

  return tamanho;
}
