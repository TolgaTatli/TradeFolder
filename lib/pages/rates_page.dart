// rates_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tradingfolder/components/prices_page.dart';
import 'package:tradingfolder/constants/tickers_list.dart';
import 'package:tradingfolder/news_page.dart';
import 'package:tradingfolder/pages/graphic_page.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({Key? key}) : super(key: key);

  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  List<String> list = [];
  String type = "Stocks";
  String screenType = "Market";

  @override
  void initState() {
    super.initState();
    list = tickersList;
    screenType = "Market";
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d').format(now);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list = tickersList;
                            type = "Stocks";
                            screenType = "Market";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                        ),
                        child: Text(
                          "Stocks",
                          style: TextStyle(
                            color:
                            type == "Stocks" ? Colors.white : Colors.grey,
                            fontSize: type == "Stocks" ? 40 : 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list = cryptoList;
                            type = "Cryptos";
                            screenType = "Market";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          "Cryptos",
                          style: TextStyle(
                            color:
                            type == "Cryptos" ? Colors.white : Colors.grey,
                            fontSize: type == "Cryptos" ? 40 : 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list = cryptoList;
                            type = "News";
                            screenType = "News";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 0)),
                        child: Text(
                          "News",
                          style: TextStyle(
                            color: type == "News" ? Colors.white : Colors.grey,
                            fontSize: type == "News" ? 40 : 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (screenType != "News")
                    Text(
                      screenType == "Market" ? formattedDate : "Daily News",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  screenType == "Market"
                      ? Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 15),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        style: TextStyle(color: Colors.grey[500]),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey[900],
                              letterSpacing: 2,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                          hintText: "Search in market",
                          fillColor: Colors.grey.shade800,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, style: BorderStyle.none),
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        onSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GraphicsPage(
                                ticker: value,
                                chartType: "1 DAY",
                                isNewsPageOpened: false,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                  Expanded(
                    child: screenType == "Market"
                        ? PricesPage(
                      cryptoList: list,
                      logos: logos,
                    )
                        : NewsPage(
                      ticker: "Stock Market",
                      isNewsPageOpened: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000),
    );
  }
}
