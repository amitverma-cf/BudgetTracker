import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:myfinance/services/db_const.dart';
import 'package:myfinance/services/models/record.dart';
import 'package:remixicon/remixicon.dart';
import 'package:searchfield/searchfield.dart';

import '../../common/result_snackbar.dart';
import '../../services/models/account.dart';
import '../../services/models/category.dart';

Future<dynamic> createNewRecord(
    BuildContext context,
    DateTime date,
    TextEditingController acctCtrl,
    TextEditingController categCtrl,
    TextEditingController notesCtrl,
    RecordType recordType,
    TextEditingController amtCtrl,
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
          date = DateTime(0);
          acctCtrl.clear();
          categCtrl.clear();
          notesCtrl.clear();
          amtCtrl.clear();
          return Future.value(true);
        },
        child: KeyboardDismissOnTap(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      "Create New Record",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .28,
                            height: 48,
                            child: StatefulBuilder(
                                builder: (BuildContext context, setState) {
                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                child: Text(date != DateTime(0)
                                    ? DateFormat.yMMMd().format(date)
                                    : "Date"),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now().subtract(
                                        const Duration(days: 365 * 80)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365 * 5)),
                                  ).then((value) {
                                    debugPrint(DateFormat.yMMMd()
                                        .format(value ?? DateTime(2000)));
                                    setState(() => date = value ?? DateTime(0));
                                  });
                                },
                              );
                            }),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .28,
                            child: ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<Account>(DBConst.accounts)
                                      .listenable(),
                              builder: (context, box, child) {
                                List<Account> accts =
                                    box.values.toList().cast<Account>();
                                List<String> acctNames = [];
                                for (var i in accts) {
                                  acctNames.add(i.name);
                                }
                                return SearchField(
                                  controller: acctCtrl,
                                  suggestions: acctNames
                                      .map((name) => SearchFieldListItem(name))
                                      .toList(),
                                  suggestionState: Suggestion.expand,
                                  textInputAction: TextInputAction.next,
                                  hint: 'Account',
                                  validator: (x) {
                                    if (!acctNames.contains(x) || x!.isEmpty) {
                                      return 'Please Enter a Valid Account';
                                    }
                                    return null;
                                  },
                                  searchInputDecoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                  ),
                                  maxSuggestionsInViewPort: 6,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .28,
                            child: ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<Category>(DBConst.categories)
                                      .listenable(),
                              builder: (context, box, child) {
                                List<Category> ctgrs =
                                    box.values.toList().cast<Category>();
                                List<String> ctgrName = [];
                                for (var i in ctgrs) {
                                  ctgrName.add(i.name);
                                }
                                return SearchField(
                                  controller: categCtrl,
                                  suggestions: ctgrName
                                      .map((name) => SearchFieldListItem(name))
                                      .toList(),
                                  suggestionState: Suggestion.expand,
                                  textInputAction: TextInputAction.next,
                                  hint: 'Category',
                                  validator: (x) {
                                    if (!ctgrName.contains(x) || x!.isEmpty) {
                                      return 'Please Enter a Valid Account';
                                    }
                                    return null;
                                  },
                                  searchInputDecoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                  ),
                                  maxSuggestionsInViewPort: 6,
                                );
                              },
                            ),
                          ),
                        ]),
                    const SizedBox(height: 8),
                    TextField(
                      controller: notesCtrl,
                      minLines: 5,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        hintText: "Add Notes",
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48,
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                onPressed: () {
                                  setState(() {
                                    if (recordType == RecordType.expense) {
                                      recordType = RecordType.income;
                                    } else if (recordType ==
                                        RecordType.income) {
                                      recordType = RecordType.expense;
                                    }
                                  });
                                },
                                child: Text(recordType.name.toUpperCase()),
                              );
                            }),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: amtCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  hintText: "Enter Amount",
                                  prefix: Text("\$ ")),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .3),
                    const Divider(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            date = DateTime(0);
                            acctCtrl.clear();
                            categCtrl.clear();
                            notesCtrl.clear();
                            amtCtrl.clear();
                            context.pop();
                          },
                          icon: const Icon(Remix.close_line),
                          label: const Text("CANCEL"),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () {
                            TimeOfDay currentTime = TimeOfDay.now();

                            Record record = Record()
                              ..time = date.copyWith(
                                  hour: currentTime.hour,
                                  minute: currentTime.minute)
                              ..account = acctCtrl.text
                              ..category = categCtrl.text
                              ..notes = notesCtrl.text
                              ..type = recordType
                              ..amount = double.tryParse(amtCtrl.text) ?? 0;

                            debugPrint(
                                "${record.account} ${record.category} ${record.notes} ${record.amount} ${record.time}");

                            if (isEditing) {
                              var upload = Hive.box<Record>(DBConst.records)
                                  .putAt(index, record);
                              result(
                                  upload,
                                  context,
                                  "Record edited succefully",
                                  'Editing Failed! Please Retry.');
                            } else {
                              var upload =
                                  Hive.box<Record>(DBConst.records).add(record);
                              result(upload, context, "Record added succefully",
                                  'Adding Failed! Please Retry.');
                            }
                            date = DateTime(0);
                            acctCtrl.clear();
                            categCtrl.clear();
                            notesCtrl.clear();
                            amtCtrl.clear();
                            context.pop();
                          },
                          icon: const Icon(Remix.check_line),
                          label: const Text("SAVE"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
  );
}
