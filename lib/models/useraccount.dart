class UserAccount {
  final String id;
  final String nome;
  final String sobrenome;
  final DateTime dataNascimento;
  final String telefone;
  final String email;
  final String cpf;
  final String genero;
  final String ra;
  final bool receberEmails;
  final String qr;

  UserAccount({
    required this.id,
    required this.nome, 
    required this.sobrenome,
    required this.dataNascimento,
    required this.telefone,
    required this.email,
    required this.cpf,
    required this.genero,
    required this.ra,
    required this.receberEmails,
    required this.qr
  });

  @override
  bool operator ==(covariant UserAccount u){
    if(identical(this, u)) return true;
    return id == u.id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ ra.hashCode ^ cpf.hashCode;
  }
}
