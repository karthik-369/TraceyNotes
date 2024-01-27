// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as tools;

enum Menu { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Notes'),
      backgroundColor: Colors.green,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 30, 123, 33),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (value) async {
            // tools.log(value.toString());
            switch (value) {
              case Menu.logout:
                final shouldLogout = await logoutDialog(context);
                // tools.log(shouldLogout.toString());
                if (shouldLogout) {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (_) => false);
                }
                break;
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(value: Menu.logout, child: Text('Logout'))
            ];
          },
        )
      ],
    ));
  }
}

Future<bool> logoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log Out'))
        ],
      );
    },
  ).then((value) => value ?? false);
}
