import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/controller/api_bloc/api_bloc.dart';
import 'package:mindglowequinox/utils/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    BlocProvider.of<APIBloc>(context).add(FetchComments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          BlocBuilder<APIBloc, APIState>(
            builder: (context, state) {
              if (state is APILoading) {
                return const SliverFillRemaining(
                  child: Center(child: CupertinoActivityIndicator()),
                );
              } else if (state is APILoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final comment = state.comments[index];
                      final String email = comment['email'];
                      final String title = comment['name'];
                      final String body = comment['body'];
                      final Color avatarColor =
                          generateRandomColor().withAlpha(100);

                      return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: avatarColor,
                                        child: Text(
                                          email[0].toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(email.split('@').first,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    title[0].toUpperCase() +
                                        title.substring(1).toLowerCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(body[0].toUpperCase() +
                                      body.substring(1).toLowerCase()),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.heart,
                                      color: CupertinoColors.activeBlue,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.conversation_bubble,
                                      color: CupertinoColors.activeBlue,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.share,
                                      color: CupertinoColors.activeBlue,
                                    )),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                    childCount: state.comments.length,
                  ),
                );
              } else if (state is APIError) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Something went wrong')),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: Text('No Data available.')),
              );
            },
          ),
        ],
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
        collapseMode: CollapseMode.parallax,
        title: const Text(
          'Community',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
