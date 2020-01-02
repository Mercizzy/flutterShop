import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provider/detailInfo_provide.dart';

class DetailTabber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(
      builder: (context, child, val) {
        bool isLeft = val.isLeft;
        return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              _tabItem(context, isLeft, true),
              _tabItem(context, isLeft, false),
            ],
          ),
        );
      },
    );
  }

  Widget _tabItem(BuildContext context, bool left, bool self) {
    return InkWell(
      onTap: () {
        Provide.value<DetailInfoProvide>(context).switchLeftAndRight(self);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10.0),
        
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: left == self ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          self ? '详情' : '评论',
          style: TextStyle(
            color: left == self ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }
}