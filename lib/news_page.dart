import 'package:flutter/material.dart';
import 'package:tradingfolder/components/news_item.dart';
import 'package:tradingfolder/news_api.dart';

class NewsPage extends StatefulWidget {
  final String ticker;

  const NewsPage({super.key, required this.ticker});

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
    // Ticker ile haber verilerini al
    newsData = await getNewsForTicker(widget.ticker);

    // State'i güncelle
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 202, 214, 221), size: 30),
        centerTitle: true,
        title: Text(
          '${widget.ticker} NEWS',
          style: const TextStyle(
              color: Color.fromARGB(179, 230, 229, 229),
              letterSpacing: 4,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: newsData != null
          ? ListView.builder(
              itemCount: newsData!['headlines']!.length,
              itemBuilder: (context, index) {
                return NewsItem(
                  image: newsData!['images']![index] ??
                      "https://www.shutterstock.com/image-photo/dark-concrete-wall-floor-background-600nw-1937061217.jpg",
                  headline: newsData!['headlines']![index],
                  content: newsData!['contents']![index],
                  url: newsData!['links']![index],
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

void _showNewsDetails(
    BuildContext context, String image, String headline, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(image, width: 100, height: 100, fit: BoxFit.cover),
              const SizedBox(height: 8),
              Text(headline,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(content),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
