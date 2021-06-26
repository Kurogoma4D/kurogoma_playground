import 'package:KRPG/page_state_controller.dart';
import 'package:KRPG/pages/accelerometer_page.dart';
import 'package:KRPG/pages/counter_page.dart';
import 'package:KRPG/pages/function_macro_page.dart';
import 'package:KRPG/pages/guarded_button_page.dart';
import 'package:KRPG/pages/gyro_sensor_page.dart';
import 'package:KRPG/pages/image_upload.dart';
import 'package:KRPG/pages/physics_page.dart';
import 'package:KRPG/pages/unfocus_clear_text_page.dart';
import 'package:KRPG/pages/webview_page.dart';
import 'package:KRPG/pages/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'drawer.dart';
import 'package:flutter/material.dart';
import 'pages/ideas.dart';
import 'custom_theme.dart';
import 'page_state_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey,
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text("IDEAS"),
          ),
          drawer: Drawer(
            child: DrawerMenu(),
          ),
          body: const _Contents(),
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}

class _Contents extends ConsumerWidget {
  const _Contents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(pageStateControllerProvider);
    switch (state) {
      case Pages.HOME:
        return IdeasPage();
      case Pages.WIDGETS:
        return WidgetTestPage();
      case Pages.STATE_NOTIFIER:
        return CounterPage();
      case Pages.GUARDED_BUTTON:
        return GuardedButtonPage();
      case Pages.IMAGE_UPLOAD:
        return ImageUploadPage();
      case Pages.CLEAR_TEXT:
        return UnFocusClearText.wrapped();
      case Pages.WEB_VIEW:
        return WebViewPage.wrapped();
      case Pages.GYRO_PAGE:
        return GyroSensorPage();
      case Pages.ACCELEROMETER_PAGE:
        return AccelerometerPage();
      case Pages.FUNCTION_MACRO:
        return FunctionMacroPage();
      case Pages.PHYSICS:
        return PhysicsPage();
      default:
        return IdeasPage();
    }
  }
}
