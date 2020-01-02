import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeGridView extends StatelessWidget {
  final num height;
  final List gridList;

  const HomeGridView({Key key, this.height, this.gridList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: ScreenUtil().setHeight(height),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 4/3,
        children: gridList.map((item) {
          return HomeGridItem(context, item);
        }).toList(),
      ),
    );
  }
}

class HomeGridItem extends StatelessWidget {
  final item;

  HomeGridItem(BuildContext context, this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {print('click');},
      
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text('${item["name"]}')
        ],
      ),
    );
  }
}