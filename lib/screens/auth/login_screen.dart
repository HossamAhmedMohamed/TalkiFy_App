// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whats_app/screens/auth/forget_screen.dart';
import 'package:whats_app/utils/colors.dart';
import 'package:whats_app/widgets/logo.dart';
import 'package:whats_app/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  void dispose() {
    emailCon.dispose();
    passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoApp(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              // Text(
              //   "Material Chat App With Nabil AL Amawi",
              //   style: Theme.of(context).textTheme.bodyLarge,
              // ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomField(
                      controller: emailCon,
                      lable: "Email",
                      icon: Iconsax.direct,
                    ),
                    CustomField(
                      controller: passCon,
                      lable: "Password",
                      icon: Iconsax.password_check,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          child: const Text("Forget Password?"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetScreen(),
                                ));
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailCon.text, password: passCon.text);

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text("Login Successfully"),
                          //   ),
                          // );
                        } catch (e) {
                          print(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invalid Credentials"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Center(
                        child: Text(
                          "Login".toUpperCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          try {
                            await Supabase.instance.client.auth.signUp(
                              email: emailCon.text,
                              password: '123456',
                            );
                          } catch (e) {
                            print(e.toString());
                          }

                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailCon.text,
                                    password: passCon.text);

                            // await FireAuth.createUser();
                            Fluttertoast.showToast(msg: 'Account Created');
                          } catch (e) {
                            print(e.toString());
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        },
                        child: Center(
                          child: Text(
                            "Create Account".toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
