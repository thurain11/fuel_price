import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FuelChartDynamic extends StatelessWidget {
  final Map<String, List<double>> prices;
  final List<String> dateLabels;
  // Example:
  // ["21 Jan", "22 Jan", "23 Jan", "24 Jan", "25 Jan"]

  const FuelChartDynamic({
    super.key,
    required this.prices,
    required this.dateLabels,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: const Legend(isVisible: true, position: LegendPosition.top),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        // autoScrollingDelta: 4,
      ),
      primaryYAxis: NumericAxis(),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: _buildSeries(),
    );
  }

  List<CartesianSeries<dynamic, dynamic>> _buildSeries() {
    return prices.entries.map((entry) {
      final values = entry.value;

      return LineSeries<_Point, String>(
        name: entry.key,
        dataSource: List.generate(
          values.length,
          (i) => _Point(dateLabels[i], values[i]),
        ),
        xValueMapper: (_Point p, _) => p.label,
        yValueMapper: (_Point p, _) => p.value,
        width: 2.5,
        markerSettings: const MarkerSettings(
          isVisible: true,
          height: 6,
          width: 6,
        ),
      );
    }).toList();
  }
}

class _Point {
  final String label;
  final double value;
  _Point(this.label, this.value);
}
