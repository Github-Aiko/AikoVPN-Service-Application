import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aiko/constant/app_colors.dart';
import 'package:aiko/constant/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:aiko/models/app_model.dart';
import 'package:aiko/models/plan_model.dart';
import 'package:aiko/models/server_model.dart';
import 'package:aiko/models/user_subscribe_model.dart';
import 'package:aiko/router/application.dart';
import 'package:aiko/router/routers.dart';
import 'package:aiko/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appModel = AppModel();
  var userViewModel = UserModel();
  var userSubscribeModel = UserSubscribeModel();
  var serverModel = ServerModel();
  var planModel = PlanModel();

  await userViewModel.refreshData();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppModel>.value(value: appModel),
    ChangeNotifierProvider<UserModel>.value(value: userViewModel),
    ChangeNotifierProvider<UserSubscribeModel>.value(value: userSubscribeModel),
    ChangeNotifierProvider<ServerModel>.value(value: serverModel),
    ChangeNotifierProvider<PlanModel>.value(value: planModel)
  ], child: aikoApp()));
}

class aikoApp extends StatelessWidget {
  aikoApp({Key? key}) : super(key: key) {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppModel appModel = Provider.of<AppModel>(context);

    services.SystemChrome.setPreferredOrientations(
        [services.DeviceOrientation.portraitUp, services.DeviceOrientation.portraitDown]);

    return MaterialApp(
      // <--- /!\ Add the builder
      title: AppStrings.appName,
      navigatorKey: Application.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router?.generator,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
        Locale('en', 'US'), 
        Locale('zh', 'CN'),
        Locale('ja', 'JP'),
        Locale('ko', 'KR'),
      ],
      theme: appModel.themeData,
    );
  }
}
