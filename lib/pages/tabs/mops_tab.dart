import 'package:market_price/builders/refresh_builder/refresh_ui_builder.dart';
import 'package:market_price/builders/request_button/request_button_bloc.dart';
import 'package:market_price/widgets/my_card.dart';

import '../../builders/single_ui_builder/single_ui_builder.dart';
import '../../core/ob/mops_price_list_ob.dart';
import '../../global.dart';
import '../home/fl_chart_dynamic.dart';

class MOPSTab extends StatefulWidget {
  const MOPSTab({super.key});

  @override
  State<MOPSTab> createState() => _MOPSTabState();
}

class _MOPSTabState extends State<MOPSTab> {
  DateTime selectedDate = DateTime.now();

  var refreshKey = GlobalKey<RefreshUiBuilderState>();

  RequestButtonBloc bloc = RequestButtonBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    bloc.dispose();
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
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
      refreshKey.currentState!.func(map: {"date": _formatDate(selectedDate)});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        _buildFilterRow(),
        Expanded(
          child: RefreshUiBuilder<MOPSPriceData>(
            key: refreshKey,
            url: 'fuel-price/mops',
            map: {"date": _formatDate(selectedDate)},
            childWidget: (dynamic data, RefreshLoad func, bool? isList) {
              MOPSPriceData wpData = data as MOPSPriceData;

              return Column(
                children: [
                  SizedBox(height: 8),
                  _buildRetailFuelCard(data: wpData),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRetailFuelCard({required MOPSPriceData data}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // final bool isToday = date.isSameDate(DateTime.now());

    return MyCard(
      ph: 14,
      pv: 8,
      // ma: 0,
      mh: 2,
      mt: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Divider(height: 16, color: Colors.black38, thickness: 0.5),
          _fuelRow("92 Ron", data.mopsRon92Price ?? "0"),
          _fuelRow("95 Ron", data.mopsRon95Price ?? "0"),
          _fuelRow("HSD(10 ppm)", data.mops10PpmPrice ?? "0"),
          SizedBox(height: 10),
          // FuelChartDynamic(chartData: data.chart),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: FuelChartDynamicFL(chartData: data.chart),
          ),
        ],
      ),
    );
  }

  Widget _fuelRow(String name, String priceText) {
    // "2,625 MMK/L" ဆိုတဲ့ format ကနေ ခွဲထုတ်မယ်
    final parts = priceText.split(' ');
    final price = parts.isNotEmpty ? parts[0] : priceText;
    final unit = parts.length > 1 ? parts.sublist(1).join(' ') : 'MMK/L';

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
                style: DefaultTextStyle.of(
                  context,
                ).style, // theme ကို ဆက်သုံးမယ်
                children: [
                  // ဈေးနှုန်း အဓိက
                  TextSpan(
                    text: price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87, // dark mode မှာလည်း ကြည်လင်အောင်
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 4)), // space လေး
                  // ယူနစ် (အစိမ်းရောင် + သေးသေး)
                  TextSpan(
                    text: unit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.green.shade600,
                      letterSpacing: 0.5,
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

  Widget _buildFilterRow() {
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
                    _formatDate(selectedDate),
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
