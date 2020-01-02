
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/detailInfo_model.dart';
import 'package:flutter_shop/provider/cart_list_provide.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopcartPage extends StatefulWidget {
  @override
  _ShopcartPageState createState() => _ShopcartPageState();
}

class _ShopcartPageState extends State<ShopcartPage> {
  List<DetailInfoModel> list = [];
  @override
  void initState() { 
    super.initState();
    // _show();
    
  }
  @override
  Widget build(BuildContext context) {
    // _show();
    Provide.value<CartListProvide>(context).show();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: Container(
          child: Provide<CartListProvide>(
            builder: (context, child, val) {
              var temp = jsonDecode(val.cartListString.toString());
              List<Map> cartList = (temp as List).cast();
              if(cartList.length > 0) {
                return ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Text('${cartList[index]['goodsName']}'),
                        Text('${cartList[index]['price']}'),
                        Text('*${cartList[index]['count']}'),
                      ],
                    );
                  },
                );
              } else {
                return Text('暂无商品，快去添加吧');
              }
            },
          )
        ),
      ),
    );
  }

  //show
  void _show() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getStringList('testShop') != null) {
      List<String> list2 = preferences.getStringList('testShop');
      print(1);
      List<DetailInfoModel> list3 = [];
      for(var i=0; i< list2.length; i++) {
        print(jsonDecode(list2[i]) is Map);
        
        list3.add(DetailInfoModel.fromJson(jsonDecode(list2[i])));
      }
      setState(() {
        list = list3;
      });
    }
  }
}