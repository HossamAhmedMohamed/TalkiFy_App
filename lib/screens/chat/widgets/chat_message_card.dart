import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/core/firebase/fire_base_room.dart';
import 'package:whats_app/core/models/message_model.dart';

class ChatMessageCard extends StatefulWidget {
  final int index;
  final MessageModel message;
  final String roomId;
  const ChatMessageCard({
    super.key,
    required this.index,
    required this.message, required this.roomId,
  });

  @override
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {

  @override
  void initState() {
    if (widget.message.toId == FirebaseAuth.instance.currentUser!.uid) {
      FireBaseRoom().readMessage(widget.roomId, widget.message.id!);    
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isMe = widget.message.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.message_edit))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
          )),
          color: isMe
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.message.type == 'image'
                      ? CachedNetworkImage(
                          imageUrl: widget.message.msg!,
                          // imageBuilder: (context, imageProvider) =>
                          //     Container(
                          //   height: 100,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(
                          //       60,
                          //     ),
                          //     image: DecorationImage(
                          //       image: imageProvider,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          placeholder: (context, url) => Container(
                            height: 100,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Text(widget.message.msg!),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isMe
                          ? widget.message.read == "" ? const Icon(
                            Icons.check , color: Colors.grey,
                            size: 18,
                          ) : const Icon(
                              Icons.done_all_outlined,
                              color: Colors.blueAccent,
                              size: 18,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        DateFormat.yMMMEd()
                            .format(DateTime.fromMillisecondsSinceEpoch(
                              int.parse(widget.message.createdAt!),
                            ))
                            .toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
