import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_api/helper/apis.dart';
import 'package:news_api/helper/color.dart';
import 'package:news_api/helper/ui_helper.dart';
import 'package:news_api/screens/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsChannelsList {
  cnn,
  news24,
  newsweek,
  polygon,
  bbcnews,
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "cnn";
  NewsChannelsList? selectedItem;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height * 1;
    var width = MediaQuery.sizeOf(context).width * 1;
    var format = DateFormat('MMMM dd, yyyy');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "News",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(
                builder: (context) {
                  return const CategoryScreen();
                },
              ));
            },
            icon: Image.asset(
              "images/category_icon.png",
              height: 20,
              width: 20,
            )),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.drag_indicator_outlined,
              color: black,
            ),
            initialValue: selectedItem,
            onSelected: (NewsChannelsList item) {
              if (NewsChannelsList.cnn.name == item.name) {
                name = "cnn";
              }
              if (NewsChannelsList.news24.name == item.name) {
                name = "news24";
              }
              if (NewsChannelsList.newsweek.name == item.name) {
                name = "newsweek";
              }
              if (NewsChannelsList.polygon.name == item.name) {
                name = "polygon";
              }
              if (NewsChannelsList.bbcnews.name == item.name) {
                name = "bbc-news";
              }
              setState(() {
                selectedItem = item;
              });
            },
            itemBuilder: (context) {
              return <PopupMenuEntry<NewsChannelsList>>[
                const PopupMenuItem<NewsChannelsList>(
                  value: NewsChannelsList.cnn,
                  child: Text("CNN"),
                ),
                const PopupMenuItem<NewsChannelsList>(
                  value: NewsChannelsList.news24,
                  child: Text("News 24"),
                ),
                const PopupMenuItem<NewsChannelsList>(
                  value: NewsChannelsList.newsweek,
                  child: Text("Newsweek"),
                ),
                const PopupMenuItem<NewsChannelsList>(
                  value: NewsChannelsList.polygon,
                  child: Text("Polygon"),
                ),
                const PopupMenuItem<NewsChannelsList>(
                  value: NewsChannelsList.bbcnews,
                  child: Text("BBC-News"),
                ),
              ];
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            // color: gray151E27,
            child: FutureBuilder(
              future: HeadlinesApi.fetchNewsChannelHeadlineApi(name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: blue,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles[index].publishedAt
                          .toString());
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * .6,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * .02),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  snapshot.data!.articles[index].urlToImage,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      'https://demofree.sirv.com/nope-not-here.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                color: white,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  height: height * .25,
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * .7,
                                        child: Text(
                                          snapshot.data!.articles[index].title
                                              .toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: width * .7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles[index]
                                                .source.name
                                                .toString()),
                                            Text(format.format(dateTime)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // verticalSpaceMedium,
          // FutureBuilder(
          //   future: HeadlinesApi.fetchCategoryApi("general"),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: SpinKitCircle(
          //           size: 50,
          //           color: blue,
          //         ),
          //       );
          //     } else if (!snapshot.hasData) {
          //       return const Center(
          //         child: SpinKitCircle(
          //           size: 50,
          //           color: blue,
          //         ),
          //       );
          //     } else {
          //       return ListView.builder(
          //         scrollDirection: Axis.vertical,
          //         itemCount: snapshot.data!.articles.length,
          //         itemBuilder: (context, index) {
          //           DateTime dateTime = DateTime.parse(
          //               snapshot.data!.articles[index].publishedAt.toString());
          //           return Padding(
          //             padding: const EdgeInsets.only(bottom: 12),
          //             child: Row(
          //               children: [
          //                 Container(
          //                   height: height * .2,
          //                   width: width * .35,
          //                   padding:
          //                       EdgeInsets.symmetric(horizontal: height * .02),
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(15),
          //                     child: Image.network(
          //                       snapshot.data!.articles[index].urlToImage,
          //                       errorBuilder: (context, error, stackTrace) {
          //                         return Image.network(
          //                           'https://demofree.sirv.com/nope-not-here.jpg',
          //                           fit: BoxFit.cover,
          //                         );
          //                       },
          //                       fit: BoxFit.fill,
          //                     ),
          //                   ),
          //                 ),
          //                 Expanded(
          //                   child: SizedBox(
          //                     height: height * .2,
          //                     child: Column(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         SizedBox(
          //                           width: width * .6,
          //                           child: Text(
          //                             snapshot.data!.articles[index].title
          //                                 .toString(),
          //                             maxLines: 3,
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           width: width * .6,
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(snapshot
          //                                   .data!.articles[index].source.name
          //                                   .toString()),
          //                               Text(format.format(dateTime)),
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: black,
  size: 25,
);
