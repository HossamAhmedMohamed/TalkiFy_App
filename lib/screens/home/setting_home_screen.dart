import 'package:chat_material3/screens/settings/profile.dart';
import 'package:chat_material3/screens/settings/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';

class SettingHomeScreen extends StatefulWidget {
  const SettingHomeScreen({super.key});

  @override
  State<SettingHomeScreen> createState() => _SettingHomeScreenState();
}

class _SettingHomeScreenState extends State<SettingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            ListTile(
              minVerticalPadding: 40,
              leading: const CircleAvatar(
                radius: 30,
              ),
              title: const Text("Name"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QrCodeScreen(),
                        ));
                  },
                  icon: const Icon(Iconsax.scan_barcode)),
            ),
            Card(
              child: ListTile(
                title: const Text("Profile"),
                leading: const Icon(Iconsax.user),
                trailing: const Icon(Iconsax.arrow_right_3),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    )),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: Colors.red,
                            onColorChanged: (value) {},
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Done"))
                        ],
                      );
                    },
                  );
                },
                title: const Text("Theme"),
                leading: const Icon(Iconsax.color_swatch),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Dark Mode"),
                leading: const Icon(Iconsax.user),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text("Signout"),
                trailing: Icon(Iconsax.logout_1),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
