import 'package:chat_material3/screens/contacts/contact_card.dart';
import 'package:chat_material3/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactHomeScreen extends StatefulWidget {
  const ContactHomeScreen({super.key});

  @override
  State<ContactHomeScreen> createState() => _ContactHomeScreenState();
}

class _ContactHomeScreenState extends State<ContactHomeScreen> {
  bool searched = false;
  TextEditingController emailCon = TextEditingController();
  TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          searched
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searched = false;
                    });
                  },
                  icon: const Icon(Iconsax.close_circle))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searched = true;
                    });
                  },
                  icon: const Icon(Iconsax.search_normal))
        ],
        title: searched
            ? Row(
                children: [
                  Expanded(
                      child: TextField(
                    autofocus: true,
                    controller: searchCon,
                    decoration: const InputDecoration(
                      hintText: "Search by name",
                      border: InputBorder.none,
                    ),
                  ))
                ],
              )
            : const Text("My Contacts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter Friend Email",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        IconButton.filled(
                          onPressed: () {},
                          icon: const Icon(Iconsax.scan_barcode),
                        )
                      ],
                    ),
                    CustomField(
                      controller: emailCon,
                      icon: Iconsax.direct,
                      lable: "Email",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer),
                        onPressed: () {},
                        child: const Center(
                          child: Text("Add Contact"),
                        ))
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.user_add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return const ContactCard();
            },
          ))
        ]),
      ),
    );
  }
}
