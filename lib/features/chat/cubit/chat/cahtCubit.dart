import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/shared/network/send_notification_services.dart';
import 'chatStates.dart';


class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  ChatCubit  get(context) => BlocProvider.of(context);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String text,
    required String deviceToken,
    required String title,
    required String senderName,
  }) async {
    if (text.trim().isEmpty) return;

    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((onValue){
      sendNotification
        (token: deviceToken, title: title, body: text, data: {
        'chat_id': chatId,
        'sender_id': senderId,
        'sender_name': senderName,
      });
     // sendNotif(deviceToken: deviceToken, title: title, body: text, chatId: chatId, senderName: senderName, senderId: senderId);
    }).catchError((onError){
      print(onError.toString());
    });

  }

  void loadMessages(String chatId) {
    try {
      _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots()
          .listen((snapshot) {
        final messages = snapshot.docs.map((doc) => doc.data()).toList();
        emit(ChatLoaded(messages));
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
  void sendNotif({
    required String deviceToken,
    required String title,
    required String body,
    required String chatId,
    required String senderName,
    required String senderId,
}){
   // NotificationService.sendNotification(deviceToken: deviceToken, title: title, body: body);
    sendNotification
      (token: deviceToken, title: title, body: body, data: {
      'chat_id': chatId,
      'sender_id': senderId,
      'sender_name': senderName,
    });
  }
}
