import 'package:Hungry_App/core/network/api_services.dart';
import 'package:Hungry_App/features/home/data/models/product_model.dart';

import '../models/toppings_model.dart';

class ProductRepo {
  final ApiServices apiServices = ApiServices();

  /// get products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiServices.get('/products');
      return List<ProductModel>.from(
        response['data'].map((e) => ProductModel.fromJson(e)),
      );
    } catch (e) {
      print(e.toString());
      return[];
    }
  }

  /// get Toppings
 Future<List<ToppingsModel>> getToppings() async {
    try{
      final response= await apiServices.get('/toppings');
    return List<ToppingsModel>.from(response['data'].map((e)=>ToppingsModel.fromJson(e)));
    }catch(e){
      print(e.toString());
      return[];
    }
 }
 /// get side_options
 Future<List<ToppingsModel>> getOptions() async {
    try{
      final response= await apiServices.get('/side-options');
    return List<ToppingsModel>.from(response['data'].map((e)=>ToppingsModel.fromJson(e)));
    }catch(e){
      print(e.toString());
      return[];
    }
 }

}
