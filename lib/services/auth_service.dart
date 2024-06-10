import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AuthException implements Exception{
  String message;
  AuthException({required this.message});
}

// Classe que permite a autenticação de usuários no app
class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = true;

  AuthService(){
    _authChecK();
  }

  void _authChecK(){
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  void _getUser(){
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future<void> login(String ra, String senha) async{
    try {
      // Buscar usuário no banco com base no ra do aluno
      final DatabaseReference emailRef = FirebaseDatabase.instance.ref(ra);
      final emailSnapshot = await emailRef.get();
      if(emailSnapshot.exists){
        String email = emailSnapshot.value as String;
        // Faz o login
        await _auth.signInWithEmailAndPassword(email: email, password: senha);
        _getUser();
      }
      else
        throw FirebaseAuthException(code: 'user-not-found');
        
    } on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found')
        throw AuthException(message: 'Usuário não cadastrado.');
      else if(e.code == 'invalid-email')
        throw AuthException(message: 'Usuário com dados inválidos no sistema.');
      else
        throw AuthException(message: 'Senha incorreta. Tente novamente.');
    } catch (e2){
        print(e2.toString());
        throw AuthException(message: 'Erro inesperado no serviço Firebase');
    }
  } 

  void logout(){
    _auth.signOut();
    _getUser();
    notifyListeners();
  }
}