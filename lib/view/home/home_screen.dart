import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/controller/auth_bloc/auth_bloc.dart';
import 'package:mindglowequinox/controller/mood_bloc/mood_bloc.dart';
import 'package:mindglowequinox/repositories/challenges_repository.dart';
import 'package:mindglowequinox/view/auth/login_screen.dart';
import 'package:mindglowequinox/view/home/widgets/mood_suggestion_box.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/home/widgets/mood_tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(context),
              _buildDailyChallenge(),
              _buildMoodTracker(context, screenWidth),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: StyledText(
                    text: 'Growth happens now',
                  ),
                ),
              ),
              _buildListItems(),
            ],
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildListItems() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: BlocBuilder<MoodBloc, MoodState>(builder: (context, state) {
          switch (state) {
            case GoodMood():
              return const MoodSuggestionCard(
                videoUrl: 'https://youtu.be/4q1dgn_C0AU?si=E74_RhakudnY1typ',
                imagePath: 'assets/images/greenHealth.jpeg',
              );
            case OkayMood():
              return const MoodSuggestionCard(
                videoUrl: 'https://youtu.be/nEVjlT9B6dU?si=ipqS8Z2ipwNPwrFt',
                imagePath: 'assets/images/relaxed.jpeg',
              );
            case NotOkayMood():
              return const MoodSuggestionCard(
                videoUrl: 'https://youtu.be/xspOP64y4fw?si=AxnA2nBngRDFR0NO',
                imagePath: 'assets/images/okayHealth.jpeg',
              );
            case ReallyBadMood():
              return const MoodSuggestionCard(
                videoUrl: 'https://youtu.be/F2hc2FLOdhI?si=hJcEBjAMkBVlg-BV',
                imagePath: 'assets/images/sadHealth.jpeg',
              );
            default:
              return const Column(
                children: [
                  SizedBox(height: 16),
                  MoodSuggestionCard(
                    videoUrl:
                        'https://youtu.be/4q1dgn_C0AU?si=E74_RhakudnY1typ',
                    imagePath: 'assets/images/greenHealth.jpeg',
                  ),
                  SizedBox(height: 16),
                  MoodSuggestionCard(
                    videoUrl:
                        'https://youtu.be/nEVjlT9B6dU?si=ipqS8Z2ipwNPwrFt',
                    imagePath: 'assets/images/relaxed.jpeg',
                  ),
                  SizedBox(height: 16),
                  MoodSuggestionCard(
                    videoUrl:
                        'https://youtu.be/xspOP64y4fw?si=AxnA2nBngRDFR0NO',
                    imagePath: 'assets/images/okayHealth.jpeg',
                  ),
                  SizedBox(height: 16),
                  MoodSuggestionCard(
                    videoUrl:
                        'https://youtu.be/F2hc2FLOdhI?si=hJcEBjAMkBVlg-BV',
                    imagePath: 'assets/images/sadHealth.jpeg',
                  ),
                  SizedBox(height: 25),
                ],
              );
          }
        }),
      ),
    );
  }

  SliverToBoxAdapter _buildMoodTracker(
      BuildContext context, double screenWidth) {
    return SliverToBoxAdapter(
      child:
          SizedBox(height: 155, width: screenWidth, child: const MoodTracker()),
    );
  }

  SliverToBoxAdapter _buildDailyChallenge() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          color: Appcolor.cardioColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Challenge for you',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Appcolor.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                FutureBuilder(
                  future: ChallengeRepo.getChallenge(),
                  builder: (context, snapshot) => Text(
                    snapshot.data?.toString() ?? 'Loading challenge...',
                    style: const TextStyle(
                        fontSize: 19.0,
                        color: Appcolor.peach,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      stretch: true,
      expandedHeight: 100,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground
        ],
        background: Image.asset(
          'assets/images/aura.jpeg',
          fit: BoxFit.cover,
        ),
        titlePadding: const EdgeInsets.only(left: 15, bottom: 10),
        expandedTitleScale: 1.5,
        collapseMode: CollapseMode.pin,
        title: const Text(
          'Mindglow',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.square_arrow_right,
              color: Appcolor.red),
          onPressed: () => showLogoutConfirmationDialog(context),
        ),
      ],
    );
  }
}

Future<void> showLogoutConfirmationDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return SizedBox(
        height: 100,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              backgroundColor: CupertinoColors.lightBackgroundGray,
              title: const Text('Are you sure you want to logout?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    final authBloc = BlocProvider.of<AuthBloc>(context);

                    authBloc.add(Logoutevent());

                    await Future.delayed(const Duration(milliseconds: 500));
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Appcolor.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
