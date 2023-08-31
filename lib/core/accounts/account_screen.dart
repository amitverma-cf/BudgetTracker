import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remixicon/remixicon.dart';

import '../../common/result_snackbar.dart';
import '../../services/db_const.dart';
import '../../services/models/account.dart';
import 'create_account.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController amtCtrl = TextEditingController();
    TextEditingController nmCtrl = TextEditingController();
    TextEditingController imgUrlCtrl = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Expense So Far this month",
                  "Income So Far this month",
                  "Total Balance this month"
                ]
                    .map((data) => Card(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width * .33 - 24.0,
                            height: 96.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4.0),
                                const Text(
                                  "\$200",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: const Text("Accounts"),
                  trailing: OutlinedButton.icon(
                    icon: const Icon(Remix.add_line),
                    label: const Text("New Account"),
                    onPressed: () =>
                        createNewAccount(context, amtCtrl, nmCtrl, imgUrlCtrl),
                  ),
                ),
                ValueListenableBuilder<Box<Account>>(
                  valueListenable:
                      Hive.box<Account>(DBConst.accounts).listenable(),
                  builder: (context, box, child) {
                    List<Account> accts = box.values.toList().cast<Account>();
                    if (accts.isEmpty) {
                      return const Center(
                        child: Text("Create a New Account"),
                      );
                    }
                    return Column(
                      children: accts
                          .map(
                            (acct) => ListTile(
                              dense: true,
                              leading: const CircleAvatar(),
                              title: Text(acct.name),
                              subtitle: Text(
                                  "Balance: \$ ${acct.totalAmount.toString()}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      amtCtrl.text =
                                          acct.totalAmount.toString();
                                      nmCtrl.text = acct.name;
                                      imgUrlCtrl.text = acct.imgUrl;
                                      int index = accts.indexOf(acct);
                                      createNewAccount(
                                          context, amtCtrl, nmCtrl, imgUrlCtrl,
                                          isEditing: true, index: index);
                                    },
                                    icon: const Icon(Remix.pencil_line),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      var upload = acct.delete();
                                      result(
                                          upload,
                                          context,
                                          "${acct.name} deleted succefully",
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
          ],
        ),
      ),
    );
  }
}
