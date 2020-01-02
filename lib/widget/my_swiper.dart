import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySwiper extends StatelessWidget {
  final num height;
  final List swiperList;

  const MySwiper({Key key, this.height = 200.0, this.swiperList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    // print('屏幕高度为${ScreenUtil.screenHeight}');
    // print('屏幕高度为${ScreenUtil.screenWidth}');
    // print('屏幕高度比${ScreenUtil().scaleHeight}');
    // print('屏幕宽度比${ScreenUtil().scaleWidth}');
    // print('滚动条高度为${ScreenUtil().setHeight(height)}');
    return Container(
      height: ScreenUtil().setHeight(height),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: ScreenUtil().setHeight(height),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                '${swiperList[index]['image']}',
                fit: BoxFit.cover,
              ),
            )
          );
        },
        itemCount: swiperList.length,
        autoplay: true,
        loop: true,
        pagination: SwiperPagination(),
        control: SwiperControl(),
        viewportFraction: 0.7,
        scale: 0.7
      ),
    );
  }
}