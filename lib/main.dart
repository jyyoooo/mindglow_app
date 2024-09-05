import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/controller/api_bloc/api_bloc.dart';
import 'package:mindglowequinox/controller/auth_bloc/auth_bloc.dart';
import 'package:mindglowequinox/controller/mood_bloc/mood_bloc.dart';
import 'package:mindglowequinox/firebase_options.dart';
import 'package:mindglowequinox/view/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckActiveUser()),
        ),
        BlocProvider(
          create: (context) {
            final apiBloc = APIBloc();
            apiBloc.add(FetchPosts());
            apiBloc.add(FetchComments());
            apiBloc.add(FetchAlbums());
            apiBloc.add(FetchPhotos());
            apiBloc.add(FetchTodos());
            apiBloc.add(FetchUsers());
            return apiBloc;
          },
        ),
        BlocProvider(create: (context) => MoodBloc())
      ],
      child: MaterialApp(
        title: 'MindGlow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
