import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes/app/modules/home/controllers/home_controller.dart';
import 'package:shoes/app/unitl/image_loader.dart';
import 'package:shoes/app/unitl/ui_constants.dart';

class ProductWidget extends GetResponsiveView<HomeController> {
  ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 360,
          height: 600,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2.0,
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ]),
          margin: const EdgeInsets.all(8.0),
          child: ImageLoader.image(
            'img_card',
          ),
        ),
        SizedBox(
          width: 360,
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageLoader.image('ic_nike', size: 48),
                      const Row(
                        children: [
                          Text(
                            "Our Products",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF303841)),
                          ),
                          Spacer(),
                        ],
                      )
                    ]),
              ),
              UIConst.height4,
              Obx(() {
                final listData = controller.listData.value;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      final item = listData[index];
                      final hasCart = listData[index].hasCart == false;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(item.color ?? 0xff0000),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.all(48),
                            child: Transform.rotate(
                                angle: -15 * (3.141592653589793 / 180),
                                child: CachedNetworkImage(
                                  imageUrl: '${item.image}',
                                )),
                          ),
                          UIConst.height16,
                          Text(
                            '${item.name}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          UIConst.height16,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.description}',
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          UIConst.height30,
                          Row(
                            children: [
                              Text(
                                '\$${item.price}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 800),
                                child: hasCart
                                    ? ElevatedButton(
                                        onPressed: () {
                                          controller.listShoesInCart
                                              .add(item.copyWith(quantity: 1));
                                          controller.listData[index].hasCart =
                                              true;
                                          controller.listData.refresh();
                                          controller.caculator();
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            const EdgeInsets.all(
                                                18.0), // Thêm padding 16.0 pixel cho nút
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xfff6c90e)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                          textStyle: MaterialStateProperty.all(
                                              const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        child: const Text(
                                          'ADD TO CARD',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : const InkWell(
                                        child: CircleAvatar(
                                            backgroundColor: Color(0xfff6c90e),
                                            radius: 12,
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.black,
                                              size: 14,
                                            )),
                                      ),
                              )
                            ],
                          ),
                          UIConst.height32
                        ],
                      );
                    },
                  ),
                );
              })
            ],
          ),
        )
      ],
    );
  }
}
