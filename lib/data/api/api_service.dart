import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_denis/data/model/restaurant.dart';
import 'package:restaurant_denis/data/model/restaurant_detail.dart';
import 'package:restaurant_denis/data/model/restaurant_search.dart';


class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Restaurant> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/${id}"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail Restaurant');
    }
  }

  Future<RestaurantsSearch> searchingRestaurant(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=${query}"));
    if (response.statusCode == 200) {
      return RestaurantsSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search restaurant');
    }
  }
}
