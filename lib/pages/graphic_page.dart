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
  const GraphicsPage({super.key, required this.chartType, required this.ticker,required this.isNewsPageOpened,});

  @override
  _GraphicsPageState createState() =>
      _GraphicsPageState(ticker: ticker, chartType: chartType,isNewsPageOpened:isNewsPageOpened);
}

class _GraphicsPageState extends State<GraphicsPage> {
  String chartType;
  String ticker;
  bool isNewsPageOpened;
  List<String> timeLabels = [];
  PriceController priceController = PriceController();

  _GraphicsPageState({required this.chartType, required this.ticker, required this.isNewsPageOpened}) {
    DateTime now = DateTime.now();
    for (int i = data.length - 1; i >= 0; i--) {
      DateTime time = now.subtract(Duration(minutes: (data.length - 1 - i)));
      String formattedTime = "${time.hour}:${time.minute}";
      timeLabels.add(formattedTime);
    }
  }

  List<double> data = [0];

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
    } else if (chartType == "1 MONTH") {
      data = await priceController.getPriceOneMonth(ticker);
    } else if (chartType == "1 YEAR") {
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
        backgroundColor:
            Color(int.parse("#040D12".substring(1, 7), radix: 16) + 0xFF000000),
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
        padding: const EdgeInsets.all(16.0),
        color:
            Color(int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  backgroundColor: Color(
                      int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                          0xFF000000),
                  lineTouchData: const LineTouchData(),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    verticalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Colors.white,
                        strokeWidth: 0,
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
                    )),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
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
                          return const SizedBox
                              .shrink(); // boş bir widget döndür
                        },
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.black,
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
                      color: Colors.grey,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.4))
                              .toList(),
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                      isStrokeCapRound:
                          true,
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
                      backgroundColor: chartType == "1 DAY"
                          ? Color(
                              int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                                  0xFF000000)
                          : Color(
                              int.parse("#005B41".substring(1, 7), radix: 16) +
                                  0xFF000000)),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GraphicsPage(
                                  ticker: widget.ticker,
                              isNewsPageOpened: isNewsPageOpened,
                                  chartType: "1 DAY",
                                )));
                  },
                  child: const Text(
                    "DAILY",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: chartType == "1 MONTH"
                          ? Color(
                              int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                                  0xFF000000)
                          : Color(
                              int.parse("#005B41".substring(1, 7), radix: 16) +
                                  0xFF000000)),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GraphicsPage(
                                  ticker: widget.ticker,
                                  chartType: "1 MONTH", isNewsPageOpened: isNewsPageOpened,
                                )));
                  },
                  child: const Text(
                    "MONTHLY",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: chartType == "1 YEAR"
                          ? Color(
                              int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                                  0xFF000000)
                          : Color(
                              int.parse("#005B41".substring(1, 7), radix: 16) +
                                  0xFF000000)),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GraphicsPage(
                                  ticker: widget.ticker,
                                  isNewsPageOpened: isNewsPageOpened,
                                  chartType: "1 YEAR",
                                )));
                  },
                  child: const Text(
                    "YEARLY",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Current Value: ${data.last} \$",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                      int.parse("#0F0F0F".substring(1, 7), radix: 16) +
                          0xFF000000)),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsPage(
                      ticker: ticker, isNewsPageOpened: isNewsPageOpened,
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
                    width: 8,
                  ),
                  Text(
                    "Related News",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
