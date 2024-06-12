import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_app/models/useraccount.dart';

// Classe que exibe detalhes do usuário logado
class UserDetailPage extends StatelessWidget {
  final UserAccount? userAccount;
  const UserDetailPage({super.key, required this.userAccount});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10),),
            Center(
              child: SizedBox(
                height: 100,
                child: Image.asset('assets/imgs/user.png')
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0,0,0, 0.08),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1), // Define a largura da primeira coluna
                      1: FlexColumnWidth(2), // Define a largura da segunda coluna
                    },
                    children: [
                      _buildTableRow('Nome completo:', userAccount!.nome + ' ' + userAccount!.sobrenome),
                      _buildTableRow('RA:', userAccount!.ra),
                      _buildTableRow('CPF', userAccount!.cpf),
                      _buildTableRow('Gênero', userAccount!.genero),
                      _buildTableRow('Data nascimento', userAccount!.dataNascimento.day.toString() + 
                                      '/' + userAccount!.dataNascimento.month.toString() 
                                      + '/' + userAccount!.dataNascimento.year.toString()),
                      _buildTableRow('Telefone:', userAccount!.telefone),
                      _buildTableRow('E-mail:', userAccount!.email),
                      _buildTableRow('Receber e-mails:', userAccount!.receberEmails ? 'Sim' : 'Não'),
                    ],
                  ),
            ),
          
            Container(child: Text('Para alterar seus dados, contate o administrador do sistema.', textAlign: TextAlign.center,overflow:TextOverflow.ellipsis, style: TextStyle(fontSize: 14,color:  Colors.red, fontStyle: FontStyle.italic),))

          ],
        ),
      ),
    );
  }
}

  // Definindo modelo de tabela para exibição dos dados
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
