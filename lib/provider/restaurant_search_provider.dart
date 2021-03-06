import 'package:flutter/material.dart';
import 'package:restaurant_denis/data/api/api_service.dart';
import 'package:restaurant_denis/data/model/restaurant_search.dart';

enum StateResultSearch { Loading, NoData, HasData, Error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchAllRestaurantSearch(query);
  }

  RestaurantsSearch? _resultRestaurantsSearch;
  String _message = '';
  String _query = '';
  StateResultSearch? _state;

  String get message => _message;
  String get query => _query;

  RestaurantsSearch? get result => _resultRestaurantsSearch;

  StateResultSearch? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String query) async {
    try {
      _state = StateResultSearch.Loading;
      _query = query;

      final restaurantSearch = await apiService.searchingRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = StateResultSearch.NoData;
        notifyListeners();
        return _message = 'Cannot find your restaurant';
      } else {
        _state = StateResultSearch.HasData;

        notifyListeners();
        return _resultRestaurantsSearch = restaurantSearch;
      }
    } catch (e) {
      _state = StateResultSearch.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
