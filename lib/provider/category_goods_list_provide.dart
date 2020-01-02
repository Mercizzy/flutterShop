import 'package:flutter/material.dart';
import 'package:flutter_shop/model/right_goodslist_model.dart';

class CategoryGoodList extends ChangeNotifier {
  List<RightGoodsListData> categoryGoodsList = [];

  //改变大项
  void setList(List<RightGoodsListData> list) {
    categoryGoodsList = list;
    notifyListeners();
  }
}