import 'package:flutter/material.dart';

class RetailPricesPage extends StatefulWidget {
  final String dateLabel; // e.g. "24 Aug 2024"

  const RetailPricesPage({super.key, required this.dateLabel});

  @override
  State<RetailPricesPage> createState() => _RetailPricesPageState();
}

class _RetailPricesPageState extends State<RetailPricesPage> {
  int selectedFuelIndex = 0;
  String searchQuery = "";

  List<String> fuelTypes = [
    "92 RON",
    "95 RON",
    "HSD (500 ppm)",
    "HSD (50 ppm)",
    "HSD (10 ppm)",
  ];

  List<Map<String, dynamic>> cityPrices = [
    {"city": "Yangon", "price": 1850, "change": 20},
    {"city": "Mandalay", "price": 1835, "change": -15},
    {"city": "Naypyidaw", "price": 1840, "change": 5},
    {"city": "Taunggyi", "price": 1865, "change": 0},
    {"city": "Mawlamyine", "price": 1855, "change": -10},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = cityPrices.where((item) {
      return item["city"].toString().toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Retail Prices - ${widget.dateLabel}"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Fuel Type Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: fuelTypes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final selected = selectedFuelIndex == i;
                  return ChoiceChip(
                    label: Text(fuelTypes[i]),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedFuelIndex = i),
                    selectedColor: Colors.green,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: selected
                            ? Colors.transparent
                            : Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Search bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search for a city...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onChanged: (v) => setState(() => searchQuery = v),
            ),

            const SizedBox(height: 16),

            // City list
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, i) {
                  final item = filteredList[i];
                  final change = item["change"] as int;

                  Color changeColor = change > 0
                      ? Colors.red
                      : change < 0
                      ? Colors.green
                      : Colors.grey;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["city"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${item["price"]} MMK/L",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            change == 0
                                ? "0 MMK"
                                : "${change > 0 ? "+" : ""}$change MMK",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: changeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
