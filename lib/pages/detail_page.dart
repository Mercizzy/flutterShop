import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provider/detailInfo_provide.dart';

import '../widget/detail_page/detail_top_page.dart';
import '../widget/detail_page/detail_expression_page.dart';
import '../widget/detail_page/detail_tabber_page.dart';
import '../widget/detail_page/detail_web_page.dart';
import '../widget/detail_page/detail_bottom_page.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;

  const DetailPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('详情页'),),
        body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 48),
                    child: ListView(
                      // child: Column(
                        children: <Widget>[
                          DetailTop(),
                          DetailExpression(),
                          DetailTabber(),
                          DetailWebPage()
                        ],
                      // ),
                    )
                  ),

                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: DetailBottomPage(),
                  ),
                ],
              );
              
            }else {
              return Text('loading......');
            }
          },
        )
      )
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);

    return 'success';
  }
}