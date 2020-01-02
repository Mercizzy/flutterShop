import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provider/detailInfo_provide.dart';
import 'package:provide/provide.dart';

class DetailWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _goodsDetailInfo = Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetailInfoProvide>(
      builder: (context, child, val) {
        bool isLeft = val.isLeft;

        try{
          if(isLeft) {
            return Container(
              child: Html(
                data: _goodsDetailInfo,
              ),
            );
          }else {
            return Container(
              child: Text('暂无评论')
            );
          }
        }catch(e) {
          print(e);
        }
      },
    );
  
  }
}