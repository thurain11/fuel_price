import 'package:market_price/core/ob/pin_ob.dart';

class FuelRetailPricesListOb {
  List<FuelRetailPricesData>? data;
  Links? links;
  Meta? meta;
  int? result;
  String? message;

  FuelRetailPricesListOb({
    this.data,
    this.links,
    this.meta,
    this.result,
    this.message,
  });

  FuelRetailPricesListOb.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FuelRetailPricesData>[];
      json['data'].forEach((v) {
        data!.add(new FuelRetailPricesData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}

class FuelRetailPricesData {
  int? id;
  String? date;
  int? cityId;
  String? cityName;
  String? s92RonPrice;
  String? s95RonPrice;
  String? hsd500PpmPrice;
  String? hsd50PpmPrice;
  String? hsd10PpmPrice;
  Chart? chart;

  FuelRetailPricesData({
    this.id,
    this.date,
    this.cityId,
    this.cityName,
    this.s92RonPrice,
    this.s95RonPrice,
    this.hsd500PpmPrice,
    this.hsd50PpmPrice,
    this.hsd10PpmPrice,
    this.chart,
  });

  FuelRetailPricesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    s92RonPrice = json['92_ron_price'];
    s95RonPrice = json['95_ron_price'];
    hsd500PpmPrice = json['hsd_500_ppm_price'];
    hsd50PpmPrice = json['hsd_50_ppm_price'];
    hsd10PpmPrice = json['hsd_10_ppm_price'];
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['92_ron_price'] = this.s92RonPrice;
    data['95_ron_price'] = this.s95RonPrice;
    data['hsd_500_ppm_price'] = this.hsd500PpmPrice;
    data['hsd_50_ppm_price'] = this.hsd50PpmPrice;
    data['hsd_10_ppm_price'] = this.hsd10PpmPrice;

    return data;
  }
}

class Chart {
  List<String>? labels;
  Map<String, List<int>>? datasets;

  Chart({this.labels, this.datasets});

  factory Chart.fromJson(Map<String, dynamic> json) {
    final rawDatasets = json['datasets'] as Map<String, dynamic>? ?? {};

    final Map<String, List<int>> parsed = rawDatasets.map((key, value) {
      final list = (value as List).cast<int>();
      return MapEntry(key, list);
    });

    return Chart(
      labels: (json['labels'] as List).cast<String>(),
      datasets: parsed,
    );
  }
}

// class Datasets {
//   List<int>? l92Ron;
//   List<int>? l95Ron;
//   List<int>? hSD500Ppm;
//   List<int>? hSD50Ppm;
//   List<int>? hSD10Ppm;
//
//   Datasets({
//     this.l92Ron,
//     this.l95Ron,
//     this.hSD500Ppm,
//     this.hSD50Ppm,
//     this.hSD10Ppm,
//   });
//
//   Datasets.fromJson(Map<String, dynamic> json) {
//     l92Ron = json['92 Ron'].cast<int>();
//     l95Ron = json['95 Ron'].cast<int>();
//     hSD500Ppm = json['HSD (500 ppm)'].cast<int>();
//     hSD50Ppm = json['HSD (50 ppm)'].cast<int>();
//     hSD10Ppm = json['HSD (10 ppm)'].cast<int>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['92 Ron'] = this.l92Ron;
//     data['95 Ron'] = this.l95Ron;
//     data['HSD (500 ppm)'] = this.hSD500Ppm;
//     data['HSD (50 ppm)'] = this.hSD50Ppm;
//     data['HSD (10 ppm)'] = this.hSD10Ppm;
//     return data;
//   }
// }
