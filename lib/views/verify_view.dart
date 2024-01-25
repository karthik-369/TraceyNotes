import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_dart/firebase_options.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Verify'),
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
              return Column(
                children: [
                  const Text('Verify Your Email Address'),
                  TextButton(
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                    },
                    child: const Text(
                      'Send email verification',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                      child: const Text('Login'))
                ],
              );
            default:
              return Text('Loading...');
          }
        },
      ),
    );
  }
}
