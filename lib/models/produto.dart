class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  bool eFavorito;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.eFavorito = false,
  });
}
