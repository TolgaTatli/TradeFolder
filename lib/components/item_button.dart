import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tradingfolder/pages/graphic_page.dart';
import 'package:tradingfolder/yahoo_finance_data.dart';

// ignore: must_be_immutable
class ItemButton extends StatelessWidget {
  final String crypto;
  final Map<String, dynamic> logos;

  ItemButton({
    super.key,
    required this.crypto,
    required this.logos,
  });

  PriceController priceController = PriceController();

  List<double> chart = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white70,
          width: 1.2,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GraphicsPage(
                ticker: crypto,
                chartType: "1 DAY",
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    CachedNetworkImage(
                      imageUrl: logos[crypto],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                Text(
                  crypto,
                  style: TextStyle(
                    color: Color(
                      int.parse("#FFFFFF".substring(1, 7), radix: 16) +
                          0xFF000000,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder(
                  future: priceController.getPriceOneDay(crypto),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      chart = snapshot.data!;
                      double? currentPrice = snapshot.data!.last.toDouble();
                      double? previousPrice = snapshot.data!
                          .elementAt(snapshot.data!.length - 2)
                          .toDouble();
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: currentPrice > previousPrice
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${currentPrice.toStringAsFixed(2)} \$",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.redAccent,
                        ),
                        child: const Text(
                          "Error",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.transparent,
                        ),
                        child: const CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
