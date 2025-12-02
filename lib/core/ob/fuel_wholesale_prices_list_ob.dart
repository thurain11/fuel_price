import 'package:market_price/core/ob/pin_ob.dart';

import 'fuel_retail_prices_list_ob.dart';

class FuelWholesalePricesListOb {
  List<FuelWholesalePricesData>? data;
  Links? links;
  Meta? meta;
  int? result;
  String? message;

  FuelWholesalePricesListOb({
    this.data,
    this.links,
    this.meta,
    this.result,
    this.message,
  });

  FuelWholesalePricesListOb.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FuelWholesalePricesData>[];
      json['data'].forEach((v) {
        data!.add(new FuelWholesalePricesData.fromJson(v));
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

class FuelWholesalePricesData {
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

  FuelWholesalePricesData({
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

  FuelWholesalePricesData.fromJson(Map<String, dynamic> json) {
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
