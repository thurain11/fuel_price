import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_price/core/utils/app_utils.dart';
import 'package:market_price/core/utils/context_ext.dart';
import 'package:market_price/pages/tabs/retail_tab.dart';

import '../setting/setting_page.dart';
import '../tabs/mops_tab.dart';
import '../tabs/wholesale_tab.dart';

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
    return Scaffold(
      appBar: AppUtils.MyAppBar(
        context: context,
        title: 'Fuel Price',
        actions: [
          IconButton(
            onPressed: () {
              context.to(SettingPage());
            },
            icon: const Icon(CupertinoIcons.settings_solid),
          ),
          // IconButton(
          //   onPressed: () {
          //     context.to(Test());
          //   },
          //   icon: Icon(Icons.add),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                  // ===== 1. Petrol (Wholesale)
                  WholesaleTab(),
                  // ===== 2. Petrol (Retail)
                  RetailTab(),
                  // ===== 1. MOPS
                  MOPSTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
