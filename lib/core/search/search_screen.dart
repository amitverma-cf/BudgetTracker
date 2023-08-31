import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

import '../../services/db_const.dart';
import '../../services/models/record.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .92,
                  child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Record>(DBConst.records).listenable(),
                    builder: (context, box, child) {
                      List<Record> rcds = box.values.toList().cast<Record>();

                      return SearchField(
                        enabled: true,
                        suggestions: rcds
                            .map((rc) => SearchFieldListItem(
                                  "${rc.notes} ${rc.category} ${rc.account} ${rc.amount} ${DateFormat.yMMMd().format(rc.time)} ${rc.type.name}",
                                  child: ListTile(
                                    dense: true,
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    leading: const CircleAvatar(),
                                    title: Text(
                                      rc.notes,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                        "${rc.category} - ${rc.account} - ${DateFormat.yMMMd().format(rc.time)}"),
                                    trailing:
                                        Text("\$ ${rc.amount.toString()}"),
                                  ),
                                ))
                            .toList(),
                        suggestionsDecoration:
                            SuggestionDecoration(boxShadow: const []),
                        suggestionState: Suggestion.hidden,
                        hint: 'Search',
                        searchInputDecoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                        ),
                        maxSuggestionsInViewPort: 8,
                        itemHeight: 80,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
