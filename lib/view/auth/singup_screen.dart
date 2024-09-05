import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mindglowequinox/model/user_model.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/auth/login_screen.dart';
import 'package:mindglowequinox/controller/auth_bloc/auth_bloc.dart';

import 'widgets/custom_tff.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Appcolor.lightCream,
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account created, Login now')));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              });
            } else if (state is AuthenticateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Appcolor.red,
                  content: Text(
                      "The email address is already in use by another account."),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/aura.jpeg',
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment
                            .center, 
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Sign up to MindGlow',
                            style: TextStyle(
                              color: Appcolor.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch, // Fill the width
                              children: [
                                CustomTextField(
                                  keyboardType: TextInputType.name,
                                  hintText: 'Name',
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Email',
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  isPassword: true,
                                  hintText: 'Password',
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    } else if (value.length < 7) {
                                      return 'Password must be at least 7 characters long';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                CupertinoButton(
                                  color: CupertinoColors.activeGreen,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      MindGlowUser user = MindGlowUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                      );

                                      context
                                          .read<AuthBloc>()
                                          .add(SignUp(usermodel: user));
                                    }
                                  },
                                  child: const Text('Register'),
                                ),
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Log in',
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
                  ),
                  if (state is AuthLoading)
                    const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
