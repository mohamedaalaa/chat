

import 'package:chat/screens/chat_screen.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {


  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  void _submitUser(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) async {

    try {
    if (isLogin) {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

    } else {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'userName': userName,
        'email': email,
      });
    }
    } on PlatformException catch (error) {
      var message = 'an error occurred please check your credentials';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (error) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body:AuthForm(
          submitUser: _submitUser,
        ));
            /**/
  }
}
