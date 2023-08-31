import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfinance/core/main_drawer.dart';
import 'package:myfinance/core/record/create_record.dart';
import 'package:myfinance/services/models/record.dart';
import 'package:remixicon/remixicon.dart';

import 'main_app_bar.dart';
import 'main_navbart.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime date = DateTime(0);
    TextEditingController acctCtrl = TextEditingController();
    TextEditingController categCtrl = TextEditingController();
    TextEditingController notesCtrl = TextEditingController();
    RecordType recordType = RecordType.expense;
    TextEditingController amtCtrl = TextEditingController();
    return Scaffold(
      drawerEdgeDragWidth: 200.0,
      drawer: const HomeDrawer(),
      appBar: const MainAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewRecord(
            context, date, acctCtrl, categCtrl, notesCtrl, recordType, amtCtrl),
        child: const Icon(Remix.add_line),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const HomeNavBar(),
      body: fragments[ref.watch(indexProvider) as int],
    );
  }
}
