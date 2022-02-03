import 'package:chat/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return

       StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final messages = snapshot.data.docs;
            return  ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, i) {
                      return MessageBubble(message: messages[i]['text'],
                        isMe: messages[i]['usrId']==snapshot.data.uid,);
                    });
              },
            );
          });
        }

  }

