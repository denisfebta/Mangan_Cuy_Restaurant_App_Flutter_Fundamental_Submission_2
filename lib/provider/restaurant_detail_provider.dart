import 'package:flutter/material.dart';
import 'package:restaurant_denis/data/api/api_service.dart';
import 'package:restaurant_denis/data/model/restaurant_detail.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant();
  }

  late DetailRestaurant _restaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  DetailRestaurant get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
