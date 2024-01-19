//9e0ae5b6be71463ab2a5c545696be2e5

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, List<dynamic>>?> getNewsForTicker(String ticker) async {
  // News API anahtarı
  String apiKey = '9e0ae5b6be71463ab2a5c545696be2e5';

  // News API endpoint'i
  String apiUrl = 'https://newsapi.org/v2/everything?q=$ticker&apiKey=$apiKey';

  // News API'ye GET isteği gönderme
  var response = await http.get(Uri.parse(apiUrl));

  // İsteğin başarılı olup olmadığını kontrol etme
  if (response.statusCode == 200) {
    // JSON verisini çözme
    Map<String, dynamic> data = jsonDecode(response.body);

    // Haber başlıklarını alma
    List<dynamic> articles = data['articles'];

    // Haber başlıklarını içeren bir map oluşturma
    Map<String, List<dynamic>> newsData = {
      'headlines': articles.map((article) => article['title']).toList(),
      'contents': articles.map((article) => article['content']).toList(),
      'images': articles.map((article) => article['urlToImage']).toList(),
      'links': articles.map((article) => article['url']).toList(),
    };

    return newsData;
  } else {
    // Hata durumunda null döndürme veya hata yönetimi yapma
    return null;
  }
}
