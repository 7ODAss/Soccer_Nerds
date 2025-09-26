import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:football_app/features/list_of_match/data/model/live_match_model.dart';
import '../../../core/network/local/cache_helper.dart';

class FavoriteService {
  final String _key = 'favoriteIds';
  List<LiveMatchModel> _favoriteIds = [];

  Future<void> init() async {
    final dynamic favorites = CacheHelper.getData(key: _key);
    if (favorites != null) {
      _favoriteIds =
          favorites.map((e) {
            if (e is String) {
              try {
                return LiveMatchModel.fromJson(
                  jsonDecode(e) as Map<String, dynamic>,
                );
              }catch(e){
                debugPrint('Error decoding favorite item: $e');
                return null;
              }
            } else if (e is Map<String, dynamic>) {
              return LiveMatchModel.fromJson(e);
            }
            return null;
          }).where((item) => item != null) // Filter out any nulls from bad data
              .cast<LiveMatchModel>() // Ensure correct type
              .toList();
    }else {
      _favoriteIds = [];
    }
  }

  Future<List<LiveMatchModel>> getAll() async {
    return List<LiveMatchModel>.from(_favoriteIds);
  }

  Future<void> addFavorite(LiveMatchModel match) async {
    if(!_favoriteIds.any((e) => e.fixture.id == match.fixture.id,)){
      _favoriteIds.add(match);
      await _saveToCache();
    }
  }

  Future<void> removeFavorite(int id) async {
    _favoriteIds.removeWhere((element) => element.fixture.id == id);
    await _saveToCache();
  }

  Future<bool> isFavorite(int id) async {
    return _favoriteIds.any((element) => element.fixture.id == id);
  }

  Future<void> _saveToCache() async {
    // Convert List<LiveMatchModel> to List<String>
    List<String> matchesJsonList = _favoriteIds.map((match) => jsonEncode(match.toJson())).toList();
    await CacheHelper.setData(key: _key, value: matchesJsonList);
  }
}
