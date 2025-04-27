import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/models/user.dart';
import '../../../core/shared/local/cache_helper.dart';
import '../../../core/shared/local/helpers.dart';
import '../cubit/chat/cahtCubit.dart';
import '../cubit/chat/chatStates.dart';


class ChatScreen extends StatelessWidget {
  final UserModel otherUser;
  final ScrollController _scrollController = ScrollController();


   ChatScreen({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final String chatId = getChatId(currentUser.uid, otherUser.uid);
    final TextEditingController messageController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.image_not_supported),
            ),
            const SizedBox(width: 10),
            Text(otherUser.name),
          ],
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) =>ChatCubit()..loadMessages(chatId),
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            var cubit=ChatCubit().get(context);
            if (state is ChatLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                  );
                }
              });

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(10),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final msg = state.messages[index];
                        final isMe = msg['senderId'] == currentUser.uid;
                        return Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg['text'],
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                                hintText: 'Type a message...'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            cubit.sendMessage(
                              chatId: chatId,
                              senderId: currentUser.uid,
                              receiverId: otherUser.uid,
                              text: messageController.text.trim(),
                              deviceToken: otherUser.token,
                              title:CacheHelper.getData(key: "name")??'',
                              senderName: CacheHelper.getData(key: "name")??"",
                            );
                            messageController.clear();
                            FirebaseMessaging.instance.getToken().then((token) {
                              print(token);
                              print(otherUser.token);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
