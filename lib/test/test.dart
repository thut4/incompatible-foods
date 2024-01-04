import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: TestPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: 75,
              width: double.maxFinite,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: TextFormField(
                controller: controller.textEditingController,
                onChanged: (value) {
                  controller.filterResult();
                },
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Enter Search a Term',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14))),
              ),
            ),
            Expanded(
                child: Obx(
              () => controller.filterList.isEmpty
                  ? const Center(
                      child: Text('Empty!'),
                    )
                  : ListView.builder(
                      itemCount: controller.filterList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.filterList[index]),
                        );
                      },
                    ),
            ))
          ],
        ));
  }
}

class HomeController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  RxList<String> itemList = ['Orange', 'Apple', 'Grape', 'Banana'].obs;
  RxList<String> filterList = List<String>.empty().obs;
  @override
  void onInit() {
    super.onInit();
    filterResult();
  }

  void filterResult() {
    String searchResult = textEditingController.text.toLowerCase();
    filterList.value = itemList
        .where((item) => item.toLowerCase().contains(searchResult))
        .toList();
  }
}
