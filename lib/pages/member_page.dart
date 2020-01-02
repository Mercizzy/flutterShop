import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/provider/count_provide.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.count}',
            style: Theme.of(context).textTheme.display1,
          );
        }
      ),
    );
  }
}