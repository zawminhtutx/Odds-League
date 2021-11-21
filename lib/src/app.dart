import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:odds_league/custom_theme.dart';
import 'package:odds_league/src/favourites/favourite_view.dart';
import 'package:odds_league/src/game_detail/game_detail_view.dart';
import 'package:odds_league/src/home/bloc/game_bloc.dart';
import 'package:odds_league/src/home/data/api_requests/api_requests.dart';

import 'calendar/calendar_view.dart';
import 'home/data/models/game.dart';
import 'home/home_view.dart';
import 'home/home_view_param.dart';
import 'settings/settings_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameBloc gameBloc = GameBloc(ApiRequests());

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            colorScheme:
                const ColorScheme.light(primary: CustomColors.primaryColor),
            iconTheme: const IconThemeData(
              color: CustomColors.primaryColor,
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case GameDetailView.routeName:
                    return _wrapWithBlocProvider(
                      child: GameDetailView(
                        game: routeSettings.arguments as Game,
                      ),
                    );
                  case CalendarView.routeName:
                    return const CalendarView();
                  case FavouriteView.routeName:
                    return _wrapWithBlocProvider(
                      child: const FavouriteView(),
                    );
                  case HomeView.routeName:
                  default:
                    HomeViewParam param =
                        HomeViewParam(date: DateTime.now(), isTopOdds: false);

                    if (routeSettings.arguments != null) {
                      param = routeSettings.arguments as HomeViewParam;
                    }
                    return _wrapWithBlocProvider(
                      child: HomeView(
                        homeViewParam: param,
                      ),
                      date: param.date,
                    );
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _wrapWithBlocProvider({required Widget child, DateTime? date}) {
    if (date != null) {
      gameBloc.add(DateSet(date));
    }

    return BlocProvider.value(
      value: gameBloc,
      child: child,
    );
  }
}
