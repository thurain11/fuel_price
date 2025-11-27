import 'package:market_price/pages/home/home_page.dart';

import '../../global.dart';

class MarketWatchPage extends StatefulWidget {
  const MarketWatchPage({super.key});

  @override
  State<MarketWatchPage> createState() => _MarketWatchPageState();
}

class _MarketWatchPageState extends State<MarketWatchPage> {
  DateTime selectedDate = DateTime.now();
  String selectedCity = "Yangon";

  int selectedFuelIndex = 0;

  final fuels = [
    {"name": "92 RON", "icon": Icons.local_gas_station_outlined},
    {"name": "95 RON", "icon": Icons.star_border},
    {"name": "HSD (500ppm)", "icon": Icons.local_shipping_outlined},
  ];

  Future pickDate() async {
    DateTime? d = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );
    if (d != null) setState(() => selectedDate = d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Icon
              Row(
                children: [
                  const Text(
                    "Market Watch",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 30),
                    onPressed: () {
                      context.to(HomePage());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Date Picker
              InkWell(
                onTap: pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      const SizedBox(width: 10),
                      Text(
                        "${selectedDate.day}, ${_month(selectedDate.month)} ${selectedDate.year}",
                        style: const TextStyle(fontSize: 17),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// City dropdown
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedCity,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedCity,
                      underline: const SizedBox(),
                      items: ["Yangon", "Mandalay", "Naypyitaw"]
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => selectedCity = v!),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Fuel Type selector
              SizedBox(
                height: 100,
                child: Row(
                  children: List.generate(fuels.length, (index) {
                    final f = fuels[index];
                    final selected = selectedFuelIndex == index;
                    return Expanded(
                      child: InkWell(
                        onTap: () => setState(() => selectedFuelIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: selected
                                ? const Color(0xFFE6EEFF)
                                : Colors.white,
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF2F65F9)
                                  : Colors.grey.shade300,
                              width: selected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                f["icon"] as IconData,
                                size: 30,
                                color: selected
                                    ? const Color(0xFF2F65F9)
                                    : Colors.grey,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                f["name"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? const Color(0xFF2F65F9)
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              /// Price Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Current price in Yangon",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "1,850",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " MMK/L",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "+20 MMK today",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                          // Spacer(),
                          // Text(
                          //   "Last updated: 2 hours ago",
                          //   style: TextStyle(color: Colors.grey, fontSize: 13),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
