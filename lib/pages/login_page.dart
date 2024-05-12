import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage ({Key? key}) : super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _ra = TextEditingController();
  final _pw = TextEditingController();

  //var httpsUri = Uri(scheme: "https", host: "ajuda.utfpr.edu.br", path: "/pt-br/servicos_deinfra/recupera_senha");
  bool isLogin = true;
  late String toggleButton;
  late String title;
  late String actionButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
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
                Text(
                  title,
                  style: const TextStyle(
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
                    onPressed: () {
                      if (isLogin) {
                        _login();
                      } else {
                        _changePassword();
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(20,184,143,1))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: (loading) ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()) :
                                              Text(actionButton, style: const TextStyle(color: Colors.black, fontSize: 16),)
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggleButton),
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
    

  void setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        toggleButton = "Alterar Senha";
        title = "Bem vindo";
        actionButton= "Login";
      } else {
        toggleButton = "Fazer Login";
        title = "Redefinir Senha";
        actionButton= "Redefinir"; 
      }
    });
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

  
  void _changePassword() {
    if (_formKey.currentState!.validate()) {

    }
  }
}