import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyFuelChart extends StatelessWidget {
  final Map<String, List<double>> weeklyPrices;

  const WeeklyFuelChart({super.key, required this.weeklyPrices});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: _findMinY(),
        maxY: _findMaxY(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                // x-axis = 0..6 → Mon..Sun
                const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                if (value.toInt() >= 0 && value.toInt() <= 6) {
                  return Text(days[value.toInt()]);
                }
                return const SizedBox();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 100, // y-axis interval (price)
            ),
          ),
        ),
        lineBarsData: _buildLines(),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  List<LineChartBarData> _buildLines() {
    return weeklyPrices.entries.map((entry) {
      return LineChartBarData(
        spots: List.generate(
          entry.value.length,
          (i) => FlSpot(i.toDouble(), entry.value[i]),
        ),
        isCurved: true,
        barWidth: 3,
        dotData: const FlDotData(show: false),
      );
    }).toList();
  }

  double _findMinY() {
    return weeklyPrices.values.expand((e) => e).reduce((a, b) => a < b ? a : b);
  }

  double _findMaxY() {
    return weeklyPrices.values.expand((e) => e).reduce((a, b) => a > b ? a : b);
  }
}
