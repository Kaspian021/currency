import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teravell_app/Model/Currency_model.dart';

class Controller extends GetxController {
  RxList<CurrencyModel> listData = RxList();

  var dio = Dio();
  Rx loading = false.obs;

  getMthod() async {
    loading.value = true;
    try {
      var respons = await dio.get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$currencyAll&price_change_percentage=24h',
      );

      if (respons.statusCode == 200) {
        respons.data.forEach((element) {
          listData.add(CurrencyModel.fromJson(element));
        });
      }
      
    } catch (e) {
      debugPrint('error: $e');
    }
    loading.value = false;
    
  }

  Future<bool> positionalCurrency(double position) async {
    if (position >= 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    getMthod();
    super.onInit();
  }
}
