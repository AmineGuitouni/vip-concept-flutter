import 'package:flutter/material.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  final int opacity;
  const Loading({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        color: Color.fromARGB(opacity, 255, 255, 255),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 150,
              child: Lottie.asset("lib/core/assets/animations/loading.json")),
          Text("loading reviews...",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: HomeLayout.blueDark,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              )
          )
        ],
      ),
    ));
  }
}
