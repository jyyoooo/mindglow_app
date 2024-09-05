import 'package:flutter/material.dart';
import 'package:mindglowequinox/view/wellness_guide/widgets/wellness_card.dart';

class WellnessGuide extends StatefulWidget {
  const WellnessGuide({super.key});

  @override
  State<WellnessGuide> createState() => _WellnessGuideState();
}

class _WellnessGuideState extends State<WellnessGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [_buildAppBar(context), _buildListItems()],
      ),
    );
  }

  SliverToBoxAdapter _buildListItems() {
    return const SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          WellnessGuideCard(
            title: 'Techniques for Relaxation',
            videoUrl: 'https://youtu.be/7CBfCW67xT8?si=CxcWlcu7PKMvPR8J',
            imagePath: 'assets/images/relaxation.jpeg',
          ),
          SizedBox(height: 10),
          WellnessGuideCard(
            title: 'Importance of Sleep',
            videoUrl: 'https://youtu.be/5MuIMqhT8DM?si=BDLMg-t0u--gFX6P',
            imagePath: 'assets/images/sleep.jpeg',
          ),
          SizedBox(height: 10),
          WellnessGuideCard(
            title: 'Eating Healthy',
            videoUrl: 'https://youtu.be/Q4yUlJV31Rk?si=rofw8x35qKs5z2RB',
            imagePath: 'assets/images/balanceddiet.jpeg',
          ),
          SizedBox(height: 10),
          WellnessGuideCard(
            title: 'Meditate to Levitate',
            videoUrl: 'https://youtu.be/m8rRzTtP7Tc?si=h-Npkcks89HLkCB2',
            imagePath: 'assets/images/meditation.jpeg',
          ),
          SizedBox(height: 10),
          WellnessGuideCard(
            title: 'Staying Active',
            videoUrl: 'https://youtu.be/QgM1SatFFgc?si=eHHLXjMJLOnOXpx8',
            imagePath: 'assets/images/activity.jpeg',
          ),
          SizedBox(height: 10),
          WellnessGuideCard(
            title: 'Art of Focus',
            videoUrl: 'https://youtu.be/Hu4Yvq-g7_Y?si=Dkm4zy1jMySs_hKI',
            imagePath: 'assets/images/focus.jpeg',
          ),
          SizedBox(height: 25),
        ],
      ),
    ));
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
          'assets/images/wellnessguide.jpeg',
          fit: BoxFit.cover,
        ),
        titlePadding: const EdgeInsets.only(left: 15, bottom: 10),
        expandedTitleScale: 1.5,
        collapseMode: CollapseMode.parallax,
        title: const Text(
          'Wellness Guide',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
