import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes/app/modules/home/controllers/home_controller.dart';
import 'package:shoes/app/unitl/image_loader.dart';
import 'package:shoes/app/unitl/ui_constants.dart';

class CartMobileWidget extends GetView<HomeController> {
  CartMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width * 0.6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
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
          width: Get.width * 0.6,
          height: Get.height * 0.48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageLoader.image('ic_nike', size: 48),
                      Row(
                        children: [
                          const Text(
                            "You Cart",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF303841)),
                          ),
                          const Spacer(),
                          Obx(() {
                            final totalPrice = controller.totalPrice.value;

                            return Text(
                              "\$ $totalPrice",
                              style:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF303841)),
                            );
                          }),
                        ],
                      )
                    ]),
              ),
              UIConst.height4,
              Obx(() {
                final length = controller.listShoesInCart.length;
                return length == 0
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Your Cart is Empty',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: length,
                          itemBuilder: (context, index) {
                            final item = controller.listShoesInCart[index];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(top: 20, left: 10),
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Color(item.color ?? 0xff0000),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Transform.rotate(
                                              angle: -28 * (3.141592653589793 / 180),
                                              child: CachedNetworkImage(
                                                imageUrl: '${item.image}',
                                                width: 130,
                                                height: 130,
                                              ))
                                        ],
                                      ),
                                    ),
                                    UIConst.width8,
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.name}',
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                          ),
                                          UIConst.height16,
                                          Text(
                                            '\$${item.price}',
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                          ),
                                          UIConst.height16,
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  final quantity = controller.listShoesInCart[index].quantity;
                                                  if (quantity > 1) {
                                                    controller.listShoesInCart[index].quantity =
                                                        controller.listShoesInCart[index].quantity - 1;
                                                    controller.listShoesInCart.refresh();
                                                  } else {
                                                    controller.listShoesInCart.remove(item);
                                                    final indexData = (item.id ?? 0) - 1;
                                                    controller.listData[indexData].hasCart = false;
                                                    controller.listData.refresh();
                                                  }
                                                  controller.caculator();
                                                },
                                                child: CircleAvatar(
                                                    backgroundColor: Colors.grey[100],
                                                    radius: 12,
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                      size: 14,
                                                    )),
                                              ),
                                              UIConst.width8,
                                              Obx(() {
                                                final data = controller.listShoesInCart[index].quantity;
                                                return Text(
                                                  '$data',
                                                );
                                              }),
                                              UIConst.width8,
                                              InkWell(
                                                onTap: () {
                                                  controller.listShoesInCart[index].quantity =
                                                      controller.listShoesInCart[index].quantity + 1;
                                                  controller.listShoesInCart.refresh();
                                                  controller.caculator();
                                                },
                                                child: CircleAvatar(
                                                    backgroundColor: Colors.grey[100],
                                                    radius: 12,
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                      size: 14,
                                                    )),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  controller.listShoesInCart.remove(item);
                                                  final indexData = (item.id ?? 0) - 1;
                                                  controller.listData[indexData].hasCart = false;
                                                  controller.listData.refresh();
                                                  controller.caculator();
                                                },
                                                child: const CircleAvatar(
                                                    backgroundColor: Color(0xfff6c90e),
                                                    radius: 16,
                                                    child: Icon(
                                                      Icons.delete_outlined,
                                                      color: Colors.black,
                                                      size: 14,
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                UIConst.height16
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
