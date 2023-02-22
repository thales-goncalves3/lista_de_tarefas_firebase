import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/firebase_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  final controller = FirebaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                        labelText: "Email",
                      ),
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
                    final result =
                        await controller.register(email.text, password.text);

                    result == true
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("User created! Back to login")))
                        : ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("CADASTRAR"),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/login_page");
                  },
                  child: const Text("Já tem cadastro? Login"))
            ],
          )),
    );
  }
}
