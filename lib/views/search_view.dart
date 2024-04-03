import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _formkey = GlobalKey<FormState>();
  final _value   = TextEditingController();

  verificarForm() {
  if(_formkey.currentState!.validate()){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("?? Resultados"),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Consulta acervo'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(         
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Form(
                    key: _formkey,
                    child: TextFormField(
                      controller: _value,
                      style:const TextStyle(
                        fontFamily: 'jost',
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Livro, Autor...",
                      ),
                      validator:(value) {
                        if(value!.isEmpty) {
                          return "Caixa de pesquisa vazia";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: IconButton(
                    onPressed: verificarForm,
                    icon: const Icon(
                      Icons.search,
                      size: 35,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
