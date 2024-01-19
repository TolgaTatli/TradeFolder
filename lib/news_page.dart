// news_page.dart
import 'package:flutter/material.dart';
import 'package:tradingfolder/components/news_item.dart';
import 'package:tradingfolder/news_api.dart';

class NewsPage extends StatefulWidget {
  final String ticker;
  final bool isNewsPageOpened;

  const NewsPage({Key? key, required this.ticker, required this.isNewsPageOpened}) : super(key: key);

  @override
  State<NewsPage> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  Map<String, List<dynamic>>? newsData;

  @override
  void initState() {
    super.initState();
    _loadNewsData();
  }

  Future<void> _loadNewsData() async {
    newsData = await getNewsForTicker(widget.ticker);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isNewsPageOpened ? null : AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "${widget.ticker} NEWS",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: newsData != null
          ? ListView.builder(
        itemCount: newsData!['headlines']!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.4,),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(1.1),
            ),
            child: NewsItem(
              image: newsData!['images']![index] ??
                  "https://www.shutterstock.com/image-photo/dark-concrete-wall-floor-background-600nw-1937061217.jpg",
              headline: newsData!['headlines']![index],
              content: newsData!['contents']![index],
              url: newsData!['links']![index],
            ),
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
