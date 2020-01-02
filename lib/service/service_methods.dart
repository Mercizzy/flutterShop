import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页内容
Future homePageContent() async {
  try{
    print('进入获取方法');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded').toString();
    var formData = {
      'lon': '115.02932',
      'lat': '35.76189'
    };
    response = await dio.post(
      servicePath['homePageContent'],
      data: formData
    );
    if(response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }catch(e) {
    return print(e);
  }
}

//获取首页火爆内容
Future homePageBelowContent(page) async {
  try{
    print('进入获取方法');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded').toString();
    var formData = {
      'page': page,
    };
    // print(formData);
    response = await dio.post(
      servicePath['homePageBelowConten'],
      data: formData
    );
    if(response.statusCode == 200) {
      
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }catch(e) {
    return print(e);
  }
}

//统一格式
Future request(url, {formData}) async {
  try{
    print('进入统一获取方法');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded').toString();
    
    response = await dio.post(
      servicePath[url],
      data: formData
    );
    if(response.statusCode == 200) {
      
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }catch(e) {
    return print(e);
  }
}

//获取首页内容
Future testApi() async {
  try{
    print('进入api');
    Response response;
    Dio dio = new Dio();
    dio.options.headers = {
      'Content-Type': ContentType("application", "json", charset: "utf-8").toString(),
      'Content-Length': 275,
      'Connection': 'keep-alive',
      'Vary': 'Accept-Encoding, User-Agent',
      'Content-Encoding': 'gzip',
      'User-Agent': 'HanjuTV/4.7.2 (COR-AL10; Android 9; Scale/2.00)',
      'vc': 'a_4720',
      'vn': '4.7.2',
      'ch': 'huawei',
      'app': 'hj',
      'uk': 'd/J8IQfXBiUinkjrkwPOgCay0yeBCZxYV0+RxwtecKI=',
      'auth-token': '2c9e0cafad5e7474a0285e383d32763c',
      'auth-uid': 19962971,
      'sign': '+362dvV2NlOITy/BG/YV+97pWMzCBxVoRfYpkIjDkJw+PGMvs/ldg1TtjmKhfZHpvcaSYHGYJB/U+TPWpRsbt5HsibE4cv80G3nzqbxAUsnEcpXiQ8356U4KlI87QK1ErzgmGa5ajtF3ZB6CbHTTVRWCz61RM8S7ConIUezdMcsxem8D/mtOwR4LO1tIp+lUg2oMFZbQCrQlXXGBVFghDaYeTmz3WaMEdyWcGYOVvEwiZyZql/Ui/KiU/D2bEQyy3j0EItVZHHE3Cgwbp0BMG0WydJ8KozcPurODnh0n6c9Vfo/oyWApDEda3J4VIMqDVuNmkeZbEQEzLMQwnZhCiYqEqWRt36zqaiZXj1JhIH63FoRmRrWGJoL28gK/XBV5lgiR4P56VAJ3IKeQc5jTFevU4WVYGBYkZc0IeW+LnRW6UO8ANMuWiF1OxeYRqlWekQfB57KcwdWYBeVxLk8E/c0FXNvuAVyWjPGSAzAcN6EJwA7aJEY2wI+Zie17AQr+JtyjQf3JwxbNGNnfC+MPnGfXGuCt39wkiX5iQ2ONV2GTfijprfxPb9wDi/E48ixZ7W46Zewe65lGhFeE6s79GA==',
      'Host': 'api.hanju.koudaibaobao.com'

    };
    var formData = {
      

    };
    response = await dio.post(
      servicePath['testApi'],
      data: formData
    );
    print(response);
    if(response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }catch(e) {
    return print(e);
  }
}