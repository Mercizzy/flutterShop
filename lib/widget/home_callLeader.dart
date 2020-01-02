import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class CallLeader extends StatelessWidget {
  final String callImg;
  final String callPhone;

  const CallLeader({Key key, this.callImg, this.callPhone}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _call,
        child: Image.network(callImg),
      ),
    );
  }

  void _call() async{
    String url = 'tel:' + callPhone;
    if(await canLaunch(url)) {
      print('aaaaa');
      await launch(url);
    }else {
      print('url有问题');
    }
  }
}