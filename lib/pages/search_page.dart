import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/right_goodslist_model.dart';
import 'package:flutter_shop/provider/category_goods_list_provide.dart';

import '../service/service_methods.dart';
import '../model/category_model.dart';
import 'package:provide/provide.dart';
import '../provider/category_right_provide.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('商品分类'),),
        body: Container(
          child: Row(
            children: <Widget>[
              LeftNav(),
              Column(
                children: <Widget>[
                  RightNav(),
                  Expanded(
                    child: RightGoodList(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

} 

class LeftNav extends StatefulWidget {
  @override
  _LeftNavState createState() => _LeftNavState();
}

class _LeftNavState extends State<LeftNav> {
  List list = [];

  int _nowIndex = 0;

  @override
  void initState() { 
    super.initState();
    _getLeftInfo();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(160),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: _leftMenu(),
    );
  }

  void _getLeftInfo() async{
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryListModel categoryListModel = CategoryListModel.fromJson(data);
      // list.data.forEach((item)=> print(item.mallCategoryName));
      setState(() {
        list = categoryListModel.data;
      });
      Provide.value<CategoryRight>(context).setList(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  //获取商品列表
  void _getGoodsList({categoryId}) async {
    var formData = {
      'categoryId': categoryId == null ? '' : categoryId,
      'categorySubId': '',
      'page': 1
    };

    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      RightGoodsListModel childList = RightGoodsListModel.fromJson(data);
      
      if(childList.data == null) {
        Provide.value<CategoryGoodList>(context).setList([]);
      } else {
        Provide.value<CategoryGoodList>(context).setList(childList.data);
      }
      
      print('拿到list数据');
    });
  }

  Widget _leftMenu() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _leftMenuItem(index);
      },
    );
  }
  Widget _leftMenuItem(index) {
    return InkWell(
      onTap: () {
        setState(() {
          _nowIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<CategoryRight>(context).setList(childList, list[index].mallCategoryId);
        Provide.value<CategoryRight>(context).changeChildMenu(0);
        var id = list[index].mallCategoryId;
        _getGoodsList(categoryId: id);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _nowIndex == index ? Colors.black26 : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Text('${list[index].mallCategoryName}'),
      ),
    );
  }
}

class RightNav extends StatefulWidget {
  @override
  _RightNavState createState() => _RightNavState();
}

class _RightNavState extends State<RightNav> {
  int _nowIndex = 0;

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryRight>(
      builder: (context, child, item) {
        try {
          if(Provide.value<CategoryRight>(context).page == 1 && Provide.value<CategoryRight>(context).categorySubId == '') {
            print('回到最初');
            _scrollController.jumpTo(0.0);
          }
        }catch(e) {
          print('没有切换大类或小类');
        }
        return Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(590),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12)
            )
          ),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: item.categoryList.length,
            itemBuilder: (context, index) {
              return _rightTopInkWell(index, item.categoryList);
            },
          ),
        );
      }
    );
  }

  Widget _rightTopInkWell(int index, List list) {
    bool isCheck = Provide.value<CategoryRight>(context).childIndex == index;
    return InkWell(
      onTap: () {
        _getGoodsList(list[index].mallSubId);
        Provide.value<CategoryRight>(context).changeChildMenu(index);
      },
      child: Container(
        // width: ScreenUtil().setHeight(100),
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        decoration: BoxDecoration(
          color: isCheck ? Colors.black26 : Colors.white,
          border: Border(
            right: BorderSide(color: Colors.black12, width: 1)
          )
        ),
        child: Text(
          '${list[index].mallSubName}'
        ),
      )
    );
  }

  //获取商品列表
  void _getGoodsList(categorySubId) async {
    var formData = {
      'categoryId': Provide.value<CategoryRight>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };

    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      RightGoodsListModel childList = RightGoodsListModel.fromJson(data);

      if(childList.data == null) {
        Provide.value<CategoryGoodList>(context).setList([]);
      } else {
        Provide.value<CategoryGoodList>(context).setList(childList.data);
      }
    
    });
  }

}

//右下商品列表
class RightGoodList extends StatefulWidget {
  @override
  _RightGoodListState createState() => _RightGoodListState();
}

class _RightGoodListState extends State<RightGoodList> {
  ScrollController _scrollController;
  EasyRefreshController _easyRefreshController;

  GlobalKey _footKey = GlobalKey();

  @override
  void initState() { 
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodList>(
      builder: (context, child, data) {
        if(data.categoryGoodsList.length > 0) {
          try {
            var page = Provide.value<CategoryRight>(context).page;
            print('右侧获取的page=$page');
            if(page == 1 && _scrollController != null && _easyRefreshController != null) {
              
              print('重置刷新状态');
              _easyRefreshController.resetLoadState();
              _scrollController.jumpTo(0.0);
            }
          }catch(e) {
            print('没有切换大类或小类 $e');
          }
          return Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              controller: _easyRefreshController,
              enableControlFinishRefresh: true,
	            enableControlFinishLoad: true,
              onLoad: () async{
                await _getMoreList();
                _easyRefreshController.finishLoad(noMore: Provide.value<CategoryRight>(context).noMoreText != 'no');
              },
              footer: ClassicalFooter(
                key: _footKey,
                extent: 60.0,
                loadText: '提示加载',
                loadReadyText: '松手加载',
                loadingText: '正在加载中',
                loadedText: '加载完成',
                noMoreText: Provide.value<CategoryRight>(context).noMoreText,
                infoText: '第${Provide.value<CategoryRight>(context).page}页',
                bgColor: Colors.blueAccent,
                textColor: Colors.purple,
                infoColor: Colors.red
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: data.categoryGoodsList.length,
                itemBuilder: (context, index) {
                  return _listItem(index, data.categoryGoodsList);
                },
              ),
            )
          );
        } else {
          return Text('暂无商品，敬请期待');
        }
        
      },
    );
  }

  //列表项
  Widget _listItem(int index, List list) {
    return InkWell(
      onTap: () {
  
      },
      child: Container(
        child: Row(
          children: <Widget>[
            _rightImg(index, list),
            Column(
              children: <Widget>[
                _leftName(index, list),
                _leftPrice(index, list)
              ],
            ),
          ],
        ),
      ),
    );
  }

  //右侧图片
  Widget _rightImg(int index, List list) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network("${list[index].image}"),
    );
  } 

  //左上名字
  Widget _leftName(int index, List list) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //左下价格
  Widget _leftPrice(int index, List list) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '￥价格: ${list[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30)
            ),
          ),
          Text(
            '${list[index].oriPrice}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(26),
              decoration: TextDecoration.lineThrough
            ),
          ),
        ],
      ),
    );
  }

  //上拉加载获取更多
  _getMoreList() {
    Provide.value<CategoryRight>(context).addPage();
    var formData = {
      'categoryId': Provide.value<CategoryRight>(context).categoryId,
      'categorySubId': Provide.value<CategoryRight>(context).categorySubId,
      'page': Provide.value<CategoryRight>(context).page
    };

    request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      RightGoodsListModel childList = RightGoodsListModel.fromJson(data);

      if(childList.data == null) {
        Provide.value<CategoryRight>(context).setNoMoreText('没有更多了');
        Fluttertoast.showToast(
          msg: "没有更多啦",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
      } else {
        
        List oldList = Provide.value<CategoryGoodList>(context).categoryGoodsList;
        oldList.addAll(childList.data);
        Provide.value<CategoryGoodList>(context).setList(oldList);
      }
    
    });
  }
}
