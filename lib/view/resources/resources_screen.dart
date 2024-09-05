import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/controller/api_bloc/api_bloc.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  String? selectedContent;

  @override
  void initState() {
    BlocProvider.of<APIBloc>(context).add(FetchPosts());
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
              if (state is APILoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final resource = state.posts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Positioned(
                                  right: 10,
                                  top: -5,
                                  child: Icon(
                                    CupertinoIcons.bookmark_fill,
                                    color: Appcolor.blue,
                                    size: 30,
                                  )),
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  ListTile(
                                    title: Text(
                                      resource['title'][0]
                                              .toString()
                                              .toUpperCase() +
                                          resource['title']
                                              .toString()
                                              .substring(1),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Appcolor.grey,
                                      ),
                                    ),
                                    subtitle: Text(resource['body']),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: state.posts.length,
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(),
                        Text('Loading...')
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (selectedContent != null)
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedContent = null;
                  });
                },
                child: Container(
                  color: Appcolor.grey.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedContent = null;
                                  });
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            Text(
                              selectedContent!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Appcolor.grey,
                                fontFamily: 'Georgia',
                                height: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
          'assets/images/wellnessguide.jpeg',
          fit: BoxFit.cover,
        ),
        titlePadding: const EdgeInsets.only(left: 15, bottom: 10),
        expandedTitleScale: 1.5,
        collapseMode: CollapseMode.parallax,
        title: const Text(
          'Resources',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
