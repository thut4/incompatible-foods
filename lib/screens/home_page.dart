import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/controller/home_controller.dart';
import 'package:project_one/utlis/exit_pop_up.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'မတည့်သောအစားအစာများ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'noto'),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    height: 65,
                    child: TextFormField(
                      controller: TextEditingController()
                        ..text = controller.searchQuery.value,
                      // controller: controller.textEditingController,
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                        controller.onSearchQueryChanged(value);
                      },
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'ရှာပါ',
                          suffixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    )),
                const SizedBox(
                  height: 20,
                ),
                // Obx(
                //   () => controller.incomFoods.value.tblIncompatibleFood.isEmpty
                //       ? const Center(
                //           child: CircularProgressIndicator(),
                //         )
                //       : Container(
                //           margin: const EdgeInsets.symmetric(horizontal: 14),
                //           height: 600,
                //           child: ListView.builder(
                //             shrinkWrap: true,
                //             itemCount: controller
                //                 .incomFoods.value.tblIncompatibleFood.length,
                //             itemBuilder: (context, index) {
                //               final item = controller
                //                   .incomFoods.value.tblIncompatibleFood[index];
                //               return ListTile(
                //                 title: Text(
                //                   item.foodA,
                //                   style: TextStyle(
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w500,
                //                       color: Colors.grey[600],
                //                       fontFamily: 'poppins'),
                //                 ),
                //                 leading: Text(
                //                   item.foodB,
                //                   style: TextStyle(
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w500,
                //                       color: Colors.grey[800],
                //                       fontFamily: 'poppins'),
                //                 ),
                //                 trailing: Text(
                //                   item.description,
                //                   style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.w600,
                //                       color: Colors.red[900],
                //                       fontFamily: 'poppins'),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                // ),
                Obx(() => controller.filteredFoods.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        height: 600,
                        child: ListView.builder(
                          itemCount: controller.filteredFoods.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final food = controller.filteredFoods[index];
                            return ListTile(
                              title: Text(
                                food.foodA,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                    fontFamily: 'poppins'),
                              ),
                              leading: Text(
                                food.foodB,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800],
                                    fontFamily: 'poppins'),
                              ),
                              trailing: Text(
                                food.description,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red[900],
                                    fontFamily: 'poppins'),
                              ),
                            );
                          },
                        ),
                      ))
              ],
            ),
          )),
    );
  }
}
