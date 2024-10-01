import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_ecommerce/goggle.dart';

import '../constant/color_constraint.dart';
import '../manager/manage_product.dart';
import '../manager/manage_whistlist.dart';
import '../widgets/sub_text.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final WhistlistController favController = Get.find<WhistlistController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0077b6),
        iconTheme: IconThemeData(
          color: Colors.white,size: 28
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cart",style: myStyle(30,Colors.white),),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Lottie.asset('assets/lottie/emptycart.json', height: 200),
          );
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.blue.withOpacity(0.1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.blue.withOpacity(0.1) ,
                        image: DecorationImage(
                          image: cartController.cartItems[index].imgUrl != null &&
                                  cartController
                                      .cartItems[index].imgUrl.isNotEmpty
                              ? NetworkImage(
                                  cartController.cartItems[index].imgUrl)
                              : AssetImage('assets/images/default_image.png')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cartController.cartItems[index].name,style: myStyle(23),),
                                GestureDetector(
                                  onTap: () {
                                    cartController.removeFromCart(
                                        cartController.cartItems[index]);
                                  },
                                  child: Icon(
                                    Icons.highlight_remove,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("\$ ${cartController.cartItems[index].newPrice}",style: myStyle(21),),
                                Gap(10),
                                Text(
                                  '\$ ${cartController.cartItems[index].oldPrice}',
                                  style: TextStyle(
                                    color: Colors.grey,fontSize: 18,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Gap(10),
                                RegularText(
                                  text:
                                      '${cartController.cartItems[index].newPrice} %OFF',
                                  color: AppColors.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                Gap(10),
                              ],
                            ),
                            Gap(10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cartController.decrementQuantity(
                                        cartController.cartItems[index]);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.remove,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Gap(10),
                                GetBuilder<CartController>(
                                  builder: (controller) {
                                    return RegularText(
                                      text:
                                          '${controller.cartItems[index].quantity}',
                                      fontWeight: FontWeight.w700,
                                      color:Colors.black ,
                                    );
                                  },
                                ),
                                Gap(10),
                                GestureDetector(
                                  onTap: () {
                                    cartController.incrementQuantity(
                                        cartController.cartItems[index]);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(10),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          favController.toggleWishlist(
                                              cartController
                                                  .cartItems[index].id,
                                              cartController.cartItems[index]
                                                  .toMap());
                                          if (favController.isInWishlist(
                                              cartController
                                                  .cartItems[index].id)) {
                                            Get.snackbar(
                                              'Success',
                                              'Product added to wishlist',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.blue,
                                              colorText: Colors.white,
                                              duration: Duration(seconds: 2),
                                            );
                                          } else {
                                            Get.snackbar(
                                              'Removed',
                                              'Product removed from wishlist',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.blue,
                                              colorText: Colors.white,
                                              duration: Duration(seconds: 2),
                                            );
                                          }
                                        },
                                        child:RegularText(
                                          text: favController.isInWishlist(
                                                  cartController
                                                      .cartItems[index].id)
                                              ? 'Un favorite'
                                              : 'Favorite',fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Gap(10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomAppBar(color: Colors.blue.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<CartController>(builder: (controller) {
                  return RegularText(
                    text:
                        'Total: \$${controller.getTotalPrice().toStringAsFixed(2)}',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/new/address');
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: RegularText(
                      text: 'Place Order',
                      color: AppColors.lightGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                    // Text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
