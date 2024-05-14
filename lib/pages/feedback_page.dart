
import 'package:flutter/material.dart';
import 'package:library_app/databases/queries/DBQuery.dart';
import 'package:library_app/repositories/user_data_repository.dart';
import 'package:provider/provider.dart';

// Classe que exibe um forms para registrar feedbacks
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedOption = "";
  late String _textValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Feedback'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _selectedOption,
                onChanged: (newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                  });
                },
                items: <String>['','Reclamação', 'Sugestão', 'Elogio', 'Outro']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Selecione uma opção',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma opção';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Digite algo',
                ),
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    _textValue = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite algo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => _submeter(),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(20,184,143,1))
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:  Text("Submeter", style: TextStyle(color: Colors.black, fontSize: 16))
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _submeter(){
    if (_formKey.currentState!.validate()) { 
      DBQuery.insertFeedback(Provider.of<UserDataRepository>(context, listen: false).contaLogada!.id, _selectedOption, _textValue);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulário enviado! Agradecemos seu feedback.'))
      );
  }
  }
}
