import 'package:market_price/builders/refresh_builder/refresh_ui_builder.dart';
import 'package:market_price/builders/request_button/request_button_bloc.dart';
import 'package:market_price/core/ob/cities_ob.dart';
import 'package:market_price/core/ob/fuel_wholesale_prices_list_ob.dart';
import 'package:market_price/widgets/my_card.dart';

import '../../builders/single_ui_builder/single_ui_builder.dart';
import '../../global.dart';
import '../home/fl_chart_dynamic.dart';

class WholesaleTab extends StatefulWidget {
  const WholesaleTab({super.key});

  @override
  State<WholesaleTab> createState() => _WholesaleTabState();
}

class _WholesaleTabState extends State<WholesaleTab> {
  DateTime selectedDate = DateTime.now();

  var refreshKey = GlobalKey<RefreshUiBuilderState>();

  RequestButtonBloc bloc = RequestButtonBloc();

  // initCity() async {
  //   bloc.postData('city', requestType: ReqType.Get, map: {'type': '15'});
  //
  //   bloc.getRequestStream().listen((ResponseOb res) {
  //     if (res.message == MsgState.data) {
  //       print("Data --> ${res.data}");
  //       print("Data --> ${res.data.runtimeType}");
  //
  //       Map<String, dynamic> map = res.data;
  //
  //       List<CitiesData> cityList = List<CitiesData>.from(
  //         (map["data"] as List).map((e) => CitiesData.fromJson(e)),
  //       );
  //
  //       CitiesData? yangonCity = cityList.firstWhere(
  //         (city) =>
  //             city.cityName!.contains("Yangon") ||
  //             city.cityName!.contains("ရန်ကုန်"),
  //         orElse: () => CitiesData(), // မတွေ့ရင် null ပြန်မယ်
  //       );
  //
  //       print(yangonCity.cityId.toString() + " -------> ID");
  //
  //       if (yangonCity != null) {
  //         print("တွေ့ပြီ: ${yangonCity.cityName} - ID: ${yangonCity.cityId}");
  //         setState(() {
  //           citiesData = yangonCity;
  //         });
  //         refreshKey.currentState!.func(
  //           map: {
  //             "city_id": yangonCity.cityId ?? "",
  //             'date': _formatDate(selectedDate),
  //           },
  //         );
  //       } else {
  //         print("ရန်ကုန် မတွေ့ပါ");
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initCity();
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
      refreshKey.currentState!.func(
        map: {
          "date": _formatDate(selectedDate),
          "city_id": citiesData == null ? "" : citiesData!.cityId,
        },
      );
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
          child: RefreshUiBuilder<FuelWholesalePricesData>(
            key: refreshKey,
            url: 'fuel-price/fuel-wholesale-price',
            map: {
              "date": _formatDate(selectedDate),
              // "city_id": citiesData == null ? "" : citiesData!.cityId,
            },
            childWidget: (dynamic data, RefreshLoad func, bool? isList) {
              FuelWholesalePricesData wpData = data as FuelWholesalePricesData;

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

  Widget _buildRetailFuelCard({required FuelWholesalePricesData data}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // final bool isToday = date.isSameDate(DateTime.now());

    return MyCard(
      ph: 14,
      pv: 8,
      mh: 2,
      mt: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data.cityName}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Divider(height: 16, color: Colors.black38, thickness: 0.5),
          _fuelRow("92 Ron", data.s92RonPrice ?? "0"),
          _fuelRow("95 Ron", data.s95RonPrice ?? "0"),
          _fuelRow("HSD(500 ppm)", data.hsd500PpmPrice ?? "0"),
          _fuelRow("HSD(50 ppm)", data.hsd50PpmPrice ?? "0"),
          _fuelRow("HSD(10 ppm)", data.hsd10PpmPrice ?? "0"),
          SizedBox(height: 10),
          // FuelChartDynamic(chartData: data.chart),
          Container(
            // color: Colors.grey.shade100,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: FuelChartDynamicFL(chartData: data.chart),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 5),
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
                      // dark mode မှာလည်း ကြည်လင်အောင်
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
          flex: 2,
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
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () async {
              _showCityBottomSheet(context);
            },
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
                  citiesData == null
                      ? Expanded(
                          child: Text(
                            "All City",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Text(
                            "${citiesData!.cityName}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  CitiesData? citiesData;

  void _showCityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (a, myState) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Header: Drag handle + Title + Close
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      children: [
                        Container(
                          width: 45,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Select City",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Search Bar (optional - မင်းလိုရင်ထည့်ပါ)
                        // လောလောဆယ် RefreshUiBuilder က search ကို handle လုပ်နေတယ်ဆိုရင် ဒီဟာကို ဖျက်လို့ရတယ်
                      ],
                    ),
                  ),

                  // အဓိက အပိုင်း - ဒီထဲမှာ RefreshUiBuilder တစ်ခုပဲ ထည့်မယ်
                  Expanded(
                    child: RefreshUiBuilder<CitiesData>(
                      scrollHeaderWidget: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              refreshKey.currentState!.func(
                                map: {"date": _formatDate(selectedDate)},
                              );
                              context.back();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                "All City",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      url: "city",
                      map: {"type": "15", "search": ""},
                      // ဒါက အရေးကြီးတယ်!
                      loadingWidget: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.8,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      childWidget:
                          (dynamic item, RefreshLoad load, bool? isList) {
                            final CitiesData city = item as CitiesData;

                            return InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                setState(() {});
                                myState(() {});
                                citiesData = city;
                                refreshKey.currentState!.func(
                                  map: {
                                    "date": _formatDate(selectedDate),
                                    "city_id": citiesData!.cityId ?? "",
                                  },
                                );
                                context.back();
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // City Avatar

                                    // City Name + Region
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            city.cityName ?? '-',
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Arrow
                                  ],
                                ),
                              ),
                            );
                          },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
