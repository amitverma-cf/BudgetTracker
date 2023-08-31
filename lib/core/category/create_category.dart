import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinance/services/db_const.dart';
import 'package:remixicon/remixicon.dart';

import '../../common/result_snackbar.dart';
import '../../services/models/category.dart';

Future<dynamic> createNewCategory(BuildContext context,
    TextEditingController nameCtrl, TextEditingController imgUrlCtrl,
    {bool isEditing = false, int index = 0}) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (context) => WillPopScope(
      onWillPop: () {
        nameCtrl.clear();
        imgUrlCtrl.clear();
        return Future.value(true);
      },
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height:
                isKeyboardVisible ? MediaQuery.of(context).size.height : 250.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create New Category",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      hintText: "Category Name",
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // TextField(
                  //   controller: imgUrlCtrl,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(16.0))),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  //     hintText: "Category Image Url",
                  //   ),
                  // ),
                  const SizedBox(height: 8.0),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      Category category = Category()
                        ..name = nameCtrl.value.text
                        ..imgUrl = imgUrlCtrl.value.text;
                      if (isEditing) {
                        var upload = Hive.box<Category>(DBConst.categories)
                            .putAt(index, category);
                        result(
                            upload,
                            context,
                            "${category.name} edited succefully",
                            'Editing Failed! Please Retry.');
                      } else {
                        var upload = Hive.box<Category>(DBConst.categories)
                            .add(category);
                        result(
                            upload,
                            context,
                            "${category.name} added succefully",
                            'Adding Failed! Please Retry.');
                      }
                      nameCtrl.clear();
                      imgUrlCtrl.clear();
                      context.pop();
                    },
                    icon: const Icon(Remix.save_2_line),
                    label: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
