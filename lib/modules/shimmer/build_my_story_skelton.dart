import 'package:chat_app_firebase/modules/shimmer/skelton.dart';
import 'package:flutter/material.dart';

class BuildMyStorySkelton extends StatelessWidget {
  const BuildMyStorySkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210.0,
        width: 130.0,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.09),
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Container(
              height: 180.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 150.0,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.04),
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(15.0),
                                topEnd: Radius.circular(15.0))),
                      ),
                    ),
                  ),
                  Skelton(
                    isCircle: true,
                    height: 45.0,
                    width: 545.0,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
