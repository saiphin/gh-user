import 'dart:convert';

import 'package:givepo/controller/auth_controller.dart';
import 'package:givepo/controller/banner_controller.dart';
import 'package:givepo/controller/campaign_controller.dart';
import 'package:givepo/controller/cart_controller.dart';
import 'package:givepo/controller/category_controller.dart';
import 'package:givepo/controller/chat_controller.dart';
import 'package:givepo/controller/coupon_controller.dart';
import 'package:givepo/controller/localization_controller.dart';
import 'package:givepo/controller/location_controller.dart';
import 'package:givepo/controller/notification_controller.dart';
import 'package:givepo/controller/onboarding_controller.dart';
import 'package:givepo/controller/order_controller.dart';
import 'package:givepo/controller/item_controller.dart';
import 'package:givepo/controller/parcel_controller.dart';
import 'package:givepo/controller/store_controller.dart';
import 'package:givepo/controller/search_controller.dart';
import 'package:givepo/controller/splash_controller.dart';
import 'package:givepo/controller/theme_controller.dart';
import 'package:givepo/controller/user_controller.dart';
import 'package:givepo/controller/wallet_controller.dart';
import 'package:givepo/controller/wishlist_controller.dart';
import 'package:givepo/data/repository/auth_repo.dart';
import 'package:givepo/data/repository/banner_repo.dart';
import 'package:givepo/data/repository/campaign_repo.dart';
import 'package:givepo/data/repository/cart_repo.dart';
import 'package:givepo/data/repository/category_repo.dart';
import 'package:givepo/data/repository/coupon_repo.dart';
import 'package:givepo/data/repository/language_repo.dart';
import 'package:givepo/data/repository/location_repo.dart';
import 'package:givepo/data/repository/notification_repo.dart';
import 'package:givepo/data/repository/onboarding_repo.dart';
import 'package:givepo/data/repository/order_repo.dart';
import 'package:givepo/data/repository/item_repo.dart';
import 'package:givepo/data/repository/parcel_repo.dart';
import 'package:givepo/data/repository/store_repo.dart';
import 'package:givepo/data/repository/search_repo.dart';
import 'package:givepo/data/repository/splash_repo.dart';
import 'package:givepo/data/api/api_client.dart';
import 'package:givepo/data/repository/user_repo.dart';
import 'package:givepo/data/repository/wallet_repo.dart';
import 'package:givepo/data/repository/wishlist_repo.dart';
import 'package:givepo/util/app_constants.dart';
import 'package:givepo/data/model/response/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../data/repository/chat_repo.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => OnBoardingRepo());
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => StoreRepo(apiClient: Get.find()));
  Get.lazyPut(() => WishListRepo(apiClient: Get.find()));
  Get.lazyPut(() => ItemRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CouponRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CampaignRepo(apiClient: Get.find()));
  Get.lazyPut(() => ParcelRepo(apiClient: Get.find()));
  Get.lazyPut(() => WalletRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => ChatRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => OnBoardingController(onboardingRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => ItemController(itemRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => StoreController(storeRepo: Get.find()));
  Get.lazyPut(
      () => WishListController(wishListRepo: Get.find(), itemRepo: Get.find()));
  Get.lazyPut(() => SearchController(searchRepo: Get.find()));
  Get.lazyPut(() => CouponController(couponRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => CampaignController(campaignRepo: Get.find()));
  Get.lazyPut(() => ParcelController(parcelRepo: Get.find()));
  Get.lazyPut(() => WalletController(walletRepo: Get.find()));
  Get.lazyPut(() => ChatController(chatRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
