import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/providers/tab_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class TabWidget extends StatelessWidget {
 final String query;
 TabWidget(this.query);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final newsData = ref.watch(tabNewsProvider(query));
          return newsData.length == 0 ? Container() :  Container(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: newsData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                     // Get.to(() => WebDetailPage(newsData[index].link!), transition: Transition.leftToRight);
                    },
                    child: Container(
                      height: 170,
                      width: 350,
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                          'https://asvs.in/wp-content/uploads/2017/08/dummy.png'),
                                  imageUrl: newsData[index].media! == ''
                                      ? 'https://asvs.in/wp-content/uploads/2017/08/dummy.png'
                                      : newsData[index].media!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 120,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(newsData[index].title!,
                                      style: TextStyle(fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 5,),
                                    Text(newsData[index].summary!,
                                      style: TextStyle(color: Colors.blueGrey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,),
                                    SizedBox(height: 2,),
                                    Text(newsData[index].publishedDate!),
                                    SizedBox(height: 2,),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          '- ' + newsData[index].author!,
                                          overflow: TextOverflow.ellipsis,)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}
