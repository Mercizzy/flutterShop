import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartListProvide with ChangeNotifier {
  String cartListString = '[]';

  void add(goodsId, goodsName, price, count, image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<Map> cartList = [];
    if(preferences.getString('cartListInfo') != null) {
      var temp = jsonDecode(preferences.getString('cartListInfo').toString());
      cartList = (temp as List).cast();
      
    }
    bool isHave = false;

    for(int i=0; i<cartList.length; i++) {
      print(cartList[i]['goodsId']);
      if(cartList[i]['goodsId'] == goodsId) {
        print('相等');
        cartList[i]['count']++;
        isHave = true;
      }
    }
    if(!isHave) {
      cartList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': 1,
        'image': image,
        'price': price
      });
    }
    
    cartListString = json.encode(cartList);
    preferences.setString('cartListInfo', cartListString);
    print(cartListString);
    notifyListeners();
  }

  void show() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString('cartListInfo') != null) {
      cartListString = preferences.getString('cartListInfo');
    }
    notifyListeners();
  }
}