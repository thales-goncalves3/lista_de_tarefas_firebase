import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../controllers/database_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          labelText: "Email"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: obscure,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Senha",
                          labelText: "Senha",
                          suffixIcon: IconButton(
                            icon: Icon(obscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final login =
                        await AuthController.login(email.text, password.text);

                    if (login == null) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed("/home_page");
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: Text(login),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"))
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("LOGAR"),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/register_page");
                  },
                  child: const Text("Não tem cadastro? Cadastrar")),
            ],
          ),
        ),
      ),
    );
  }
}
