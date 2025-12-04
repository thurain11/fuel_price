import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/ob/fuel_retail_prices_list_ob.dart';

class FuelChartDynamicFL extends StatelessWidget {
  final Chart? chartData;

  const FuelChartDynamicFL({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    // No data ဆိုရင်
    if (chartData == null ||
        chartData!.labels == null ||
        chartData!.labels!.isEmpty ||
        chartData!.datasets == null ||
        chartData!.datasets!.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: Text(
            "No Data",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 30, bottom: 10),
      child: LineChart(
        mainData(context),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartData mainData(BuildContext context) {
    final lines = _buildLineBars();

    final double safeMinY = _getMinY();
    final double safeMaxY = _getMaxY();

    return LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            // interval: 100,
            getTitlesWidget: (value, meta) {
              // 1000 အထက်ဆို K နဲ့ ပြ
              if (value >= 1000) {
                return Text(
                  '${(value / 1000).toStringAsFixed(1)}K',
                  style: const TextStyle(fontSize: 11),
                );
              }
              return Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 11),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= chartData!.labels!.length) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ), // လိုအပ်ရင် adjust လုပ်ပါ
                child: Transform.rotate(
                  angle:
                      -45 * (3.14159 / 180), // -45 ဒီဂရီကို radian ပြောင်းခြင်း
                  child: Text(
                    chartData!.labels![index],
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(left: BorderSide(width: 0.4)),
      ),
      lineTouchData: LineTouchData(
        enabled: true,

        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((spotIndex) {
                return TouchedSpotIndicatorData(
                  // 1. Vertical Line (ဒေါင်လိုက်မျဉ်း) ပုံစံသတ်မှတ်ခြင်း
                  const FlLine(
                    color: Colors.grey, // မျဉ်းအရောင် (စိတ်ကြိုက်ပြင်ပါ)
                    strokeWidth: 1, // မျဉ်းအထူ (ဒီမှာ လျှော့ချပါ)
                    dashArray: [8, 4], // အစက်ပြမျဉ်း ပုံစံ
                  ),
                  // 2. Dot (အစက်) ပုံစံသတ်မှတ်ခြင်း (Touch လုပ်ရင်ပေါ်မယ့် အစက်)
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                          radius: 6, // အစက်အရွယ်အစား
                          color: barData.color ?? Colors.blue,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        ),
                  ),
                );
              }).toList();
            },

        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              Theme.of(context).primaryColor.withValues(alpha: 0.9),
          fitInsideHorizontally: true,
          showOnTopOfTheChartBoxArea: true,
          tooltipBorderRadius: BorderRadius.circular(8),
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,

          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final index = spot.x.toInt();
              final label = chartData!.labels![index];
              return LineTooltipItem(
                '$label - ${spot.y.toStringAsFixed(0)}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: lines,
      minX: 0,
      maxX: chartData!.labels!.isEmpty
          ? 0
          : (chartData!.labels!.length - 1).toDouble(),
      minY: safeMinY,
      maxY: safeMaxY > safeMinY ? safeMaxY : safeMinY + 10,
    );
  }

  List<LineChartBarData> _buildLineBars() {
    final colors = {
      '92 Ron': Colors.green.shade600,
      '95 Ron': Colors.orange.shade700,
      'HSD (500 ppm)': Colors.blue.shade700,
      'HSD (50 ppm)': Colors.purple.shade600,
      'HSD (10 ppm)': Colors.red.shade700,
      'MOPS (92 Ron)': Colors.blue.shade700,
      'MOPS (95 Ron)': Colors.purple.shade600,
      'MOPS (10 ppm)': Colors.red.shade700,
    };

    return chartData!.datasets!.entries.map((entry) {
      final String name = entry.key;
      final List<num> values = entry.value;

      final spots = values.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value.toDouble());
      }).toList();

      return LineChartBarData(
        spots: spots,
        isCurved: true,
        barWidth: 1.5,
        color: colors[name] ?? Colors.grey,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        // curveSmoothness: 0.9,
        isStrokeCapRound: true,
        isStrokeJoinRound: true,
      );
    }).toList();
  }

  double _getMinY() {
    num min = double.infinity;
    for (var list in chartData!.datasets!.values) {
      for (var v in list) {
        if (v < min) min = v;
      }
    }
    return (min == double.infinity)
        ? 0
        : (min.toDouble() * 0.95).floorToDouble();
  }

  double _getMaxY() {
    num max = -double.infinity;
    for (var list in chartData!.datasets!.values) {
      for (var v in list) {
        if (v > max) max = v;
      }
    }
    return (max == -double.infinity)
        ? 100
        : (max.toDouble() * 1.05).ceilToDouble();
  }
}
