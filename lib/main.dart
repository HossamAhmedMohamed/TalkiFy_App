// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whats_app/firebase_options.dart';
import 'package:whats_app/layout.dart';
import 'package:whats_app/screens/auth/login_screen.dart';
import 'package:whats_app/screens/auth/setup_profile.dart';
import 'package:whats_app/utils/keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await dotenv.load(fileName: ".env");
  // } catch (e) {
  //   print(e.toString());
  // }
  try {
    await Supabase.initialize(
      url: Keys.supabaseUrl,
      anonKey: Keys.supabaseKey,
    );
  } catch (e) {
    print(e.toString());
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp',
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red, brightness: Brightness.dark),
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.light),
          useMaterial3: true,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (FirebaseAuth.instance.currentUser!.displayName == "" ||
                    FirebaseAuth.instance.currentUser!.displayName == null) {
                  return const SetupProfile();
                } else {
                  return const LayoutApp();
                }
              } else {
                return const LoginScreen();
              }
            }));
  }
}
