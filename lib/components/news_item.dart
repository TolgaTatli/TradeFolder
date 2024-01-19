import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  final String image;
  final String headline;
  final String content;
  final String url;

  const NewsItem(
      {super.key,
      required this.image,
      required this.headline,
      required this.content,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tıklandığında alt pencereyi aç
        _launchURL(url);
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        color: Colors.white24,
        child: ListTile(
          title: Image.network(image, height: 100, fit: BoxFit.cover),
          subtitle: Column(
            children: [
              Text(
                headline,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                content,
                style: const TextStyle(fontSize: 12),
              ),
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
}
