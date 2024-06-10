import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/debits_page.dart';
import 'package:library_app/pages/feedback_page.dart';
import 'package:library_app/pages/history_page.dart';
import 'package:library_app/pages/user_detail.page.dart';
import 'package:library_app/repositories/user_data_repository.dart';
import 'package:library_app/services/auth_service.dart';
import 'package:provider/provider.dart';

// View com demais opções disponíveis para o usuário logado
class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Opções'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             _Option(text: "Meus dados", widget: UserDetailPage(userAccount: context.read<UserDataRepository>().contaLogada),),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Multas", widget: DebitsPage()),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Histórico", widget: HistoryPage()),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Declaração de nada consta", widget: null),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Dê seu feedback", widget: FeedbackPage()),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => context.read<AuthService>().logout(),
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 233, 126, 126))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Sair da conta', style: TextStyle(color: Colors.black, fontSize: 16),)
                        )
                      ],
                    ),
                  ),
                ),
            ],
          )
        )
      ),
    );
  }
}

class _Option extends StatelessWidget{
    final String text;
    final Widget? widget;
    const _Option({required this.text, required this.widget});

    @override
    Widget build(BuildContext context) {
      return CupertinoButton(
        onPressed: () { if(widget!=null)
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget!),
        );},
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(
              Icons.arrow_forward_sharp,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
                text,
                style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
  }