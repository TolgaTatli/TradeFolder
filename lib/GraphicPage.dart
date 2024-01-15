import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tradingfolder/YFinanceData.dart';
import 'package:yahoofin/yahoofin.dart';

//Color(int.parse("#007008".substring(1, 7), radix: 16) + 0xFF000000)

class GraphicsPage extends StatefulWidget {
  String chartType;
  String ticker;
  GraphicsPage({required this.chartType, required this.ticker});

  @override
  _GraphicsPageState createState() => _GraphicsPageState(ticker: ticker, chartType: chartType);
}

class _GraphicsPageState extends State<GraphicsPage> {
  String chartType;
  String ticker;
  List<String> timeLabels = [];
  PriceController priceController = PriceController();

  _GraphicsPageState({required this.chartType, required this.ticker}) {
    DateTime now = DateTime.now();
    for (int i = data.length - 1; i >= 0; i--) {
      DateTime time = now.subtract(Duration(minutes: (data.length - 1 - i)));
      String formattedTime = "${time.hour}:${time.minute}";
      timeLabels.add(formattedTime);
    }
  }

  List<double> data = [0];
  /*List<Color> gradientColors = [
    Color(int.parse("#CD1818".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#9F73AB".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#5C469C".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#2E8A99".substring(1, 7), radix: 16) + 0xFF000000),
  ];*/

  List<Color> gradientColors = [
    Color(int.parse("#27374D".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#526D82".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#9DB2BF".substring(1, 7), radix: 16) + 0xFF000000),
    Color(int.parse("#DDE6ED".substring(1, 7), radix: 16) + 0xFF000000),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChart();
  }

  Future<void> getChart() async
  {
    if (chartType == "1 DAY") {
      data = await priceController.getPriceOneDay(ticker);
    }
    else if (chartType == "1 MONTH") {
      data = await priceController.getPriceOneMonth(ticker);
    }
    else if (chartType == "1 YEAR") {
      data = await priceController.getPriceOneYear(ticker);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ticker + " Grafiği",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(int.parse("#040D12".substring(1, 7), radix: 16) + 0xFF000000),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              child: LineChart(
                LineChartData(
                  backgroundColor: Color(int.parse("#0F0F0F".substring(1, 7), radix: 16) + 0xFF000000),
                  lineTouchData: LineTouchData(),
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
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false,)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,),),
                    topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(
                      getTitlesWidget: (value, _) {
                        int index = value.toInt();
                        if (index >= 0 && index < timeLabels.length) {
                          return Text(
                            timeLabels[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return SizedBox.shrink(); // boş bir widget döndür
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
                      dotData: FlDotData(show: false),
                      // Noktaları gizle
                      isStrokeCapRound: true, // Noktaları daha düzgün göstermek için
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: chartType == "1 DAY"
                          ? Color(int.parse("#0F0F0F".substring(1, 7), radix: 16) + 0xFF000000)
                          : Color(int.parse("#005B41".substring(1, 7), radix: 16) + 0xFF000000)),
                  onPressed: () async
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            GraphicsPage(
                              ticker: widget.ticker, chartType: "1 DAY",)));
                  },
                  child: Text("GÜNLÜK", style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: chartType == "1 MONTH"
                          ? Color(int.parse("#0F0F0F".substring(1, 7), radix: 16) + 0xFF000000)
                          : Color(int.parse("#005B41".substring(1, 7), radix: 16) + 0xFF000000)),
                  onPressed: () async
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            GraphicsPage(
                              ticker: widget.ticker, chartType: "1 MONTH",)));
                  },
                  child: Text("AYLIK", style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: chartType == "1 YEAR"
                          ? Color(int.parse("#0F0F0F".substring(1, 7), radix: 16) + 0xFF000000)
                          : Color(int.parse("#005B41".substring(1, 7), radix: 16) + 0xFF000000)),
                  onPressed: () async
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            GraphicsPage(
                              ticker: widget.ticker, chartType: "1 YEAR",)));
                  },
                  child: Text("YILLIK", style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text("Anlık Değer: " + data.last.toString() + " USD",
              style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 15),),
          ],
        ),
      ),
      backgroundColor: Color(
          int.parse("#232D3F".substring(1, 7), radix: 16) + 0xFF000000),
    );
  }
}