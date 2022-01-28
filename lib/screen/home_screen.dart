import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/provider/news_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News Show'),
          backgroundColor: Colors.purple,
        ),
        body: Consumer(builder: (context, ref, child) {
          final newsData = ref.watch(newsProvider);
          return newsData.when(
              data: (data) {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        padding: EdgeInsets.all(5),
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                if (data[index].media != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Image.network(
                                      data[index].media!,
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: 170,
                                    ),
                                  ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (data[index].title != null)
                                        Text(
                                          data[index].title!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      if (data[index].summary != null)
                                        Text(
                                          data[index].summary!,
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      if (data[index].publishedData != null)
                                        Text(data[index].publishedData!),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      if (data[index].author != null)
                                        Container(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              '- ' + data[index].author!,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              error: (err, stack) => Text('$err'),
              loading: () => Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ));
        }));
  }
}
