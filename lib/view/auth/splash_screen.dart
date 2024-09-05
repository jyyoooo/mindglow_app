// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/controller/api_bloc/api_bloc.dart';
import 'package:mindglowequinox/controller/auth_bloc/auth_bloc.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/home/widgets/bottom_navigation_bar.dart';
import 'package:mindglowequinox/view/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isDelayed = false;

  @override
  void initState() {
    log('in splash');
    super.initState();

    // Delay to simulate the splash screen duration
    Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        _isDelayed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (_isDelayed) {
            _navigateBasedOnState(context, state);
          } else {
            await Future.delayed(const Duration(seconds: 2));
            _navigateBasedOnState(context, state);
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // TweenAnimationBuilder for expanding image
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.0, end: 1.5),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/aura.jpeg',
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mindglow',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    CupertinoActivityIndicator()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateBasedOnState(BuildContext context, AuthState state) {
    if (state is Authenticated) {
      context.read<APIBloc>().add(FetchPosts());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } else if (state is UnAuthenticated) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }
}
