import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeRecommend extends StatelessWidget {
  final List list;

  const HomeRecommend({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        
      ),
      child: Column(
        children: <Widget>[
          _topName(),
          _listView()
        ],
      ),
    );
  }

  Widget _topName() {

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.5)
        )
      ),
      child: Text(
        '推荐专区',
        style: TextStyle(
          color: Colors.pink,
        )
      ),
    );
  }

  Widget _listItem(index) {

    return Container(
      height: ScreenUtil().setHeight(330),
      width: ScreenUtil().setHeight(450),
      decoration: BoxDecoration(
        border: Border(
          right:  index == list.length-1 ? BorderSide(width: 0.0) : BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12)
        )
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Image.network('${list[index]['image']}', height: 100.0,),
            Text('￥ ${list[index]['mallPrice']}'),
            Text(
              '￥ ${list[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),  
            ),
          ],
        ),
      )
    );
  }

  Widget _listView() {
    
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _listItem(index);
        },
      ),
    );
  }
}