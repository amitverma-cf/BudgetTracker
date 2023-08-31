import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import 'search/search_screen.dart';
import 'record/record_screen.dart';
import 'accounts/account_screen.dart';
import 'category/category_screen.dart';

class Index extends StateNotifier<int> {
  Index() : super(0);
  set setValue(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => Index());

const List<Widget> fragments = [
  RecordScreen(),
  SearchScreen(),
  Center(child: Text("Create Budget")),
  AccountScreen(),
  CategoryScreen(),
];

class HomeNavBar extends ConsumerWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(
        icon: Icon(Remix.file_list_3_line), label: 'Record'),
    BottomNavigationBarItem(icon: Icon(Remix.search_2_line), label: 'Search'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add, color: Colors.transparent), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Account'),
    BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books_outlined), label: 'Category'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int menuIndex = ref.watch(indexProvider) as int;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: navItems,
      currentIndex: menuIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: (i) {
        if (i != 2) {
          ref.read(indexProvider.notifier).setValue = i;
        }
      },
    );
  }
}
