import 'package:flutter/material.dart';
import 'package:tradingfolder/components/item_button.dart';

class PricesPage extends StatelessWidget {
  final List<String> cryptoList;
  final Map<String, dynamic> logos;

  const PricesPage({
    super.key,
    required this.cryptoList,
    required this.logos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        String crypto = cryptoList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 3),
          child: ItemButton(
            crypto: crypto,
            logos: logos,
          ),
        );
      },
    );
  }
}
