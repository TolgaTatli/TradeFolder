import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tradingfolder/news_page.dart';
import 'package:tradingfolder/yahoo_finance_data.dart';
import 'package:yahoofin/yahoofin.dart';
import '../news_api.dart';

class GraphicsPage extends StatefulWidget {
  final String chartType;
  final String ticker;
  final bool isNewsPageOpened;

  const GraphicsPage({
    Key? key,
    required this.chartType,
    required this.ticker,
    required this.isNewsPageOpened,
  }) : super(key: key);

  @override
  _GraphicsPageState createState() => _GraphicsPageState(
    ticker: ticker,
    chartType: chartType,
    isNewsPageOpened: isNewsPageOpened,
  );
}

class _GraphicsPageState extends State<GraphicsPage> {
  String chartType;
  String ticker;
  bool isNewsPageOpened;
  List<String> timeLabels = [];
  PriceController priceController = PriceController();

  _GraphicsPageState({
    required this.chartType,
    required this.ticker,
    required this.isNewsPageOpened,
  }) {
    DateTime now = DateTime.now();
    for (int i = data.length - 1; i >= 0; i--) {
      DateTime time = now.subtract(Duration(minutes: (data.length - 1 - i)));
      String formattedTime = "${time.hour}:${time.minute}";
      timeLabels.add(formattedTime);
    }
  }

  List<double> data = [0];
  List<double> maxPrice = [0];
  List<double> minPrice= [0];

  List<Color> gradientColors = [
    Color(int.parse("#27374D".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#526D82".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#9DB2BF".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#DDE6ED".substring(1, 7), radix: 16) + 0xFF000000),
  ];

  @override
  void initState() {
    super.initState();
    priceController = PriceController();
    getChart();
  }

  Future<void> getChart() async {
    await getNewsForTicker("GOOGL");
    if (chartType == "1 DAY") {
      data = await priceController.getPriceOneDay(ticker);
      maxPrice = await priceController.getMaxOneDay(ticker);
      minPrice = await priceController.getMinOneDay(ticker);
      print(maxPrice);
      print(minPrice);
    } else if (chartType == "1 MONTH") {
      data = await priceController.getPriceOneMonth(ticker);
      maxPrice = await priceController.getMaxOneMonth(ticker);
      minPrice = await priceController.getMinOneMonth(ticker);
    } else if (chartType == "1 YEAR") {
      maxPrice = await priceController.getMaxOneYear(ticker);
      minPrice = await priceController.getMinOneYear(ticker);
      data = await priceController.getPriceOneYear(ticker);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ticker.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding:
        const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(gradient:LinearGradient(colors:  [Color.fromARGB(64, 46, 50, 70),Colors.black])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monetization_on_outlined,color: Colors.white,size: 32,),
                  SizedBox(width: 10,),
                  Text(
                    "${data.last}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 25,
                    ),
                  ),

                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),

            Expanded(

              child: LineChart(

                LineChartData(
                  backgroundColor: Colors.black,
                  lineTouchData: const LineTouchData(),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    verticalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Colors.white,
                        strokeWidth: 0.1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return const FlLine(
                        color: Colors.brown,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index >= 0 && index < timeLabels.length) {
                            return Text(
                              timeLabels[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.shade800,
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: data.length.toDouble() + 1,
                  minY: data.reduce((a, b) => a < b ? a : b).toDouble() -
                      data.last / 200,
                  maxY: data.reduce((a, b) => a > b ? a : b).toDouble() +
                      data.last / 200,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        data.length,
                            (index) =>
                            FlSpot(index.toDouble(), data[index].toDouble()),
                      ),
                      isCurved: true,
                      color: Colors.grey.shade500,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.5))
                              .toList(),
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                      isStrokeCapRound: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: chartType == "1 DAY"
                        ? Color(
                        int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                            0xFF000000)
                        : Colors.black12,
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GraphicsPage(
                          ticker: widget.ticker,
                          isNewsPageOpened: isNewsPageOpened,
                          chartType: "1 DAY",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "DAILY",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: chartType == "1 MONTH"
                        ? Color(
                        int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                            0xFF000000)
                        : Colors.black12,
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GraphicsPage(
                          ticker: widget.ticker,
                          chartType: "1 MONTH",
                          isNewsPageOpened: isNewsPageOpened,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "MONTHLY",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: chartType == "1 YEAR"
                        ? Color(
                        int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                            0xFF000000)
                        : Colors.black12,
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GraphicsPage(
                          ticker: widget.ticker,
                          isNewsPageOpened: isNewsPageOpened,
                          chartType: "1 YEAR",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "YEARLY",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height:
              20,
            ),
             Container(
               padding: EdgeInsets.all(14),
               decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red,Colors.black])),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Max - Min range:".toUpperCase(),style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade50,
                    letterSpacing: 3,
                    fontSize: 20,
                  ),),
                ],
                           ),
             ),

            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${minPrice.first} - ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),

                Text(
                  "\$${maxPrice.last}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),


              ],
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsPage(
                      ticker: ticker,
                      isNewsPageOpened: isNewsPageOpened,
                    ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.newspaper_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "RELATED NEWS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor:
      Color(int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000),
    );
  }
}
