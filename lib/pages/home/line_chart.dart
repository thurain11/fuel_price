import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FuelPriceChart extends StatelessWidget {
  const FuelPriceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fuel Price Line Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            minY: 1500,
            maxY: 3000,
            gridData: const FlGridData(show: true),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.black26),
                bottom: BorderSide(color: Colors.black26),
              ),
            ),

            //===========================
            //   Axis Titles & Labels
            //===========================
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text("Jan");
                      case 1:
                        return const Text("Feb");
                      case 2:
                        return const Text("Mar");
                      case 3:
                        return const Text("Apr");
                    }
                    return const Text("");
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 45,
                  getTitlesWidget: (value, meta) => Text("${value.toInt()} Ks"),
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),

            //===========================
            //       LINE DATA
            //===========================
            lineBarsData: [
              // 92 Ron
              LineChartBarData(
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                spots: const [
                  FlSpot(0, 1850),
                  FlSpot(1, 1900),
                  FlSpot(2, 1920),
                  FlSpot(3, 1950),
                ],
              ),

              // 95 Ron
              LineChartBarData(
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                spots: const [
                  FlSpot(0, 1950),
                  FlSpot(1, 2000),
                  FlSpot(2, 2050),
                  FlSpot(3, 2100),
                ],
              ),

              // Diesel
              LineChartBarData(
                isCurved: true,
                color: Colors.orange,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                spots: const [
                  FlSpot(0, 1650),
                  FlSpot(1, 1700),
                  FlSpot(2, 1720),
                  FlSpot(3, 1750),
                ],
              ),

              // Premium Diesel
              LineChartBarData(
                isCurved: true,
                color: Colors.red,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                spots: const [
                  FlSpot(0, 1750),
                  FlSpot(1, 1800),
                  FlSpot(2, 1850),
                  FlSpot(3, 1900),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
