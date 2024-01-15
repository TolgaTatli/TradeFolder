import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tradingfolder/GraphicPage.dart';
import 'package:tradingfolder/YFinanceData.dart';
import 'package:yahoofin/yahoofin.dart';

class RatesPage extends StatefulWidget {
  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  // Değişkenler
  List<String> cryptoList = [
    "BTC-USD",
    "ETH-USD",
    "XRP-USD",
    "USDT-USD",
    "BNB-USD",
    "SOL-USD",
    "USDC-USD",
    "ADA-USD",
    "AVAX-USD",
    "DOGE-USD"
  ]; // Kripto paralar
  List<String> tickersList = [
    "AAPL",
    "GOOGL",
    "MSFT",
    "NVDA",
    "MARA",
    "TSLA",
    "AMD",
    "AAL",
    "MPW",
    "AMZN",
    "INTC",
    "BAC",
    "RIOT"
  ]; // Hisse senetleri
  Map<String, dynamic> logos = {
    "BTC-USD": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png",
    "ETH-USD": "https://cryptologos.cc/logos/ethereum-eth-logo.png",
    "XRP-USD": "https://cryptologos.cc/logos/xrp-xrp-logo.png",
    "USDT-USD": "https://cryptologos.cc/logos/tether-usdt-logo.png",
    "BNB-USD": "https://cryptologos.cc/logos/bnb-bnb-logo.png",
    "SOL-USD": "https://cryptologos.cc/logos/solana-sol-logo.png",
    "USDC-USD": "https://cryptologos.cc/logos/usd-coin-usdc-logo.png",
    "ADA-USD": "https://cryptologos.cc/logos/cardano-ada-logo.png",
    "AVAX-USD": "https://cryptologos.cc/logos/avalanche-avax-logo.png",
    "DOGE-USD": "https://altcoinsbox.com/wp-content/uploads/2023/01/dogecoin-logo.png",
    "AAPL": "https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png",
    "GOOGL": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    "MSFT": "https://companieslogo.com/img/orig/MSFT-a203b22d.png?t=1633073277",
    "NVDA": "https://www.pngmart.com/files/23/Nvidia-Logo-PNG-HD.png",
    "MARA": "https://logo.stocklight.com/NASDAQ/MARA_icon.png",
    "TSLA": "https://upload.wikimedia.org/wikipedia/commons/e/e8/Tesla_logo.png",
    "AMD": "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/133-amd-512.png",
    "AAL": "https://cdn.freebiesupply.com/logos/large/2x/aa-american-airlines-logo-png-transparent.png",
    "MPW": "https://upload.wikimedia.org/wikipedia/en/thumb/3/30/Medical_Properties_Trust_logo.svg/1200px-Medical_Properties_Trust_logo.svg.png",
    "AMZN": "https://companieslogo.com/img/orig/AMZN-e9f942e4.png?t=1632523695",
    "INTC": "https://assets.stickpng.com/images/58568d224f6ae202fedf2720.png",
    "BAC": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUIS6-N2HEsz_sc5n0cLb0Wxnz_AIziZ_IoT_Fe0yiAhqOqAE3nIl-TY4QaUlZbki0uuw&usqp=CAU",
    "RIOT": "https://media.baamboozle.com/uploads/images/1004947/1667457625_9636.png",
  };

  List<String> list = [];
  String type = "";

  late Color textColor;
  late Color buttonColor;

  @override
  void initState() {
    // TODO: implement initState
    list = cryptoList;
    textColor = Colors.indigoAccent;
    buttonColor =
        Color(int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TradeFolder",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(
            int.parse("#040D12".substring(1, 7), radix: 16) + 0xFF000000),
        actions: [
          IconButton(
              color: Color(int.parse("#232D3F".substring(1, 7), radix: 16) +
                  0xFF000000),
              style: IconButton.styleFrom(iconSize: 35),
              onPressed: () {
                setState(() {});
              }, icon: Icon(Icons.replay_circle_filled)),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(
                      int.parse("#040D12".substring(1, 7), radix: 16) +
                          0xFF000000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0),
                    ),),
                  onPressed: () {
                    setState(() {
                      type = "Cryptos";
                      list = cryptoList;
                      buttonColor = Color(int.parse("#232D3F".substring(1, 7),
                          radix: 16) + 0xFF000000);
                    });
                  },
                  child: Text("Kriptolar", style: TextStyle(color: Color(
                      int.parse("#FFFFFF".substring(1, 7), radix: 16) +
                          0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 2),),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(
                      int.parse("#040D12".substring(1, 7), radix: 16) +
                          0xFF000000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0),
                    ),),
                  onPressed: () {
                    setState(() {
                      type = "Tickers";
                      list = tickersList;
                      buttonColor = Color(int.parse("#232D3F".substring(1, 7),
                          radix: 16) + 0xFF000000);
                    });
                  },
                  child: Text("Hisse Senetleri", style: TextStyle(color: Color(
                      int.parse("#FFFFFF".substring(1, 7), radix: 16) +
                          0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: PricesPage(
              cryptoList: list, logos: logos, buttonColor: buttonColor,),
            // TODO: Seçilen sayfa widget'ını ekleyebilirsiniz.
          ),
        ],
      ),
      backgroundColor: Color(
          int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000),
    );
  }
}

class PricesPage extends StatelessWidget {
  final List<String> cryptoList;
  final Map<String, dynamic> logos;
  final Color buttonColor;

  PricesPage({required this.cryptoList, required this.logos, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        String crypto = cryptoList[index];
        // TODO: Her bir kripto için bir buton oluştur ve fiyat kısmını düzenle
        return ItemButton(crypto: crypto, logos: logos, buttonColor: buttonColor,);
      },
    );
  }
}

class ItemButton extends StatelessWidget {
  final String crypto;
  final Map<String, dynamic> logos;
  final Color buttonColor;

  ItemButton({required this.crypto, required this.logos, required this.buttonColor});

  PriceController priceController = PriceController();

  List<double> chart = [];

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              5.0),
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            GraphicsPage(ticker: crypto, chartType: "1 DAY",)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 8,),
                  CachedNetworkImage(
                    imageUrl: logos[crypto],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(height: 8,),
                ],
              ),
              Text(crypto, style: TextStyle(color: Color(
                  int.parse("#FFFFFF".substring(1, 7), radix: 16) + 0xFF000000),
                  fontWeight: FontWeight.bold),),
              FutureBuilder(
                future: priceController.getPriceOneDay(crypto),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    chart = snapshot.data!;
                    double? currentPrice = snapshot.data!.last.toDouble();
                    double? previousPrice = snapshot.data!
                        .elementAt(snapshot.data!.length - 2)
                        .toDouble(); // Örnek olarak aynı fiyatı varsayalım
                    return Row(
                      children: [
                        Text(currentPrice.toStringAsFixed(5),
                          style: TextStyle(color: currentPrice > previousPrice
                              ? Colors.green
                              : Colors.redAccent),),
                        Icon(
                          currentPrice > previousPrice
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: currentPrice > previousPrice
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("Error");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
          Divider(height: 1, thickness: 1, color: Colors.white,)
        ],
      ),
    );
  }
}
