import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../service/service_methods.dart';
import '../widget/my_swiper.dart';
import '../widget/home_gridView.dart';
import '../widget/home_callLeader.dart';
import '../widget/home_recommend.dart';
import '../widget/home_hot.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
// import '../widget/header_yellow.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('百姓生活+'),),
        body: MyFuture()
      )
    );
  }

}

class MyFuture extends StatefulWidget {
  @override
  _MyFutureState createState() => _MyFutureState();
}

class _MyFutureState extends State<MyFuture> {
  List list1 = [];
  List list2 = [
    {
      'image': 'http://a.hiphotos.baidu.com/image/pic/item/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg',
      'name': '名字1'
    },
    {
      'image': 'http://b.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg',
      'name': '名字2'
    },
    {
      'image': 'http://f.hiphotos.baidu.com/image/pic/item/0e2442a7d933c8956c0e8eeadb1373f08202002a.jpg',
      'name': '名字3'
    },
    {
      'image': 'http://f.hiphotos.baidu.com/image/pic/item/b151f8198618367aa7f3cc7424738bd4b31ce525.jpg',
      'name': '名字4'
    },
    {
      'image': 'http://a.hiphotos.baidu.com/image/pic/item/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg',
      'name': '名字5'
    },
    {
      'image': 'http://b.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg',
      'name': '名字6'
    },
    {
      'image': 'http://f.hiphotos.baidu.com/image/pic/item/0e2442a7d933c8956c0e8eeadb1373f08202002a.jpg',
      'name': '名字7'
    },
    {
      'image': 'http://f.hiphotos.baidu.com/image/pic/item/b151f8198618367aa7f3cc7424738bd4b31ce525.jpg',
      'name': '名字8'
    },
    {
      'image': 'http://a.hiphotos.baidu.com/image/pic/item/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg',
      'name': '名字9'
    },
    {
      'image': 'http://b.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg',
      'name': '名字10'
    },
  ];

  int page = 1;
  EasyRefreshController _easyRefreshController;
  List<Map> loadList = [];
  @override
  void initState() { 
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homePageContent(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          var data = json.decode(snapshot.data);
          // debugPrint(data.toString(), wrapWidth: 200);
          // data['data'].forEach((key, value) {
          //   print('$key');
          // });

          list1 = data['data']['slides'];
          // print(data['data']['floor1Pic']);
          String callImg = data['data']['shopInfo']['leaderImage'];
          String callPhone = data['data']['shopInfo']['leaderPhone'];
          List recommendList = data['data']['recommend'];

          return EasyRefresh(
            enableControlFinishLoad: true,
            enableControlFinishRefresh: false,
            controller: _easyRefreshController,
            onLoad: () async{
              print('开始加载更多');
              
              // print('page: $page');
              await homePageBelowContent(page).then((val) {
                var data = json.decode(val.toString());
                List<Map> newList =( data['data'] as List).cast();
                // print(newList);
                setState(() {
                  loadList.addAll(newList);
                  page++;
                });
                _easyRefreshController.finishLoad(noMore: loadList.length> 40);
              });
            },
            onRefresh: () async {
              print('下拉刷新');
              await homePageBelowContent(1).then((val) {
                var data = json.decode(val.toString());
                List<Map> newList =( data['data'] as List).cast();
                // print(newList);
                setState(() {
                  loadList = newList;
                  page = 1;
                });
                _easyRefreshController.resetLoadState();
              });
            },
            footer: ClassicalFooter(
              extent: 60.0,
              loadText: '提示加载',
              loadReadyText: '松手加载',
              loadingText: '正在加载中',
              loadedText: '加载完成',
              noMoreText: '没有更多',
              infoText: '额外信息',
              bgColor: Colors.blueAccent,
              textColor: Colors.pink,
              infoColor: Colors.red
            ),
            // header: BobMinionHeader(),
            header: PhoenixHeader(),
            child: ListView(
              children: <Widget>[
                MySwiper(height: 300, swiperList: list1,),
                HomeGridView(height: 260, gridList: list2,),
                CallLeader(callImg: callImg, callPhone: callPhone,),
                HomeRecommend(list: recommendList,),
                HomeHot(page: page,list: loadList,)
              ],
            ),
          );
        }else {
          return Center(
            child: Text('请求数据中。。。。。'),
          );
        }
      },
    );
  }


}