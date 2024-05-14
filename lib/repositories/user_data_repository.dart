import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/useraccount.dart';
import 'package:library_app/services/auth_services.dart';

// Classe que armazena localmente dados da conta logada e faz sincronização com o banco de dados
class UserDataRepository extends ChangeNotifier{
  UserAccount? contaLogada = null;
  List<Map<String,String>> debits = [];
  late Uint8List qr;
  late FirebaseFirestore db;
  late AuthService auth;

  UserDataRepository({required this.auth}){
    _startRepository();
  }

  Future<void> _startRepository() async{
    await _startFirebase();
    await _readUserAccount();
    await _readDebits();
  }

  Future<void> _startFirebase() async{
    db = DBFirestore.get();
  }

  Future<void> _readUserAccount() async{
    if(auth.usuario != null && contaLogada == null){
      final doc = await db.collection('usuarios').doc(auth.usuario!.uid).get();

      contaLogada = UserAccount(
        id: doc.id,
        nome: doc['nome'],
        sobrenome: doc['sobrenome'],
        dataNascimento: (doc['dataNascimento'] as Timestamp).toDate(),
        telefone: doc['telefone'],
        email: doc['email'],
        cpf: doc['cpf'],
        genero: doc['genero'],
        ra: doc['ra'],
        receberEmails: doc['receberEmails'],
        qr: doc['qr']
      );

      notifyListeners();
    }
  }

  Future<void> _readDebits() async{
    if(auth.usuario != null && debits.isEmpty){
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/debitos').get();

      if(snapshot.docs.isEmpty) return;

      snapshot.docs.forEach((doc) async {
        debits.add({doc['valor']: doc['situacao']});
      });

      notifyListeners();
    }
  }
}