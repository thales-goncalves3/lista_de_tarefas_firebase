import 'package:flutter/material.dart';

import 'package:string_validator/string_validator.dart' as validator;

import '../controllers/auth_controller.dart';
import '../controllers/database_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscure = true;
  bool obscureConfirm = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  String passwordChanged = "";
  String passwordChangedConfirm = "";

  GlobalKey<FormState> formKey = GlobalKey();

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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this field is required";
                        }

                        if (value.length < 6) {
                          return "the username must have 6 or more digits";
                        }

                        return null;
                      },
                      controller: username,
                      decoration: const InputDecoration(
                        hintText: "Type your Username",
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Type your Email",
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this field is required";
                        }

                        if (!validator.isEmail(value)) {
                          return "this field must be email type";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: password,
                      obscureText: obscure,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return "this field is required";
                        }

                        if (password.length < 8) {
                          return "the password must have 8 or more digits ";
                        }

                        return null;
                      },
                      onChanged: (value) => passwordChanged = value,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Type your Password",
                          labelText: "Password",
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordConfirm,
                      onChanged: (value) => passwordChangedConfirm = value,
                      validator: (passwordConfirm) {
                        if (passwordConfirm == null ||
                            passwordConfirm.isEmpty) {
                          return "this field is required";
                        }

                        if (passwordConfirm.length < 8) {
                          return "the password must have 8 or more digits ";
                        }

                        if (passwordChanged != passwordChangedConfirm) {
                          return "the passwords must be equal";
                        }
                        return null;
                      },
                      obscureText: obscureConfirm,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Confirm your Password",
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(obscureConfirm
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                obscureConfirm = !obscureConfirm;
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
                    if (formKey.currentState!.validate()) {
                      final result = await AuthController.register(
                          email.text, password.text, username.text);

                      if (result) {
                        DatabaseController.createUser(
                            username.text, email.text);
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("User created! Back to login")));
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      }
                    }
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
