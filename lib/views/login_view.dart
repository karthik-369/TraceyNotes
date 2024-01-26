import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_dart/firebase_options.dart';
import 'package:learning_dart/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
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
            decoration:
                const InputDecoration(hintText: "Enter your Email"),
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

              // final userCredential = await FirebaseAuth.instance
              //     .createUserWithEmailAndPassword(
              //   email: email,
              //   password: password,
              // );

              try {
                final uc = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(uc);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              } on FirebaseAuthException catch (e) {
                print("Enter a valid username / password");
              }

              // print(userCredential);
            },
            child: const Text('Sign In'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register', (route) => false);
              },
              child: const Text('Not Registered? Click Here'))
        ],
      )

    );
  }
}
