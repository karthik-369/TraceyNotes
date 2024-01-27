import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_dart/constants/routes.dart';
import 'package:learning_dart/firebase_options.dart';
import 'dart:developer' as tools;
import 'package:learning_dart/views/show_error_dialog.dart' as error;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.amber,
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.green,
          // foregroundColor: Colors.yellow,
          // shadowColor: Colors.orange,
          // surfaceTintColor: Colors.orange,
          // bottom: Colors.yellowAccent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 30, 123, 33),
          ),
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Enter your Email"),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter your password",
              ),
            ),
            TextButton(
              onPressed: () async {
                await Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                );

                final email = _email.text;
                final password = _email.text;

                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  tools.log(userCredential.toString());
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(login, (route) => false);
                  
                  Navigator.of(context).pushNamed( verify);


                } on FirebaseAuthException catch (e) {
                  tools.log(e.toString());
                  tools.log(e.runtimeType.toString());
                  tools.log(e.code);
                  if (e.code == 'email-already-in-use') {
                    tools.log("Email Already in Use");
                    await error.errorDialog(context, 'Email already in use');
                  } else if (e.code == 'weak-password') {
                    tools.log("Weak Password");
                    await error.errorDialog(context, 'Weak Password');
                  } else {
                    await error.errorDialog(context, e.code.toString());
                  }
                } catch(e) {
                  await error.errorDialog(context, e.toString());
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(login, (route) => false);
                },
                child: const Text('Registered already, Sigin here')
            )
          ]
        )
    );
  }
}
