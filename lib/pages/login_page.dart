import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_app/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Classe que exibe o formulário de login para o usuário
class LoginPage extends StatefulWidget {
  LoginPage ({Key? key}) : super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _ra = TextEditingController();
  final _pw = TextEditingController();

  var httpsUri = Uri(scheme: "https", host: "ajuda.utfpr.edu.br", path: "/pt-br/servicos_deinfra/recupera_senha");
  bool loading = false;

  @override
  void initState() {
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 252, 255, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bem vindo(a)",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildTextFormField(
                    controller: _ra,
                    label: "RA",
                    hintText: "a1234567",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildTextFormField(
                    controller: _pw,
                    label: "Senha",
                    obscureText: true,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () => _login(),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(20,184,143,1))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: (loading) ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()) :
                                              const Text("Entrar", style: TextStyle(color: Colors.black, fontSize: 16),)
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => alterarSenha(),
                  child: Text('Alterar senha'),
                ),
              ],
            ), 
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({required TextEditingController controller, required String label, String? hintText, bool obscureText = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }


  
  Future<void> _login () async {
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);
      try{
        await context.read<AuthService>().login(_ra.text, _pw.text);
      } on AuthException catch(e){
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  alterarSenha() async{
    if (!await launchUrl(httpsUri)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contate diretamente um servidor da biblioteca local.')));
    }
  }
}