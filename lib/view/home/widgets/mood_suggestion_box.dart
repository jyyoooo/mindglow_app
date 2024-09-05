import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/video_player.dart';

class MoodSuggestionCard extends StatefulWidget {
  final String videoUrl;
  final String imagePath;

  const MoodSuggestionCard({
    required this.videoUrl,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  MoodSuggestionCardState createState() => MoodSuggestionCardState();
}

class MoodSuggestionCardState extends State<MoodSuggestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayer(videoUrl: widget.videoUrl),
          ),
        );
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: widget.imagePath,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.asset(
                          opacity: _controller,
                          widget.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Icon(
                            size: 50,
                            CupertinoIcons.play_arrow_solid,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. ')
            ],
          ),
        ),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String text;

  const StyledText({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Appcolor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
