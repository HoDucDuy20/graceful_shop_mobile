import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/multiple_language/languages/st_en_us.dart';
import 'package:graceful_shop/resources/multiple_language/languages/st_vi_vn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  // ignore: avoid_init_to_null
  static var langCodeValue = null;

  static void setLangCode(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lagCode', langCode);
    langCodeValue = langCode.toString();
    // print('langCodeValue set: ' + langCodeValue);
  }

  // static void getLangCode() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   langCodeValue = prefs.getString('lagCode');
  //   print('langCodeValue get: ' + langCodeValue.toString());
  // }

// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  // ignore: prefer_const_constructors
  static final fallbackLocale = Locale('en', 'US');

// language code của những locale được support
  static final langCodes = [
    'en',
    'vi',
  ];

// các Locale được support
  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

// cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale!);
  }

  // LocalizationService.changeLocale('vi');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    if (langCode == null && langCodeValue != null) {
      langCode = langCodeValue.toString();
    }
    var lang = langCode ?? Get.deviceLocale!.languageCode;
    setLangCode(lang);
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }
}
