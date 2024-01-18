import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tradingfolder/components/prices_page.dart';
import 'package:tradingfolder/constants/tickers_list.dart';
import 'package:tradingfolder/pages/graphic_page.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  List<String> list = [];
  String type = "";

  @override
  void initState() {
    super.initState();
    list = tickersList;
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
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list = tickersList;
                            type = "Stocks";
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
                            fontSize: type == "Stocks" ? 45 : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            list = cryptoList;
                            type = "Cryptos";
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
                            fontSize: type == "Cryptos" ? 45 : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 15),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        style: TextStyle(color: Colors.grey[500]),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          hintText: "Search in market",
                          fillColor: Colors.grey[800],
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        onSubmitted: (value)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GraphicsPage(
                                ticker: value,
                                chartType: "1 DAY",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: PricesPage(
                      cryptoList: list,
                      logos: logos,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor:
          Color(int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000),
    );
  }
}
