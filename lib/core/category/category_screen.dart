import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinance/services/db_const.dart';
import 'package:remixicon/remixicon.dart';

import '../../common/result_snackbar.dart';
import '../../services/models/category.dart';
import 'create_category.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nmCtrl = TextEditingController();
    TextEditingController imgUrlCtrl = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text("Categories"),
              trailing: OutlinedButton.icon(
                icon: const Icon(Remix.add_line),
                label: const Text("New Category"),
                onPressed: () => createNewCategory(context, nmCtrl, imgUrlCtrl),
              ),
            ),
            ValueListenableBuilder<Box<Category>>(
              valueListenable:
                  Hive.box<Category>(DBConst.categories).listenable(),
              builder: (context, box, _) {
                List<Category> ctgs = box.values.toList().cast<Category>();
                if (ctgs.isEmpty) {
                  return const Center(
                    child: Text("Create a New Category"),
                  );
                }
                return Column(
                  children: ctgs
                      .map(
                        (ctgr) => ListTile(
                          dense: true,
                          leading: const CircleAvatar(),
                          title: Text(ctgr.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  nmCtrl.text = ctgr.name;
                                  imgUrlCtrl.text = ctgr.imgUrl;
                                  int index = ctgs.indexOf(ctgr);
                                  createNewCategory(context, nmCtrl, imgUrlCtrl,
                                      isEditing: true, index: index);
                                },
                                icon: const Icon(Remix.pencil_line),
                              ),
                              IconButton(
                                onPressed: () {
                                  var upload = ctgr.delete();
                                  result(
                                      upload,
                                      context,
                                      "${ctgr.name} deleted succefully",
                                      'Deletion Failed! Please Retry.');
                                },
                                color: Theme.of(context).colorScheme.error,
                                icon: const Icon(Remix.delete_bin_5_line),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
