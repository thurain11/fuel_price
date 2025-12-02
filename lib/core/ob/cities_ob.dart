import 'package:market_price/core/ob/pin_ob.dart';

class CitiesOb {
  List<CitiesData>? data;
  Links? links;
  Meta? meta;
  int? result;
  String? message;

  CitiesOb({this.data, this.links, this.meta, this.result, this.message});

  CitiesOb.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CitiesData>[];
      json['data'].forEach((v) {
        data!.add(new CitiesData.fromJson(v));
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

class CitiesData {
  int? cityId;
  String? cityName;

  CitiesData({this.cityId, this.cityName});

  CitiesData.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    return data;
  }
}
