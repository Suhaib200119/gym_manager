import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym_manager/Fcm/NotificationManager.dart';
import 'package:gym_manager/core/colorsManager.dart';
import 'package:gym_manager/feature/providers/Shared_Provider.dart';
import 'package:gym_manager/feature/providers/Trainer_Operations.dart';
import 'package:gym_manager/feature/providers/SubscriberOperations.dart';
import 'package:gym_manager/feature/view/Splash_Screen/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'feature/providers/Auth_Provider.dart';
import 'localization/AppLocale.dart';
import 'networks/dioHelper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();// initialize app firebase
  await NotificationManager.fcmInstance.init();

  runApp(MyApp());
  DioHelper.CraeteDio();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) {
          return Auth_Provider();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return Trainer_Operations();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return SubscriberOperations();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return Shared_Provider();
        }),
      ],
      builder: (ctx, child) {
        var shared_Provider = Provider.of<Shared_Provider>(ctx);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: ColorsManager.primaryColor,
          ),
          localizationsDelegates: const [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("ar", ""),
            Locale("en", ""),
          ],
          locale: Locale(shared_Provider.defaultLang, ""),
          home: SplashScreen(),
        );
      },
    );
  }
}
