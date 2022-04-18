import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/app_state/app_state.dart';
import 'package:sante_pour_tous/src/provider/controller.dart';
import 'package:sante_pour_tous/src/provider/theme_provider.dart';
import 'package:sante_pour_tous/src/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class TitleObserver extends RoutemasterObserver {
  @override
  void didChangeRoute(RouteData routeData, Page page) {
    if (page.name != null) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: page.name,
          primaryColor: 0xFF00FF00,
        ),
      );
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Controller()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp.router(
          routerDelegate: RoutemasterDelegate(
            observers: [TitleObserver()],
            routesBuilder: (context) {
              final appState = Provider.of<AppState>(context);
              final isLoggedIn = appState.isLoggedIn;
              print('isLoggedIn $isLoggedIn');
              return isLoggedIn ? Routing().buildRouteMap(appState) : Routing().loggedOutRouteMap;
            },
          ),
          routeInformationParser: const RoutemasterParser(),
          title: 'Santé pour tous',
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
        );
      });
  }
}


