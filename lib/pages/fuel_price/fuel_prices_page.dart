// import 'package:market_price/pages/fuel_price/retail_prices.dart';
//
// import '../../global.dart';
//
// class FuelPricesPage extends StatefulWidget {
//   @override
//   State<FuelPricesPage> createState() => _FuelPricesPageState();
// }
//
// class _FuelPricesPageState extends State<FuelPricesPage> {
//   int selectedIndex = 0;
//
//   List<String> filters = [
//     "Today",
//     "Yesterday",
//     "24 Jan",
//     "23 Jan",
//     "Pick Date",
//   ];
//
//   DateTime? selectedDate;
//
//   Future<void> pickDate() async {
//     final today = DateTime.now();
//     final newDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? today,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//
//     if (newDate != null) {
//       setState(() {
//         selectedDate = newDate;
//         final formatted = "${newDate.day} ${_month(newDate.month)}";
//
//         // Replace last item "Pick Date" with selected date
//         filters[4] = formatted;
//         selectedIndex = 4;
//       });
//     }
//   }
//
//   String _month(int m) {
//     const months = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ];
//     return months[m - 1];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Fuel Prices")),
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           children: [
//             SizedBox(height: 4),
//             // Filter Chips
//             SizedBox(
//               height: 42,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: filters.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 8),
//                 itemBuilder: (context, i) {
//                   final isSelected = selectedIndex == i;
//
//                   return ChoiceChip(
//                     label: Text(filters[i]),
//                     selected: isSelected,
//                     checkmarkColor: Colors.white,
//                     elevation: 2,
//                     onSelected: (_) {
//                       if (filters[i] == "Pick Date" || i == 4) {
//                         pickDate(); // ✅ Date Picker open
//                       } else {
//                         setState(() => selectedIndex = i);
//                       }
//                     },
//
//                     // selectedColor: const Color(0xFF3A8DFF),
//                     labelStyle: TextStyle(
//                       color: isSelected
//                           ? Colors.white
//                           : const Color(0xFF223344),
//                       fontWeight: FontWeight.w600,
//                     ),
//                     // shape: StadiumBorder(
//                     //   side: BorderSide(
//                     //     color: isSelected
//                     //         ? Colors.transparent
//                     //         : const Color(0xFFD9E6F5),
//                     //   ),
//                     // ),
//                     backgroundColor: Colors.white,
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             _buildItem(
//               type: 1,
//               icon: Icons.local_gas_station,
//               title: "Retail Prices (လက်လီ)",
//               subtitle: "View prices by city and fuel type",
//             ),
//
//             _buildItem(
//               type: 2,
//               icon: Icons.inventory_2_rounded,
//               title: "Wholesale Prices (လက်ကား)",
//               subtitle: "View wholesale market rates",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildItem({
//     required int type,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: ListTile(
//         onTap: () {
//           if (type == 1) {
//             context.to(RetailPricesPage(dateLabel: ''));
//           }
//         },
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor.withValues(alpha: .1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: Theme.of(context).primaryColor),
//         ),
//         title: Text(
//           title,
//           style: Theme.of(
//             context,
//           ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//       ),
//     );
//   }
// }
