import 'package:flutter/material.dart';
import 'package:news_rest/models/news_info.dart';
import 'package:news_rest/services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel>? _newsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _newsModel = APIManager().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
          child: FutureBuilder<NewsModel>(
              future: _newsModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles.length,
                      itemBuilder: (context, index) {
                        var article = snapshot.data!.articles[index];
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(article.urlToImage!)),
                              ),
                             SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      article.description!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // Text(article.publishedAt!)
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
