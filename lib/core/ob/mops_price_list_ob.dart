import 'package:market_price/core/ob/pin_ob.dart';

import 'fuel_retail_prices_list_ob.dart';

class MOPSPriceListOb {
  List<MOPSPriceData>? data;
  Links? links;
  Meta? meta;
  int? result;
  String? message;

  MOPSPriceListOb({
    this.data,
    this.links,
    this.meta,
    this.result,
    this.message,
  });

  MOPSPriceListOb.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MOPSPriceData>[];
      json['data'].forEach((v) {
        data!.add(new MOPSPriceData.fromJson(v));
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

class MOPSPriceData {
  int? id;
  String? date;
  String? mopsRon92Price;
  String? mopsRon95Price;
  String? mops10PpmPrice;
  Chart? chart;

  MOPSPriceData({
    this.id,
    this.date,
    this.mopsRon92Price,
    this.mopsRon95Price,
    this.mops10PpmPrice,
    this.chart,
  });

  MOPSPriceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    mopsRon92Price = json['mops_ron_92_price'];
    mopsRon95Price = json['mops_ron_95_price'];
    mops10PpmPrice = json['mops_10_ppm_price'];
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['mops_ron_92_price'] = this.mopsRon92Price;
    data['mops_ron_95_price'] = this.mopsRon95Price;
    data['mops_10_ppm_price'] = this.mops10PpmPrice;

    return data;
  }
}
