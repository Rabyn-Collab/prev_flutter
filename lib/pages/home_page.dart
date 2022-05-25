import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:project_start/api.dart';
import 'package:project_start/pages/detail_page.dart';
import 'package:project_start/provider/movie_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';




class HomePage extends StatelessWidget {


  final searchController = TextEditingController();
 late bool isConnected;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        flexibleSpace: Image.network('https://play-lh.googleusercontent.com/IO3niAyss5tFXAQP176P0Jk5rg_A_hfKPNqzC4gb15WjLPjo5I-f7oIZ9Dqxw2wPBAg',
        fit: BoxFit.cover,
        ),
      ),
        body: OfflineBuilder(
          child: Container(),
          connectivityBuilder: (context, ConnectivityResult connectivity,  child,) {
            if(connectivity == ConnectivityResult.none){
              isConnected = false;
            }else{
              isConnected = true;
            }
            return Consumer(
                builder: (context, ref, child) {
                  final data = ref.watch(movieProvider);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                onFieldSubmitted: (val) {
                                  ref.read(movieProvider.notifier).searchMovie(
                                      val);
                                  searchController.clear();
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    hintText: 'search movies',
                                    border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            PopupMenuButton(
                                onSelected: (val) {
                                  ref.read(movieProvider.notifier)
                                      .updateCategory(val as String);
                                },
                                icon: Icon(Icons.menu),
                                itemBuilder: (context) =>
                                [
                                  PopupMenuItem(
                                    child: Text('Popular'),
                                    value: Api.popularMovie,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Top_Rated'),
                                    value: Api.topRated,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Up Coming'),
                                    value: Api.upcoming,
                                  ),
                                ]
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                      data.apiPath == Api.popularMovie ? Expanded(
                        child: Container(
                          child: data.movies.isEmpty ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ) : data.movies[0].title == 'no-data' ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Try using another keyword'),
                                ElevatedButton(
                                    onPressed: () {
                                      ref.refresh(movieProvider.notifier);
                                    }, child: Text('Refresh'))
                              ],
                            ),
                          ) :
                          NotificationListener(
                            onNotification: (onNotification) {
                              if (onNotification is ScrollEndNotification) {
                                final before = onNotification.metrics
                                    .extentBefore;
                                final max = onNotification.metrics
                                    .maxScrollExtent;
                                if (before == max) {
                                  // ref.read(movieProvider.notifier).loadMore();
                                }
                              }
                              return true;
                            },
                            child: GridView.builder(
                                itemCount: data.movies.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 2 / 3,
                                ),
                                itemBuilder: (context, index) {
                                  final movie = data.movies[index];
                                  return InkWell(
                                    onTap: () {
                                      if(isConnected == false){
                                        Get.defaultDialog(
                                          title: 'No connection',
                                          content: Icon(Icons.wifi_off)
                                        );
                                      }else{
                                        Get.to(() => DetailPage(movie),
                                            transition: Transition.leftToRight);
                                      }

                                    },
                                    child: CachedNetworkImage(
                                        errorWidget: (ctx, st, d) {
                                          return Image.asset(
                                              'assets/images/noImage.jpg');
                                        },
                                        imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie
                                            .poster_path}'),
                                  );
                                }
                            ),
                          ),
                        ),
                      ):   isConnected ?   Expanded(
                          child: Container(
                            child: data.movies.isEmpty ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.purple,
                              ),
                            ) : data.movies[0].title == 'no-data' ? Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Try using another keyword'),
                                  ElevatedButton(
                                      onPressed: () {
                                        ref.refresh(movieProvider.notifier);
                                      }, child: Text('Refresh'))
                                ],
                              ),
                            ) :
                            NotificationListener(
                              onNotification: (onNotification) {
                                if (onNotification is ScrollEndNotification) {
                                  final before = onNotification.metrics
                                      .extentBefore;
                                  final max = onNotification.metrics
                                      .maxScrollExtent;
                                  if (before == max) {
                                   // ref.read(movieProvider.notifier).loadMore();
                                  }
                                }
                                return true;
                              },
                              child: GridView.builder(
                                  itemCount: data.movies.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 2 / 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    final movie = data.movies[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => DetailPage(movie),
                                            transition: Transition.leftToRight);
                                      },
                                      child: CachedNetworkImage(
                                          errorWidget: (ctx, st, d) {
                                            return Image.asset(
                                                'assets/images/noImage.jpg');
                                          },
                                          imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie
                                              .poster_path}'),
                                    );
                                  }
                              ),
                            ),
                          ),
                        ) :  Center(child: Text('no connection', style: TextStyle(fontSize: 40),))
                      ],
                    ),
                  );
                }
            ) ;
          }
        )
    );
  }
}
