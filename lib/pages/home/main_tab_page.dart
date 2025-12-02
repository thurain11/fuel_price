import 'package:flutter/material.dart';
import 'package:market_price/core/utils/app_utils.dart';
import 'package:market_price/core/utils/context_ext.dart';
import 'package:market_price/pages/tabs/retail_tab.dart';

import '../tabs/wholesale_tab.dart';
import 'line_chart.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class MainTabsPage extends StatefulWidget {
  const MainTabsPage({super.key});

  @override
  State<MainTabsPage> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage>
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TabBar
            // iOS Style Segmented TabBar
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white, // outer background
                borderRadius: BorderRadius.circular(8),
              ),

              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                dividerColor: Colors.transparent,

                // iOS Colors
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black45,

                // iOS Segmented Indicator
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.10),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                indicatorSize: TabBarIndicatorSize.tab,

                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                tabAlignment: TabAlignment.start,

                tabs: tabs.map((tab) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    child: Text(
                      tab.text!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 9),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // ===== 1. Petrol (Wholesale) → Filter ပါတယ် =====
                  WholesaleTab(),
                  RetailTab(),
                  Container(),

                  // Column(
                  //   children: [
                  //     _buildFilterRowMops(),
                  //     SizedBox(height: 8),
                  //
                  //     _mopsCard(
                  //       date: DateTime.now(),
                  //       prices: {
                  //         "Mops(92 Ron)": 78.30,
                  //         "Mops(95 Ron)": 81.16,
                  //         "Mops(10 ppm)": 86.30,
                  //       },
                  //     ),
                  //     SizedBox(height: 10),
                  //
                  //     SizedBox(
                  //       height: 260,
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           color: theme.colorScheme.surface,
                  //           borderRadius: BorderRadius.circular(18),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: isDark
                  //                   ? Colors.black.withValues(alpha: 0.35)
                  //                   : Colors.black.withValues(alpha: 0.06),
                  //               blurRadius: 8,
                  //               offset: const Offset(0, 4),
                  //             ),
                  //           ],
                  //         ),
                  //         child: FuelChartDynamic(
                  //           prices: {
                  //             "Mops(92 Ron)": [
                  //               78.30,
                  //               77.20,
                  //               78.90,
                  //               76.50,
                  //               77.20,
                  //             ],
                  //             "Mops(95 Ron)": [
                  //               81.16,
                  //               82.20,
                  //               83.90,
                  //               81.50,
                  //               82.20,
                  //             ],
                  //             "Mops(10 ppm)": [
                  //               86.30,
                  //               87.20,
                  //               85.90,
                  //               84.50,
                  //               88.20,
                  //             ],
                  //           },
                  //
                  //           dateLabels: [
                  //             "25 Jan",
                  //             "26 Jan",
                  //             "27 Jan",
                  //             "28 Jan",
                  //             "29 Jan",
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildFilterRowMops() {
    return Row(
      children: [
        Expanded(
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
      ],
    );
  }
}
