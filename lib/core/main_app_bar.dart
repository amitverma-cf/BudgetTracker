import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Remix.apps_2_line),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text("My Finance"),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}
