import 'package:flutter/material.dart';
import 'package:tradingfolder/news_api.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  final String ticker;

  NewsPage({required this.ticker});

  @override
  _NewsPageState createState() => _NewsPageState();
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
        title: Text('${widget.ticker} News'),
      ),
      body: newsData != null
          ? ListView.builder(
        itemCount: newsData!['headlines']!.length,
        itemBuilder: (context, index) {
          return NewsItem(
            image: newsData!['images']![index ] != null ? newsData!['images']![index] : "https://www.shutterstock.com/image-photo/dark-concrete-wall-floor-background-600nw-1937061217.jpg",
            headline: newsData!['headlines']![index],
            content: newsData!['contents']![index],
            url: newsData!['links']![index],
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String image;
  final String headline;
  final String content;
  final String url;

  NewsItem({required this.image, required this.headline, required this.content, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tıklandığında alt pencereyi aç
        _launchURL(url);
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Image.network(image, height: 100, fit: BoxFit.cover),
          subtitle: Column(
            children: [
              Text(headline, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Text(content, style: TextStyle(fontSize: 12),),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showNewsDetails(BuildContext context, String image, String headline, String content) {
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
                SizedBox(height: 8),
                Text(headline, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
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
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
