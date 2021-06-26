import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageStateControllerProvider =
    StateNotifierProvider<PageStateController, Pages>(
        (_) => PageStateController());

enum Pages {
  HOME,
  WIDGETS,
  STATE_NOTIFIER,
  GUARDED_BUTTON,
  IMAGE_UPLOAD,
  CLEAR_TEXT,
  WEB_VIEW,
  GYRO_PAGE,
  ACCELEROMETER_PAGE,
  FUNCTION_MACRO,
  PHYSICS,
}

class PageStateController extends StateNotifier<Pages> {
  PageStateController() : super(Pages.HOME);

  setPage(int index) => state = Pages.values[index];
}
