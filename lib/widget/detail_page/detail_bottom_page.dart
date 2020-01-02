import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/cart_list_provide.dart';

import 'package:flutter_shop/provider/detailInfo_provide.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailBottomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var image = goodsInfo.image1;
    var price = goodsInfo.presentPrice;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(110),
              color: Colors.white,
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart,color: Colors.pink,),
            ),
          ),
          InkWell(
            onTap: () {
              // var data = Provide.value<DetailInfoProvide>(context).goodsInfo;
              // _add(data);
              print('11111');
              _add2(context, goodsId, goodsName, price, count, image);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28)
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //add
  void _add(item) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = [];
    if(preferences.getStringList('testShop') != null) {
      list = preferences.getStringList('testShop');
    }
    print(jsonEncode(item));
    list.add(jsonEncode(item));
    
    preferences.setStringList('testShop', list);
    print('添加成功');
  }

  void _add2(context, goodsId, goodsName, price, count, image) async{
    print('22222');
    Provide.value<CartListProvide>(context).add(goodsId, goodsName, price, count, image);
  }
}