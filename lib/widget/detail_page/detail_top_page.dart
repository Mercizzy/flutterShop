import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provider/detailInfo_provide.dart';

class DetailTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<DetailInfoProvide>(
        builder: (context, child, val) {
          var goodsInfo = val.goodsInfo?.data?.goodInfo;
          if(goodsInfo != null) {
            return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _goodsImage(goodsInfo.image1),
                  _goodsName(goodsInfo.goodsName),
                  _goodsNum(goodsInfo.goodsSerialNumber)
                ],
              ),
            );
          } else {
            return Text('加载中。。。。。');
          }
        },
      ),
    );
  }

  ///商品图片
  Widget _goodsImage(String url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  ///商品名称
  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }

  ///商品编号
  Widget _goodsNum(String num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号：$num',
        style: TextStyle(
          color: Colors.grey
        )
      ),
    );
  }
}