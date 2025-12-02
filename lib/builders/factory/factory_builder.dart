import '../../core/ob/cities_ob.dart';
import '../../core/ob/fuel_retail_prices_list_ob.dart';
import '../../core/ob/fuel_wholesale_prices_list_ob.dart';

final objectFactories = <Type, Function>{
  CitiesData: (Map<String, dynamic> m) => CitiesData.fromJson(m),
  FuelRetailPricesData: (Map<String, dynamic> m) =>
      FuelRetailPricesData.fromJson(m),
  FuelWholesalePricesData: (Map<String, dynamic> m) =>
      FuelWholesalePricesData.fromJson(m),
};
