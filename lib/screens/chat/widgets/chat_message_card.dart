import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatMessageCard extends StatelessWidget {
  final int index;
  const ChatMessageCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          index % 2 == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        index % 2 == 0
            ? IconButton(onPressed: () {}, icon: const Icon(Iconsax.message_edit))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(index % 2 == 0 ? 16 : 0),
            bottomRight: Radius.circular(index % 2 == 0 ? 0 : 16),
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
          )),
          color: index % 2 == 0
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
                  const Text("Messagejsdhkjhdks"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      index % 2 == 0
                          ? const Icon(
                              Iconsax.tick_circle,
                              color: Colors.blueAccent,
                              size: 18,
                            )
                          : const SizedBox(),
                      Text(
                        "06:16 pm",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 6,
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
