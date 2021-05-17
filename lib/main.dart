import 'package:bikemeter/dashboard.dart';
import 'package:bikemeter/measure_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'app_localizations.dart';

void main() {
  runApp(Bikemeter());
}

class Bikemeter extends StatefulWidget {
  static const String appName = "Bikemeter";

  @override
  _BikemeterState createState() => _BikemeterState();
}

class _BikemeterState extends State<Bikemeter> {
  MeasureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MeasureController();
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return PlatformApp(
      supportedLocales: [
        Locale("en"),
        Locale("de"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        isIOS
            ? GlobalCupertinoLocalizations.delegate
            : GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: selectLocale,
      title: Bikemeter.appName,
      home: PlatformTabScaffold(
        tabController: PlatformTabController(),
        appBarBuilder: createAppBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            label: '', //AppLocalizations.of(context).translate('current'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '', //AppLocalizations.of(context).translate('history'),
          ),
        ],
        bodyBuilder: createContent,
      ),
    );
  }

  dynamic _createButton(BuildContext context, IconData iconData, String label,
      double size, void onPressedCB()) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return SizedBox(
        height: size + 10,
        width: size + 10,
        child: CupertinoButton(
          padding: EdgeInsets.all(1),
          child: Icon(
            iconData,
            size: size,
            semanticLabel: label,
          ),
          onPressed: onPressedCB,
        ),
      );
    }
    return IconButton(
      padding: EdgeInsets.all(1),
      onPressed: onPressedCB,
      icon: Icon(
        iconData,
        size: size,
        semanticLabel: label,
      ),
    );
  }

  PlatformAppBar createAppBar(BuildContext context, int index) {
    return PlatformAppBar(
      title: Text(Bikemeter.appName),
      leading: _createButton(context, Icons.settings,
          AppLocalizations.of(context).translate('settings'), 20, null),
      trailingActions: [
        StreamBuilder(
          initialData: MeasureState.Stopped,
          stream: _controller.stateStream,
          builder:
              (BuildContext context, AsyncSnapshot<MeasureState> snapshot) {
            return Row(
              children: [
                _createButton(
                    context,
                    Icons.stop,
                    AppLocalizations.of(context).translate('stop'),
                    20,
                    getStopCB(snapshot.data)),
                _createButton(
                    context,
                    Icons.pause,
                    AppLocalizations.of(context).translate('pause'),
                    20,
                    getPauseCB(snapshot.data)),
                _createButton(
                    context,
                    Icons.play_circle_fill,
                    AppLocalizations.of(context).translate('start'),
                    40,
                    getStartCB(snapshot.data)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget createContent(BuildContext context, int index) {
    if (index == 0) {
      return SafeArea(
        child: Center(
          child: Dashboard(),
        ),
      );
    } else {
      return SafeArea(
        child: Center(
          child: Text('Second Page'),
        ),
      );
    }
  }

  Locale selectLocale(Locale locale, Iterable<Locale> supportedLocales) {
    if (locale != null) {
      for (Locale l in supportedLocales) {
        if (l.languageCode == locale.languageCode) {
          return l;
        }
      }
    }
    return supportedLocales.first;
  }

  Function getPauseCB(MeasureState state) {
    print('getPauseCB $state');
    if (state == MeasureState.Active) {
      return () {
        _controller.pause();
      };
    }
    return null;
  }

  Function getStopCB(MeasureState state) {
    print('getStopCB $state');
    if (state == MeasureState.Active || state == MeasureState.Paused) {
      return () {
        _controller.stop();
      };
    }
    return null;
  }

  Function getStartCB(MeasureState state) {
    print('getStartCB $state');
    if (state == MeasureState.Stopped || state == MeasureState.Paused) {
      return () {
        _controller.start();
      };
    }
    return null;
  }
}
