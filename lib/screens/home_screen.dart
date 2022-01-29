import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/providers/news_provider.dart';
import 'package:flutter_news/screens/web_view_page.dart';
import 'package:flutter_news/widgets/tab_bar_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';




class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('News Show'),
            backgroundColor: Colors.purple,
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 17),
                indicatorColor: Colors.amberAccent,
                tabs: [
                  Tab(
                    text: 'Hollywood',
                  ),
                  Tab(
                    text: 'Game',
                  ),
                ]
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 265,
                child: TabBarView(
                    children: [
                     TabWidget('hollywood'),
                     TabWidget('game'),
                ]),
              ),
              SizedBox(height: 5,),
              Consumer(
                  builder: (context, ref, child) {
                    final newsData = ref.watch(newsProvider);
                    return newsData.length == 0 ? Center(child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),) : newsData[0].title == 'not found' ? Center(child: Text('No matches for your search.', style: TextStyle(fontSize: 22),))
                        :  Container(
                      height: 400,
                      child: ListView.builder(
                          itemCount: newsData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                              Get.to(() => WebDetailPage(newsData[index].link!), transition: Transition.leftToRight);
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                padding: EdgeInsets.all(5),
                                child: Card(
                                  elevation: 7,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
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
                                            height: 200,
                                            width: 170,
                                          ),
                                        ),
                                        SizedBox(width: 12,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(newsData[index].title!,
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,),
                                              SizedBox(height: 5,),
                                              Text(newsData[index].summary!,
                                                style: TextStyle(color: Colors.blueGrey),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,),
                                              SizedBox(height: 5,),
                                              Text(newsData[index].publishedDate!),
                                              SizedBox(height: 5,),
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
              ),
            ],
          ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
           if(index == 1){
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Consumer(
              builder: (context, ref, child) => TextFormField(
                onFieldSubmitted: (val){
                  Navigator.of(context).pop();
                 ref.read(newsProvider.notifier).updateData(val.trim());
                },
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Search for news',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),
            ),
          ),
        );
      });
           }
          },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search'
              ),
            ]
        ),
      ),
    );
  }
}