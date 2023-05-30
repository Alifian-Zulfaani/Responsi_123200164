import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'news_detail_page.dart';

class NewsListPage extends StatefulWidget {
  String kategori;
  NewsListPage({Key? key, required this.kategori}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<Map<String, dynamic>> home = [];
  bool load = false;

  @override
  void initState() {
    super.initState();
    fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url = "https://api-berita-indonesia.vercel.app/republika/${widget.kategori}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> items = data['data']['posts'];

      setState(() {
        home = items
            .map((item) => {
          'title': item['title'],
          'thumbnail': item['thumbnail'],
          'description': item['description'],
          'link': item['link'],
          'pubDate': item['pubDate'],
        })
            .toList();
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPUBLIKA ${widget.kategori.toUpperCase()}"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {
    var title = item['title'];
    var thumbnail = item['thumbnail'];
    var description = item['description'];
    var link = item['link'];
    var pubDate = item['pubDate'];

    return Card(
        margin: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsDetailPage(
                title: title,
                thumbnail: thumbnail,
                description: description,
                link: link,
                pubDate: pubDate,
              ))),
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
              child: Card(
                child: Row(
                  children: [
                    Expanded(
                      flex: 66,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 50,
                            child: Text(
                              title.toString(),
                              style:
                              const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 33,
                      child: Image.network(
                        thumbnail.toString(),
                        width: 150,
                        height: 350,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ));
  }
}