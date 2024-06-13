// Classe que armazena localmente unidades de biblioteca
import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:library_app/models/library.dart';

class LocalLibrary{
  static final List<Library> _lista = [
    Library(
      code: 'pg', nome: "Biblioteca Ponta Grossa", localizacao: const LatLng(-25.0520, -50.1302), 
      imgSrc: "assets/imgs/pg.jpg", 
      endereco: "R. Doutor Washington Subtil Chueire, 330 - Jardim Carvalho, Ponta Grossa - PR, 84017-220",
      horario: "Das 8h às 17h"
    ),
    Library(code: 'ct', nome: "Biblioteca Curitiba", localizacao: const LatLng( -25.4395, -49.2692), 
      imgSrc: "assets/imgs/ct.png", 
      endereco: "Av. Sete de Setembro, 3165 - Rebouças, Curitiba - PR, 80230-901",
      horario: "Das 8h às 17h"
    ),
    Library(code: 'dv', nome: "Biblioteca Dois Vizinhos", localizacao: const LatLng(-25.7047, -53.0976),
      imgSrc: "assets/imgs/dv.jpg", 
      endereco: "Estr. p/ Boa Esperança, km 04 - Zona Rural, Dois Vizinhos - PR, 85660-000",
      horario: "Das 8h às 17h"
    ),
    Library(code: 'md', nome: "Biblioteca Medianeira", localizacao: const LatLng(-25.3009, -54.1151), 
      imgSrc: "assets/imgs/md.jpeg", 
      endereco: "Av. Brasil, 4232 - Independência, Medianeira - PR, 85884-000",
      horario: "Das 8h às 17h"
    ),
    Library(code: 'td', nome: "Biblioteca Toledo", localizacao: const LatLng(-24.7330, -53.7637), 
      imgSrc: "assets/imgs/td.jpeg", 
      endereco: "R. Cristo Rei, 19 - Vila Becker, Toledo - PR, 85902-490",
      horario: "Das 8h às 17h"
    ),
  ];

  static UnmodifiableListView<Library> get lista => UnmodifiableListView(_lista);
}