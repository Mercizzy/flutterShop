import 'package:flutter/material.dart';
import './pages/index_page.dart';

///状态管理文件
import 'package:provide/provide.dart';
import 'package:flutter_shop/provider/count_provide.dart';
import './provider/category_right_provide.dart';
import './provider/category_goods_list_provide.dart';
import './provider/detailInfo_provide.dart';
import './provider/cart_list_provide.dart';

///路由插件
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/router_application.dart';

void main() {
  var counter = Counter();
  var categoryRight = CategoryRight();
  var caregoryGoodsList = CategoryGoodList();
  var detailInfoProvide = DetailInfoProvide();
  var cartListProvide = CartListProvide();

  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<CategoryRight>.value(categoryRight))
    ..provide(Provider<CategoryGoodList>.value(caregoryGoodsList))
    ..provide(Provider<DetailInfoProvide>.value(detailInfoProvide))
    ..provide(Provider<CartListProvide>.value(cartListProvide));
  

  runApp(
    ProviderNode(
      providers: providers,
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活家',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}