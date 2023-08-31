import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import '../common/themes.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      width: 320.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Text("T"),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text.rich(
                              TextSpan(
                                text: "Amit Verma",
                                children: [
                                  TextSpan(
                                      text: "\n",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal),
                                      children: [
                                        TextSpan(
                                            text: "ava.amitverma@gmail.com"),
                                      ]),
                                ],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              softWrap: false,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(appThemeModeProvider.notifier)
                                  .toggleTheme();
                            },
                            icon: Icon(colorScheme.brightness == Brightness.dark
                                ? Remix.sun_fill
                                : Remix.moon_fill),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text("Preferences"),
                  leading: const Icon(Remix.phone_line),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Backup & Restore"),
                  leading: const Icon(Remix.settings_2_line),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text("Invite Friends"),
                  leading: const Icon(Remix.user_add_line),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Help"),
                  leading: const Icon(Remix.question_line),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
