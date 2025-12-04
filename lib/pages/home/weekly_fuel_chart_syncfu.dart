import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/ob/fuel_retail_prices_list_ob.dart';
import '../../global.dart';

class FuelChartDynamic extends StatelessWidget {
  final Chart? chartData; // ← အခု Chart? ပဲ လက်ခံတော့တယ်

  const FuelChartDynamic({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    // အကယ်၍ chart မရှိရင် ဘာမှ မပြဘူး (ဒါမှမဟုတ် placeholder)
    if (chartData == null ||
        chartData!.labels == null ||
        chartData!.labels!.isEmpty ||
        chartData!.datasets == null ||
        chartData!.datasets!.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text("No Data", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: SfCartesianChart(
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelRotation: 0,
          // arrangeByIndex: true,
          // maximumLabels: 3,
        ),

        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        series: _buildSeries(),
      ),
    );
  }

  List<LineSeries<_Point, String>> _buildSeries() {
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
      final name = entry.key;
      final values = entry.value.map((e) => e.toDouble()).toList();

      return LineSeries<_Point, String>(
        name: name,
        color: colors[name] ?? Colors.grey,
        width: 3,
        markerSettings: const MarkerSettings(
          isVisible: true,
          height: 8,
          width: 8,
        ),
        dataSource: List.generate(
          values.length,
          (i) => _Point(chartData!.labels![i], values[i]),
        ),
        xValueMapper: (p, _) => p.label,
        yValueMapper: (p, _) => p.value,
      );
    }).toList();
  }
}

class _Point {
  final String label;
  final num value;
  const _Point(this.label, this.value);
}
