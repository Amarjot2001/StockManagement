import 'package:flutter/material.dart';
import 'package:stock_management/screens/main.dart';
import '../helper/PrimaryBtn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  StateLoginScreen createState() => StateLoginScreen();
}

class StateLoginScreen extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email = TextEditingController(text: 'amarjotooaesolutions@gmail.com');
    password = TextEditingController(text: 'amarjot@10');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Management'),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 30, top: 100, right: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextFormField(
                        validator: (value) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? "")) {
                          } else {
                            return 'Email is not Valid';
                          }
                          return null;
                        },
                        controller: email,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Email',
                            hintText: 'Enter valid email'),
                      ),
                    ),
                    const SizedBox(
                      height: 10, // <-- SEE HERE
                    ),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 6) {
                            return 'Please enter at least 6 characters';
                          }
                          return null;
                        },
                        controller: password,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Password',
                            hintText: 'Enter your secure password'),
                      ),
                    ),
                    const SizedBox(
                      height: 30, // <-- SEE HERE
                    ),
                    PrimaryBtn(buttonTap: onTapBtnSignUp, name: "Login")
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void onTapBtnSignUp() async {
    if (_formKey.currentState!.validate()) {
        navigate();
      }
    //   final response = await Supabase.instance.client.auth
    //       .signUp(email: email.text, password: password.text);
    //   if (response.user?.emailConfirmedAt != null) {
    //     navigate();
    //   }
    // }
  }

  void navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AppWidget()),
    );
  }
}
