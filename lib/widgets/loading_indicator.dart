import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child:Center(child: SpinKitDoubleBounce(color: Colors.blue))));
  }
}
