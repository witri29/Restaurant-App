import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant_search.dart';

enum SearchResultState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchAllRestaurant(search);
  }

  late SearchRestaurantResult? _restaurantResult;
  late SearchResultState? _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  SearchRestaurantResult? get result => _restaurantResult;

  String get search => _search;

  SearchResultState? get state => _state;

  Future<dynamic> fetchAllRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = SearchResultState.loading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.getTextField(search);
        if (restaurant.restaurants.isEmpty) {
          _state = SearchResultState.noData;
          notifyListeners();
          return _message = Constants.textEmptyData;
        } else {
          _state = SearchResultState.hasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'text null';
      }
    } on SocketException {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = Constants.textConnectionError;
    } catch (e) {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}