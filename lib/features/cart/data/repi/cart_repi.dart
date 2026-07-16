import 'package:Hungry_App/core/network/api_error.dart';
import 'package:Hungry_App/core/network/api_services.dart';
import 'package:Hungry_App/features/cart/data/models/cart_models.dart';

class CartRepo {
  ApiServices apiServices = ApiServices();

  /// add to cart
  Future<void> addToCart(CartRequestModel cart) async {
    try {
      final response = await apiServices.post('/cart/add', cart.toJson());
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic> &&
          response['code'] != null &&
          response['code'] != 200) {
        throw ApiError(
          message: response['message'] ?? 'Unable to add item to cart',
        );
      }
    } catch (e) {
      if (e is ApiError) {
        throw e;
      }
      throw ApiError(message: e.toString());
    }
  }

  /// get cart
  Future<GetCartResponse?> getCartData() async {
    try {
      final response = await apiServices.get('/cart');
   if(response is ApiError){
     throw ApiError(message: response.message);
   }
    return GetCartResponse.fromJson(response);// ignore: curly_braces_in_flow_control_structures
    } catch (e) {
      if (e is ApiError) {
        throw e;
      } else {
        throw ApiError(message: e.toString());
      }
    }
  }

  /// delete cart
  Future<void> removeCartItem(int itemId) async {
    try {
      final response = await apiServices.delete('/cart/remove/$itemId', {});
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        throw ApiError(message: 'Unexpected response while removing from cart');
      }
      if(response['code']==200 && response['data']==null){
        throw ApiError(
          message: response['message'] ?? 'Unable to remove item from cart',
        );
      }
    } catch (e) {
      if (e is ApiError) {
        throw e;
      }
      throw ApiError(message: e.toString());
    }
  }
}
