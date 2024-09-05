import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindglowequinox/view/video_player.dart';

class WellnessGuideCard extends StatefulWidget {
  final String videoUrl;
  final String imagePath;
  final String title;

  const WellnessGuideCard({
    required this.videoUrl,
    required this.imagePath,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  WellnessGuideCardState createState() => WellnessGuideCardState();
}

class WellnessGuideCardState extends State<WellnessGuideCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(.2))
                            ]),
                            child: const Icon(
                              size: 50,
                              CupertinoIcons.play_arrow_solid,
                              color: Colors.blueGrey,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const Text(
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis. ')
            ],
          ),
        ),
      ),
    );
  }
}
