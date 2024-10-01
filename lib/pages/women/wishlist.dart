import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/goggle.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import '../../manager/manage_whistlist.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WhistlistController favController = Get.find<WhistlistController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0077b6),
        title: Text("Favorite",style: myStyle(30,Colors.white),),
        iconTheme: IconThemeData(color: Colors.white,size: 28),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<WhistlistController>(
                builder: (_) {
                  return ListView.builder(
                    itemCount: favController.favItems.length,
                    itemBuilder: (context, index) {
                      final item = favController.favItems[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.1),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 160,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue.withOpacity(0.1),
                                    image: DecorationImage(
                                      image: NetworkImage(item['imgUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item['name'],style: myStyle(25),),
                                        Gap(5),
                                        RegularText(
                                          text: 'By ${item['brand']}',
                                          fontSize: 14,
                                          // color: Colors.grey[600],
                                        ),
                                        Gap(10),
                                        RegularText(
                                          text: '\$${item['newPrice']}',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
