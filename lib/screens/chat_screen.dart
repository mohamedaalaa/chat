


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Chat'),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/3lqjwP2ZTYNPGUN65aLf/messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          final document=snapshot.data.documents;
          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (_,i){
                return  Text(document[i]['text']);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FirebaseFirestore.instance.collection('chats/3lqjwP2ZTYNPGUN65aLf/messages').add({
            'text':'this added by clicking the fab'
          });
        },
      ),
    );
  }
}
