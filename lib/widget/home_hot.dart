import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import '../routers/router_application.dart';

class HomeHot extends StatefulWidget {
  final int page;
  final List<Map> list;

  const HomeHot({Key key, this.page, this.list}) : super(key: key);
  @override
  _HomeHotState createState() => _HomeHotState();
}

class _HomeHotState extends State<HomeHot> {
  
  List<Map> list = [];

  @override
  void initState() { 
    super.initState();
    list = widget.list;
    // homePageBelowContent({'page': widget.page}).then((val) {
    //   var data = json.decode(val.toString());
    //   List<Map> newList =( data['data'] as List).cast();
    //   print(newList);
    //   setState(() {
    //     list.addAll(newList);
    //   });
      
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _hotList(),
        ],
      )
    );
  }

  //火爆专区名称
  Widget _hotTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.red,
            child: Center(
                child: Text('火',
                style: TextStyle(
                  fontSize: 10.0
                ),
              ),
            )
          ),
          Text('火爆专区')
        ],
      ),
    );
  }

  //火爆专区列表
  Widget _hotList() {
    if(list.length > 0) {
      List<Widget> widgetList = list.map((item) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, "/detail?goodsId=${item['goodsId']}");
          },
          child: Container(
            width: ScreenUtil().setWidth(335),
            child: Column(
              children: <Widget>[
                Text('${item['name']}',maxLines: 1,overflow: TextOverflow.ellipsis,),
                Image.network(
                  '${item['image']}',
                  height: ScreenUtil().setHeight(330),
                ),
                Text('${item['mallPrice']}'),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: widgetList,
      );
    }else {
      return Text('');
    }
  }
}