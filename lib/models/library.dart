import 'package:google_maps_flutter/google_maps_flutter.dart';

class Library {
  final String code;
  final String nome;
  final LatLng localizacao;
  final String imgSrc;
  final String endereco;

  Library({
    required this.code,
    required this.nome,
    required this.localizacao,
    required this.imgSrc,
    required this.endereco
  });

  @override
  bool operator ==(covariant Library b){
    if(identical(this, b)) return true;
    return code == b.code;
  }

  @override
  int get hashCode {
    return code.hashCode ^ nome.hashCode;
  }
}
