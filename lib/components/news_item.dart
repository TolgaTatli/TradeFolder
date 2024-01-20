import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  final String image;
  final String headline;
  final String content;
  final String url;
  final int maxTitleLength;
  final int maxContentLength;

  const NewsItem({
    super.key,
    required this.image,
    required this.headline,
    required this.content,
    required this.url,
    this.maxTitleLength = 28,
    this.maxContentLength = 100,
  });

  @override
  Widget build(BuildContext context) {
    String truncatedTitle = headline.length > maxTitleLength
        ? "${headline.substring(0, maxTitleLength)}..."
        : headline;

    String truncatedContent = content.length > maxContentLength
        ? "${content.substring(0, maxContentLength)}..."
        : content;

    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Card(
        margin: const EdgeInsets.all(1.0),
        color: Colors.black87,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncatedTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      truncatedContent,
                      style: TextStyle(fontSize: 13,color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      launch(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
