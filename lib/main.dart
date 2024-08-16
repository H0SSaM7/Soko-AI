import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokoai/app/di.dart';

import 'app/bloc_observer.dart';
import 'app/my_app.dart';
import 'presentation/resources/constants_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModules();
  // Bloc.observer = MyBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Bloc.observer = MyBlocObserver();
  await Future.delayed(const Duration(milliseconds: 300));

  runApp(
    EasyLocalization(
      supportedLocales: const [
        ConstantsManager.enLocale,
        ConstantsManager.arLocale
      ],
      path: 'assets/translation',
      fallbackLocale: ConstantsManager.enLocale,
      startLocale: ConstantsManager.enLocale,
      child: const MyApp(),
    ),
  );
}
