// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whats_app/core/firebase/fire_base_room.dart';
import 'package:whats_app/core/models/chat_user_model.dart';
import 'package:whats_app/core/models/message_model.dart';
import 'package:whats_app/core/supabase/supabase_storage.dart';
import 'package:whats_app/screens/chat/widgets/chat_message_card.dart';
import 'package:path/path.dart' as path;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.roomId, required this.user});
  final String roomId;
  final ChatUserModel user;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.user.name!),
            Text(
              widget.user.lastActivated!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.trash),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.copy),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rooms')
                      .doc(widget.roomId)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messages = snapshot.data!.docs
                          .map((e) => MessageModel.fromJson(e.data()))
                          .toList()
                        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                      return messages.isNotEmpty
                          ? ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return ChatMessageCard(
                                  index: index,
                                  message: messages[index],
                                   roomId: widget.roomId,
                                );
                              },
                            )
                          : Center(
                              child: InkWell(
                                onTap: () {
                                  FireBaseRoom().sendMessage(
                                      widget.user.id!, "hi 👋", widget.roomId);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "👋",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          "Say Hi",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    } else {
                      return Container();
                    }
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: messageController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.emoji_happy),
                              ),
                              IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50,
                                  );
                                  if (image != null) {
                                    try {
                                      String originalFilename =
                                          path.basename(image.path);
                                      String fileName =
                                          "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";
                                      print(fileName);
                                      try {
                                        await Supabase.instance.client.storage
                                            .from('messages')
                                            .upload(
                                              fileName,
                                              File(
                                                image.path,
                                              ),
                                            );
                                      } catch (e) {
                                        print(e.toString());
                                      }

                                      final String url = Supabase
                                          .instance.client.storage
                                          .from("messages")
                                          .getPublicUrl(
                                            fileName,
                                          );

                                      SupabaseStorage().sendImage(
                                          roomId: widget.roomId,
                                          imgUrl: url,
                                          uId: widget.user.id!);
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                },
                                icon: const Icon(Iconsax.camera),
                              ),
                            ],
                          ),
                          border: InputBorder.none,
                          hintText: "Message",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10)),
                    ),
                  ),
                ),
                messageController.text.isEmpty
                    ? const Icon(
                        Icons.send,
                      )
                    : IconButton.filled(
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            FireBaseRoom()
                                .sendMessage(widget.user.id!,
                                    messageController.text, widget.roomId)
                                .then((value) {
                              setState(() {
                                messageController.clear();
                              });
                            });
                          }
                        },
                        icon: const Icon(Iconsax.send_1))
              ],
            )
          ],
        ),
      ),
    );
  }
}
