import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes/app/modules/home/views/cart_mobile_widget.dart';
import 'package:shoes/app/modules/home/views/cart_widget.dart';
import 'package:shoes/app/modules/home/views/product_mobile_widget.dart';
import 'package:shoes/app/modules/home/views/product_widget.dart';
import 'package:shoes/app/unitl/ui_constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = Get.height / 2;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: height * 1.2,
              ),
              Container(
                color: const Color(0xfff6c90e),
                height: height * 0.8,
              )
            ],
          ),
          AnimatedBuilder(
            animation: controller.animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0.0, 20 * controller.animation.value),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: height,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    color: Colors.white,
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        color: const Color(0xfff6c90e),
                        height: height,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          kIsWeb
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProductWidget(),
                            UIConst.width48,
                            CartWidget(),
                          ],
                        ),
                      );
                    } else {
                      return ListView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProductWidget(),
                            ],
                          ),
                          UIConst.height(56),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CartWidget(),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProductMobileWidget(),
                      ],
                    ),
                    UIConst.height(56),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CartMobileWidget(),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(size.width / 2, size.height * 0.4, size.width, size.height * 0.2) // Uốn từ 80% xuống 54%
      ..lineTo(size.width, size.height) // Kết thúc đường cong
      ..lineTo(0, size.height) // Kết thúc đường cong
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
