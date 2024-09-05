// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/auth/widgets/custom_tff.dart';
import 'package:mindglowequinox/view/home/widgets/bottom_navigation_bar.dart';
import 'package:mindglowequinox/view/auth/singup_screen.dart';
import '../../controller/auth_bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Appcolor.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/aura.jpeg',
            width: MediaQuery.of(context).size.width * 0.6,
            fit: BoxFit.cover,
          ),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is Authenticated) {
              if (FirebaseAuth.instance.currentUser?.uid == null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              } else {}
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const BottomNavBar()));
              });
            } else if (state is AuthLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is AuthenticateError) {}

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Mindglow',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'Password',
                            controller: _passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          CupertinoButton(
                              color: CupertinoColors.activeGreen,
                              child: const Text('Login'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  String email = _emailController.text;
                                  String password = _passwordController.text;

                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );

                                    BlocProvider.of<AuthBloc>(context).add(
                                      LoginEvent(
                                          email: email, password: password),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Invalid credentials')));
                                  }
                                }
                              }),
                          SizedBox(height: screenHeight * 0.02),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                            },
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Do not have an account?',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: CupertinoColors.activeBlue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
