import 'package:Hungry_App/core/network/api_error.dart';
import 'package:Hungry_App/core/network/api_services.dart';
import 'package:Hungry_App/features/order/data/order_model.dart';

class OrderRepo{
  ApiServices apiServices =ApiServices();

  Future<GetOrderModel?>getOrder()async{
    try{
      final response= await apiServices.get('/orders');
      if(response is ApiError){
        throw response;
      }
      return GetOrderModel.fromJson(response);
    }catch(e){
      if(e is ApiError){
        throw e;
      }
      throw ApiError(message: e.toString());
    }
  }
}