import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

import '../../common/result_snackbar.dart';
import '../../services/db_const.dart';
import '../../services/models/record.dart';

class RecordScreen extends ConsumerWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 136,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ["Expense", "Income", "Total"]
                      .map((data) => Card(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .33 -
                                  16.0,
                              height: 56.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data),
                                  const SizedBox(height: 4.0),
                                  const Text("\$200"),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<Box<Record>>(
                    valueListenable:
                        Hive.box<Record>(DBConst.records).listenable(),
                    builder: (context, box, child) {
                      List<Record> rcds = box.values.toList().cast<Record>();
                      if (rcds.isEmpty) {
                        return const Center(
                          child: Text(
                            "Create a New Record by clicking\non \"+\" Button Below",
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      List<List<Record>> sortedByDateRecordList =
                          sortRecordListByDate(rcds);
                      return ListView.builder(
                        itemCount: sortedByDateRecordList.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              title: Text(DateFormat.yMMMd().format(
                                  sortedByDateRecordList[index][0].time)),
                            ),
                            Column(
                              children: sortedByDateRecordList[index]
                                  .map(
                                    (t) => ListTile(
                                      dense: true,
                                      leading: const CircleAvatar(),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .58,
                                            child: Text(t.notes,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4),
                                          ),
                                          Text("\$ ${t.amount.toString()}")
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${t.category} - ${t.account}"),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Remix.pencil_line),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  var upload = t.delete();
                                                  result(
                                                      upload,
                                                      context,
                                                      "Record deleted succefully",
                                                      'Deletion Failed! Please Retry.');
                                                },
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                icon: const Icon(
                                                    Remix.delete_bin_5_line),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<List<Record>> sortRecordListByDate(List<Record> records) {
  // Group records by date
  Map<DateTime, List<Record>> groupedRecords = {};
  for (var record in records) {
    if (!groupedRecords.containsKey(record.time)) {
      groupedRecords[record.time] = [];
    }
    groupedRecords[record.time]!.add(record);
  }

  // // Sort each group by name
  // groupedRecords.forEach((date, records) {
  //   records.sort((a, b) => a.time.compareTo(b.time));
  // });

  // Create a list of sorted sublists
  List<List<Record>> sortedSublists = groupedRecords.values.toList();
  return sortedSublists;
}
