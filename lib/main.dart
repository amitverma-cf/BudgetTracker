import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinance/services/db_const.dart';
import 'package:myfinance/services/models/account.dart';
import 'package:myfinance/services/models/category.dart';
import 'package:myfinance/services/models/record.dart';

import 'common/routes.dart';
import 'common/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(DBConst.themeMode);
  Hive.registerAdapter(RecordAdapter());
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Record>(DBConst.records);
  await Hive.openBox<Account>(DBConst.accounts);
  await Hive.openBox<Category>(DBConst.categories);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(appRouterProvider),
      title: 'My Finance',
      themeMode: ref.watch(appThemeModeProvider),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
