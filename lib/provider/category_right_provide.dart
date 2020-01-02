import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class CategoryRight extends ChangeNotifier {
  List<BxMallSubDto> categoryList = [];

  int childIndex = 0;

  String categoryId = '';  //大类id
  String categorySubId = ''; //小类id

  int page = 1;
  String noMoreText = 'no';

  //改变大项
  void setList(List<BxMallSubDto> list, String id) {
    BxMallSubDto first = BxMallSubDto();
    first.mallSubId = '';
    first.mallSubId = '';
    first.mallSubName = '全部';
    first.comments = null;
    categoryList = [first];
    categoryList.addAll(list);

    //切换大类
    categoryId = id;
    categorySubId = '';
    page = 1;
    noMoreText = 'no';
    print('点击大类，page=$page');
    notifyListeners();
  }

  //改变子目录
  changeChildMenu(int index) {
    childIndex = index;

    //改变小类id
    categorySubId = categoryList[index].mallSubId;
    page = 1;
    noMoreText = 'no';
    print('点击小类，page=$page');
    notifyListeners();
  }

  void addPage() {
    page++;
    notifyListeners();
  }

  void setNoMoreText(String str) {
    noMoreText = str;
    print(noMoreText);
    notifyListeners();
  }
}