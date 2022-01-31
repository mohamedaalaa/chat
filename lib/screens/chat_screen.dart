


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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/3lqjwP2ZTYNPGUN65aLf/messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          final document=snapshot.data.docs;
          return ListView.builder(
              itemCount: document.length,//document.length,
              itemBuilder: (_,i){
                return  Text(document[i]['text']);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add,color:Colors.white),
        onPressed: (){
          FirebaseFirestore.instance.collection('chats/3lqjwP2ZTYNPGUN65aLf/messages').add({
            'text':'this added by clicking the fab'
          });
        },
      ),
    );
  }
}
