import 'package:flutter/material.dart';
import '../model/detailInfo_model.dart';
import '../service/service_methods.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailInfoModel goodsInfo;

  bool isLeft = true;

  //从后台获取商品信息
  getGoodsInfo(String id) async{
    var formData = {
      'goodId': id
    };

    await request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());

      print(responseData);

      goodsInfo = DetailInfoModel.fromJson(responseData);

      notifyListeners();
    });
  }

  //详情与评论切换
  switchLeftAndRight(bool left) {
    isLeft = left;

    notifyListeners();
  } 
}