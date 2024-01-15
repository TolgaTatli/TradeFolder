import 'package:yahoofin/src/models/stock_chart.dart';
import 'package:yahoofin/yahoofin.dart';

class PriceController
{

  Future<List<double>> getPriceOneDay(String ticker) async {
    var yfin = YahooFin();

    StockHistory hist = yfin.initStockHistory(ticker: ticker);

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.oneMinute,
      period: StockRange.oneDay,
    );
    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.twoMinute,
        period: StockRange.oneYear,
      );
      print("2 DAKİKA");
    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fiveMinute,
        period: StockRange.oneDay,
      );
      print("5 DAKİKA");
    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fifteenMinute,
        period: StockRange.oneDay,
      );
      print("15 DAKİKA");

    }
    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.thirtyMinute,
        period: StockRange.oneDay,
      );
      print("30 DAKİKA");

    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.sixtyMinute,
        period: StockRange.oneDay,
      );
      print("60 DAKİKA");

    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.ninetyMinute,
        period: StockRange.oneDay,
      );
      print("90 DAKİKA");

    }


    List<double> data = chart.chartQuotes!.close!.map((value) => double.parse(value.toStringAsFixed(5))).toList();
    return data;
  }

  Future<List<double>> getPriceOneMonth(String ticker) async {
    var yfin = YahooFin();

    StockHistory hist = yfin.initStockHistory(ticker: ticker);
    StockInfo meta = await yfin.getStockInfo(ticker: ticker);

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.fifteenMinute,
      period: StockRange.oneMonth,
    );
    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.thirtyMinute,
        period: StockRange.oneMonth,
      );
      print("30 DAKİKA");
    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.sixtyMinute,
        period: StockRange.oneMonth,
      );
      print("60 DAKİKA");
    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.ninetyMinute,
        period: StockRange.oneMonth,
      );
      print("90 DAKİKA");

    }
    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneDay,
        period: StockRange.oneMonth,
      );
      print("1 Gün");

    }

    if(chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fiveDay,
        period: StockRange.oneMonth,
      );
      print("5 Gün");
    }

    List<double> data = chart.chartQuotes!.close!.map((value) => double.parse(value.toStringAsFixed(5))).toList();
    return data;
  }

  Future<List<double>> getPriceOneYear(String ticker) async {
    var yfin = YahooFin();

    StockHistory hist = yfin.initStockHistory(ticker: ticker);
    StockInfo meta = await yfin.getStockInfo(ticker: ticker);

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.oneDay,
      period: StockRange.oneYear,
    );

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fiveDay,
        period: StockRange.oneYear,
      );
      print("5 Gün");
    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneWeek,
        period: StockRange.oneYear,
      );
      print("1 Hafta DAKİKA");
    }

    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneMonth,
        period: StockRange.oneYear,
      );
      print("1 Ay");

    }
    if(chart.chartQuotes == null)
    {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.threeMonth,
        period: StockRange.oneYear,
      );
      print("3 Ay");

    }

    List<double> data = chart.chartQuotes!.close!.map((value) => double.parse(value.toStringAsFixed(5))).toList();
    return data;
  }

}