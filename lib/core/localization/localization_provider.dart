import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Locale selection: 'mr' (default) or 'en'
final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<String> {
  LocaleNotifier() : super('mr');

  void setLocale(String locale) {
    if (locale == 'mr' || locale == 'en') {
      state = locale;
    }
  }

  void toggleLocale() {
    state = state == 'mr' ? 'en' : 'mr';
  }
}

// Translations state provider
final translationsProvider = StateNotifierProvider<TranslationsNotifier, Map<String, String>>((ref) {
  final locale = ref.watch(localeProvider);
  return TranslationsNotifier(locale);
});

class TranslationsNotifier extends StateNotifier<Map<String, String>> {
  final String locale;

  TranslationsNotifier(this.locale) : super(locale == 'mr' ? _fallbackMarathi : _fallbackEnglish) {
    _loadTranslations();
  }

  Future<void> _loadTranslations() async {
    try {
      final jsonString = await rootBundle.loadString('assets/translations/$locale.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      state = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      debugPrint('Failed to load translations for $locale: $e');
    }
  }
}

// Synchronous default fallbacks to prevent screen flicker during load
const Map<String, String> _fallbackMarathi = {
  "appTitle": "चारा वितरण व्यवस्थापन प्रणाली",
  "dashboardTitle": "डॅशबोर्ड (Dashboard)",
  "viewRecordsTitle": "सर्व नोंदी पहा (View Records)",
  "addRecordTitle": "नवीन नोंद जोडा (Add Record)",
  "adminTitle": "प्रशासकीय पॅनेल (Admin)",
  "mapTitle": "नकाशा व्ह्यू (Map View)",
  "logout": "लॉगआउट (Logout)",
  "saveButton": "माहिती जतन करा",
  "successMessage": "नोंद यशस्वीरित्या जतन केली!",
  "validationRequired": "कृपया हे क्षेत्र रिकामे सोडू नका",
  "validationNumber": "कृपया वैध संख्या प्रविष्ट करा",
  "optionalText": "(पर्यायी)",
  "selectDate": "दिनांक निवडा",
  "aKra": "अ.क्र.",
  "jilhyaacheNaav": "जिल्हयाचे नांव",
  "ekunAarthikTartud": "एकूण उपलब्ध आर्थिक तरतूद (लाख रू.)",
  "tantrikManjuriRakkam": "तांत्रिक मंजूरीची रक्कम (लाख रू.)",
  "shillakRakkam": "शिल्लक रक्कम (लाख रू.)",
  "manjuriAadeshKramank": "मंजूरी आदेशाचा जावक क्रमांक",
  "dinank": "दिनांक",
  "puravthaAadeshDinank": "बियाणे पुरवठा आदेश दिनांक",
  "mahabeejPeek": "महाबीज - पीक",
  "mahabeejVaan": "महाबीज - वाण",
  "mahabeejKharediQuintal": "महाबीज - बियाणे खरेदी (क्विंटल)",
  "nscPeek": "एनएससी - पीक",
  "nscVaan": "एनएससी - वाण",
  "nscKharediQuintal": "एनएससी - बियाणे खरेदी (क्विंटल)",
  "ekunRakkamLaksh": "एकूण रक्कम (लाख रू.)",
  "apekshitKshetraHectare": "अपेक्षित क्षेत्र (हेक्टर)",
  "apekshitUtpadanMeTon": "अपेक्षित उत्पादन (मे. टन)",
  "shera": "शेरा",
  "section_financial": "१. प्रादेशिक आणि आर्थिक माहिती",
  "section_seeds": "२. बियाणे पुरवठा माहिती (महाबीज आणि एनएससी)",
  "section_outcomes": "३. अपेक्षित साध्य परिमाण आणि शेरा"
};

const Map<String, String> _fallbackEnglish = {
  "appTitle": "Fodder Distribution System",
  "dashboardTitle": "Dashboard",
  "viewRecordsTitle": "View Records",
  "addRecordTitle": "Add Record",
  "adminTitle": "Admin Panel",
  "mapTitle": "Map View",
  "logout": "Logout",
  "saveButton": "Save Information",
  "successMessage": "Record saved successfully!",
  "validationRequired": "Please enter a value for this field",
  "validationNumber": "Please enter a valid number",
  "optionalText": "(Optional)",
  "selectDate": "Select Date",
  "aKra": "Sr. No.",
  "jilhyaacheNaav": "District Name",
  "ekunAarthikTartud": "Total Available Financial Provision (Lakhs)",
  "tantrikManjuriRakkam": "Technical Sanction Amount (Lakhs)",
  "shillakRakkam": "Balance Amount (Lakhs)",
  "manjuriAadeshKramank": "Sanction Order Outward No.",
  "dinank": "Date",
  "puravthaAadeshDinank": "Seed Supply Order Date",
  "mahabeejPeek": "Mahabeej - Crop",
  "mahabeejVaan": "Mahabeej - Variety",
  "mahabeejKharediQuintal": "Mahabeej - Seed Purchase (Quintals)",
  "nscPeek": "NSC - Crop",
  "nscVaan": "NSC - Variety",
  "nscKharediQuintal": "NSC - Seed Purchase (Quintals)",
  "ekunRakkamLaksh": "Total Amount (Lakhs)",
  "apekshitKshetraHectare": "Expected Area (Hectares)",
  "apekshitUtpadanMeTon": "Expected Production (Metric Tons)",
  "shera": "Remarks",
  "section_financial": "1. Regional & Financial Information",
  "section_seeds": "2. Seed Supply Details (Mahabeej & NSC)",
  "section_outcomes": "3. Expected Area, Production & Remarks"
};
