class Book {
  final String id;
  final String titulo;
  final List<String> autores;
  final String anoPublicacao;
  final String numeroPaginas;
  final String areaPrincipal;
  final bool disponivel;
  final String url;

  Book({
    required this.id,
    required this.titulo,
    required this.autores,
    required this.anoPublicacao,
    required this.numeroPaginas,
    required this.areaPrincipal,
    required this.disponivel,
    required this.url
  });

  @override
  bool operator ==(covariant Book b){
    if(identical(this, b)) return true;
    return id == b.id;
  }

  @override
  int get hashCode {
    return titulo.hashCode ^ autores.hashCode;
  }
}
