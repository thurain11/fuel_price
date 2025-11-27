import 'package:flutter/material.dart';
import 'package:market_price/core/utils/app_utils.dart';
import 'package:market_price/core/utils/context_ext.dart';
import 'package:market_price/pages/home/weekly_fuel_chart_syncfu.dart';

import 'line_chart.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class MarketTabsPage extends StatefulWidget {
  const MarketTabsPage({super.key});

  @override
  State<MarketTabsPage> createState() => _MarketTabsPageState();
}

class _MarketTabsPageState extends State<MarketTabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedDate = DateTime.now();

  final tabs = const [
    Tab(text: "Petrol (Wholesale)"),
    Tab(text: "Petrol (Retail)"),
    Tab(text: "MOPS Price"),
  ];

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
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void pickDate() async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: selectedDate,
    );
    if (d != null) {
      setState(() => selectedDate = d);
      // TODO: Fetch retail data again
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.MyAppBar(
        context: context,
        title: 'Market Watch',
        actions: [
          IconButton(
            onPressed: () {
              context.to(FuelPriceChart());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          // TabBar
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),
            tabs: tabs,
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ===== 1. Petrol (Retail) → Filter ပါတယ် =====
                Column(
                  children: [
                    _buildFilterRow(), // ← ဒီမှာ ထည့်လိုက်ပြီ
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

                    SizedBox(
                      height: 260,
                      child: Card(
                        child: FuelChartDynamic(
                          prices: {
                            "92 Ron": [2320, 2470, 2450, 2460, 2360],
                            "95 Ron": [2550, 2510, 2570, 2560, 2520],
                            "HSD 500ppm": [2310, 2350, 2330, 2410, 2390],
                            "HSD 50ppm": [2210, 2237, 2430, 2310, 2210],
                            "HSD 10ppm": [2210, 2390, 2350, 2380, 2410],
                          },

                          dateLabels: [
                            "25 Jan",
                            "26 Jan",
                            "27 Jan",
                            "28 Jan",
                            "29 Jan",
                          ],
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   height: 220,
                    //   child: WeeklyFuelChart(
                    //     weeklyPrices: {
                    //       "92 Ron": [2400, 2420, 2410, 2430, 2450, 2460, 2450],
                    //       "95 Ron": [2500, 2520, 2510, 2530, 2550, 2560, 2550],
                    //       "HSD(500 ppm)": [
                    //         2300,
                    //         2310,
                    //         2320,
                    //         2330,
                    //         2340,
                    //         2350,
                    //         2380,
                    //       ],
                    //     },
                    //   ),
                    // ),
                  ],
                ),

                Column(
                  children: [
                    _buildFilterRow(), // ← ဒီမှာ ထည့်လိုက်ပြီ
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

                    SizedBox(
                      height: 260,
                      child: Card(
                        child: FuelChartDynamic(
                          prices: {
                            "92 Ron": [2320, 2470, 2450, 2460, 2360],
                            "95 Ron": [2550, 2510, 2570, 2560, 2520],
                            "HSD 500ppm": [2310, 2350, 2330, 2410, 2390],
                            "HSD 50ppm": [2210, 2237, 2430, 2310, 2210],
                            "HSD 10ppm": [2210, 2390, 2350, 2380, 2410],
                          },

                          dateLabels: [
                            "25 Jan",
                            "26 Jan",
                            "27 Jan",
                            "28 Jan",
                            "29 Jan",
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ===== 3. MOPS Price =====
                Column(
                  children: [
                    _buildFilterRowMops(), // ← ဒီမှာ ထည့်လိုက်ပြီ
                    _mopsCard(
                      date: DateTime.now(),
                      prices: {
                        "Mops(92 Ron)": 78.30,
                        "Mops(95 Ron)": 81.16,
                        "Mops(10 ppm)": 86.30,
                      },
                    ),

                    SizedBox(
                      height: 260,
                      child: Card(
                        child: FuelChartDynamic(
                          prices: {
                            "Mops(92 Ron)": [78.30, 77.20, 78.90, 76.50, 77.20],
                            "Mops(95 Ron)": [81.16, 82.20, 83.90, 81.50, 82.20],
                            "Mops(10 ppm)": [86.30, 87.20, 85.90, 84.50, 88.20],
                          },

                          dateLabels: [
                            "25 Jan",
                            "26 Jan",
                            "27 Jan",
                            "28 Jan",
                            "29 Jan",
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Retail Card (အရင်အတိုင်း လှလှပပ) =====
  Widget _buildRetailFuelCard({
    required DateTime date,
    required Map<String, double> prices,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // final bool isToday = date.isSameDate(DateTime.now());

    // String formatDate() {
    //   const months = [
    //     "",
    //     "Jan",
    //     "Feb",
    //     "Mar",
    //     "Apr",
    //     "May",
    //     "Jun",
    //     "Jul",
    //     "Aug",
    //     "Sep",
    //     "Oct",
    //     "Nov",
    //     "Dec",
    //   ];
    //   return "${date.day} ${months[date.month]} ${date.year}";
    // }

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
      margin: const EdgeInsets.symmetric(vertical: 8),
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

  Widget _mopsCard({
    required DateTime date,
    required Map<String, double> prices,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
                      text: "USD/BBL",
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
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            "Market Price",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 16, color: Colors.black38, thickness: 0.5),
          _fuelRow("Mops(92 Ron)", prices["Mops(92 Ron)"] ?? 0),
          _fuelRow("Mops(95 Ron)", prices["Mops(95 Ron)"] ?? 0),
          _fuelRow("Mops(10 ppm)", prices["Mops(10 ppm)"] ?? 0),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: pickDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Row(
                  children: [
                    Text(
                      "-- City --",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRowMops() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: pickDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
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
        ],
      ),
    );
  }
}
