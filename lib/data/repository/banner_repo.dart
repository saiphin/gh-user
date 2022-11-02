import 'package:givepo/data/api/api_client.dart';
import 'package:givepo/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({@required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.BANNER_URI);
  }

  Future<Response> getFeaturedBannerList() async {
    return await apiClient.getData('${AppConstants.BANNER_URI}?featured=1');
  }
}
