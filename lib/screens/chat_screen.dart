


import 'package:chat/chats/messages.dart';
import 'package:chat/chats/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Chat'),
        actions: [
          TextButton.icon(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.arrow_forward,color: Colors.white,), label:const Text('Log out',style:TextStyle(color: Colors.white)))
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessage()
      ],),
      /*floatingActionButton: FloatingActionButton(
         child:const Icon(Icons.add,color:Colors.white),
        onPressed: (){

        },
      ),*/
    );
  }
}
