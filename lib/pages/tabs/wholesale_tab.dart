import '../../global.dart';

class WholesaleTab extends StatefulWidget {
  const WholesaleTab({super.key});

  @override
  State<WholesaleTab> createState() => _WholesaleTabState();
}

class _WholesaleTabState extends State<WholesaleTab> {
  DateTime selectedDate = DateTime.now();

  void pickDate() async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: selectedDate,
    );
    if (d != null) {
      setState(() => selectedDate = d);
    }
  }

  String _month(int m) {
    const names = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return names[m];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        _buildFilterRow(),
        SizedBox(height: 8),
        _buildRetailFuelCard(
          date: DateTime.now(),
          prices: {
            "92 Ron": 2450.0,
            "95 Ron": 2550.0,
            "HSD(500 ppm)": 2380.0,
            "HSD(50 ppm)": 2480.0,
            "HSD(10 ppm)": 2480.0,
          },
        ),
        SizedBox(height: 10),

        SizedBox(
          height: 260,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.35)
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            // child: FuelChartDynamic(datasets: null, dateLabels: []),
          ),
        ),
      ],
    );
  }

  Widget _buildRetailFuelCard({
    required DateTime date,
    required Map<String, double> prices,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // final bool isToday = date.isSameDate(DateTime.now());

    Widget _fuelRow(String name, double price) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 3,
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: price.toStringAsFixed(0),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 15.5,
                      ),
                    ),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: "MMK/L",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Yangon",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 16, color: Colors.black38, thickness: 0.5),
          _fuelRow("92 Ron", prices["92 Ron"] ?? 0),
          _fuelRow("95 Ron", prices["95 Ron"] ?? 0),
          _fuelRow("HSD(500 ppm)", prices["HSD(500 ppm)"] ?? 0),
          _fuelRow("HSD(50 ppm)", prices["HSD(50 ppm)"] ?? 0),
          _fuelRow("HSD(10 ppm)", prices["HSD(10 ppm)"] ?? 0),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    "${selectedDate.day}, ${_month(selectedDate.month)} ${selectedDate.year}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              // TODO: City picker dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("City picker coming soon!")),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Row(
                children: [
                  Text(
                    "-- City --",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
