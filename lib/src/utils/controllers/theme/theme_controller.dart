import 'package:gemini_flutter/src/utils/theme/global_theme/global_theme.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  bool get currentTheme => isDarkMode.value;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    Get.changeTheme(
      isDarkMode.value ? GlobalTheme.darkTheme : GlobalTheme.lightTheme,
    );
  }
}
