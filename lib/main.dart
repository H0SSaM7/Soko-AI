import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sokoai/app/app_constants.dart';

import 'app/my_app.dart';
import 'presentation/resources/constants_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await initAppModule();
  // Bloc.observer = MyBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Future.delayed(const Duration(milliseconds: 300));

// Access your API key as an environment variable (see "Set up your API key" above)
  final model =
      GenerativeModel(model: 'gemini-1.5-flash', apiKey: AppConstants.apiKey);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        ConstantsManager.enLocale,
        ConstantsManager.arLocale
      ],
      path: 'assets/translation',
      fallbackLocale: ConstantsManager.arLocale,
      startLocale: ConstantsManager.arLocale,
      child: const MyApp(),
    ),
  );
}
