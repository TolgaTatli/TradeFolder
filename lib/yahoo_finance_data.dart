// ignore_for_file: file_names

import 'package:yahoofin/yahoofin.dart';

class PriceController {
  Future<List<double>> getPriceOneDay(String ticker) async {
    var yfin = YahooFin();

    StockHistory hist = yfin.initStockHistory(ticker: ticker);

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.oneMinute,
      period: StockRange.oneDay,
    );

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.twoMinute,
        period: StockRange.oneDay,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fiveMinute,
        period: StockRange.oneDay,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fifteenMinute,
        period: StockRange.oneDay,
      );
    }
    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.thirtyMinute,
        period: StockRange.oneDay,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.sixtyMinute,
        period: StockRange.oneDay,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.ninetyMinute,
        period: StockRange.oneDay,
      );
    }

    List<double> data = chart.chartQuotes!.close!
        .map((value) => double.parse(value.toStringAsFixed(2)))
        .toList();
    return data;
  }

  Future<List<double>> getPriceOneMonth(String ticker) async {
    var yfin = YahooFin();

    StockHistory hist = yfin.initStockHistory(ticker: ticker);

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.fifteenMinute,
      period: StockRange.oneMonth,
    );
    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.thirtyMinute,
        period: StockRange.oneMonth,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.sixtyMinute,
        period: StockRange.oneMonth,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.ninetyMinute,
        period: StockRange.oneMonth,
      );
    }
    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneDay,
        period: StockRange.oneMonth,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fiveDay,
        period: StockRange.oneMonth,
      );
    }

    List<double> data = chart.chartQuotes!.close!
        .map((value) => double.parse(value.toStringAsFixed(3)))
        .toList();
    return data;
  }

  Future<List<double>> getPriceOneYear(String ticker) async {
    var yfin = YahooFin();

    StockHistory hist = yfin.initStockHistory(ticker: ticker);

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.oneDay,
      period: StockRange.oneYear,
    );

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.fiveDay,
        period: StockRange.oneYear,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneWeek,
        period: StockRange.oneYear,
      );
    }

    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneMonth,
        period: StockRange.oneYear,
      );
    }
    if (chart.chartQuotes == null) {
      chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.threeMonth,
        period: StockRange.oneYear,
      );
    }

    List<double> data = chart.chartQuotes!.close!
        .map((value) => double.parse(value.toStringAsFixed(3)))
        .toList();
    return data;
  }
}
