import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindglowequinox/controller/api_bloc/api_bloc.dart';
import 'package:mindglowequinox/controller/auth_bloc/auth_bloc.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/home/widgets/bottom_navigation_bar.dart';
import 'package:mindglowequinox/view/auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<APIBloc>().add(FetchPosts());
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
          } else if (state is UnAuthenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Appcolor.rose,
                Appcolor.blue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.2,
                ),
                Image.asset(
                  'assets/images/aura.jpeg',
                  height: screenSize.height * 0.5,
                  width: screenSize.width * 0.8,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                const CupertinoActivityIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
