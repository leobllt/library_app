import 'package:flutter/material.dart';
import 'package:library_app/repositories/user_data_repository.dart';
import 'package:library_app/widgets/debits_vertical_list.dart';
import 'package:provider/provider.dart';

class DebitsPage extends StatefulWidget {
  const DebitsPage({Key? key}) : super(key: key);

  @override
  _DebitsPageState createState() => _DebitsPageState();
}

class _DebitsPageState extends State<DebitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multas'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Consumer<UserDataRepository>(
        builder: (context, userData, _) {
          return DebitsVerticalList(list: userData.debits);
      }
      )
    );
  }
}