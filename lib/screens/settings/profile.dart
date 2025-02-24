import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameCon = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameCon.text = "myNAme";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                    ),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: IconButton.filled(
                            onPressed: () {}, icon: const Icon(Iconsax.edit)))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Iconsax.user_octagon),
                  trailing:
                      IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit)),
                  title: TextField(
                    controller: nameCon,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Iconsax.information),
                  trailing:
                      IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit)),
                  title: TextField(
                    controller: nameCon,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: "About",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Card(
                child: ListTile(
                    leading: Icon(Iconsax.direct),
                    title: Text("Email"),
                    subtitle: Text("email@mail.com")),
              ),
              const Card(
                child: ListTile(
                    leading: Icon(Iconsax.timer_1),
                    title: Text("Joined On"),
                    subtitle: Text("20048102")),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(16),
                ),
                child: Center(
                  child: Text(
                    "Save".toUpperCase(),
                    // style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
