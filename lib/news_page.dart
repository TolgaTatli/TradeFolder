// news_page.dart
import 'package:flutter/material.dart';
import 'package:tradingfolder/components/news_item.dart';
import 'package:tradingfolder/news_api.dart';

class NewsPage extends StatefulWidget {
  final String ticker;
  final bool isNewsPageOpened;

  const NewsPage({super.key, required this.ticker, required this.isNewsPageOpened});

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
        padding: const EdgeInsets.only(top:16),
        itemCount: newsData!['headlines']!.length,
        itemBuilder: (context, index) {
          bool hasImage = newsData!['images']![index] != null;
          if (!hasImage) {
            return const SizedBox.shrink(); // This returns an empty widget
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.4,),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700,width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: NewsItem(
              image: newsData!['images']![index],
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
