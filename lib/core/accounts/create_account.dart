import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinance/services/models/account.dart';
import 'package:remixicon/remixicon.dart';

import '../../common/result_snackbar.dart';
import '../../services/db_const.dart';

Future<dynamic> createNewAccount(
    BuildContext context,
    TextEditingController amountCtrl,
    TextEditingController nameCtrl,
    TextEditingController imgUrlCtrl,
    {bool isEditing = false,
    int index = 0}) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (context) => WillPopScope(
      onWillPop: () {
        amountCtrl.clear();
        nameCtrl.clear();
        imgUrlCtrl.clear();
        return Future.value(true);
      },
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height:
                isKeyboardVisible ? MediaQuery.of(context).size.height : 300.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create New Account",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      hintText: "Balance Amount",
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      hintText: "Account Name",
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: imgUrlCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      hintText: "Account Image Url",
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      Account acct = Account()
                        ..totalAmount = double.parse(amountCtrl.value.text)
                        ..name = nameCtrl.value.text
                        ..imgUrl = imgUrlCtrl.value.text;
                      if (isEditing) {
                        var upload = Hive.box<Account>(DBConst.accounts)
                            .putAt(index, acct);
                        result(
                            upload,
                            context,
                            "${acct.name} edited succefully",
                            'Editing Failed! Please Retry.');
                      } else {
                        var upload =
                            Hive.box<Account>(DBConst.accounts).add(acct);
                        result(upload, context, "${acct.name} added succefully",
                            'Adding Failed! Please Retry.');
                      }
                      amountCtrl.clear();
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
