import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_dart/firebase_options.dart';
import 'package:learning_dart/views/login_view.dart';
import 'package:learning_dart/views/register_view.dart';
import 'package:learning_dart/views/verify_view.dart';
// import 'package:learning_dart/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Trap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // backgroundColor: Colors.yellow,
        // useMaterial3: true,
      ),
      home: const LoginView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomePage(),
        '/verify': (context) => const VerifyEmail(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green,
        // foregroundColor: Colors.yellow,
        // shadowColor: Colors.orange,
        // surfaceTintColor: Colors.orange,
        // bottom: Colors.yellowAccent,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // TODO: Handle this case.
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print("ulla po");
              } else {
                print('vella po');
                // Navigator.of(context).pushNamedAndRemoveUntil('/verify', (route) => false);
                return const VerifyEmail();
              }
              return const Text('Done');
            // return const LoginView();
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
