import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../models/fodder_distribution_model.dart';
import '../data/records_provider.dart';

class AddRecordScreen extends ConsumerStatefulWidget {
  const AddRecordScreen({super.key});

  @override
  ConsumerState<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends ConsumerState<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();

  // 18 Controllers representing the exact fields requested
  final TextEditingController _aKraCtrl = TextEditingController();
  final TextEditingController _jilhyaacheNaavCtrl = TextEditingController();
  final TextEditingController _ekunAarthikTartudCtrl = TextEditingController();
  final TextEditingController _tantrikManjuriRakkamCtrl = TextEditingController();
  final TextEditingController _shillakRakkamCtrl = TextEditingController();
  final TextEditingController _manjuriAadeshKramankCtrl = TextEditingController();
  final TextEditingController _dinankCtrl = TextEditingController();
  final TextEditingController _puravthaAadeshDinankCtrl = TextEditingController();
  final TextEditingController _mahabeejPeekCtrl = TextEditingController();
  final TextEditingController _mahabeejVaanCtrl = TextEditingController();
  final TextEditingController _mahabeejKharediCtrl = TextEditingController();
  final TextEditingController _nscPeekCtrl = TextEditingController();
  final TextEditingController _nscVaanCtrl = TextEditingController();
  final TextEditingController _nscKharediCtrl = TextEditingController();
  final TextEditingController _ekunRakkamLakshCtrl = TextEditingController();
  final TextEditingController _apekshitKshetraCtrl = TextEditingController();
  final TextEditingController _apekshitUtpadanMeTonCtrl = TextEditingController();
  final TextEditingController _sheraCtrl = TextEditingController();

  @override
  void dispose() {
    _aKraCtrl.dispose();
    _jilhyaacheNaavCtrl.dispose();
    _ekunAarthikTartudCtrl.dispose();
    _tantrikManjuriRakkamCtrl.dispose();
    _shillakRakkamCtrl.dispose();
    _manjuriAadeshKramankCtrl.dispose();
    _dinankCtrl.dispose();
    _puravthaAadeshDinankCtrl.dispose();
    _mahabeejPeekCtrl.dispose();
    _mahabeejVaanCtrl.dispose();
    _mahabeejKharediCtrl.dispose();
    _nscPeekCtrl.dispose();
    _nscVaanCtrl.dispose();
    _nscKharediCtrl.dispose();
    _ekunRakkamLakshCtrl.dispose();
    _apekshitKshetraCtrl.dispose();
    _apekshitUtpadanMeTonCtrl.dispose();
    _sheraCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  String? _validateRequired(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  String? _validateNumeric(String? value, String requiredMessage, String numericMessage) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    if (double.tryParse(value) == null) {
      return numericMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final translations = ref.watch(translationsProvider);
    
    // Quick translation helper
    String t(String key) => translations[key] ?? key;

    final String requiredMsg = t('validationRequired');
    final String numericMsg = t('validationNumber');

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SECTION 1: Regional & Financial Information
              _buildCardSection(
                title: t('section_financial'),
                children: [
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _aKraCtrl,
                      labelText: t('aKra'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                    _buildTextFormField(
                      controller: _jilhyaacheNaavCtrl,
                      labelText: t('jilhyaacheNaav'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _ekunAarthikTartudCtrl,
                      labelText: t('ekunAarthikTartud'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                    _buildTextFormField(
                      controller: _tantrikManjuriRakkamCtrl,
                      labelText: t('tantrikManjuriRakkam'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                  ]),
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _shillakRakkamCtrl,
                      labelText: t('shillakRakkam'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                    _buildTextFormField(
                      controller: _manjuriAadeshKramankCtrl,
                      labelText: t('manjuriAadeshKramank'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                  _buildResponsiveRow(context, [
                    _buildDateFormField(
                      context: context,
                      controller: _dinankCtrl,
                      labelText: t('dinank'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                    _buildDateFormField(
                      context: context,
                      controller: _puravthaAadeshDinankCtrl,
                      labelText: t('puravthaAadeshDinank'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 20),

              // SECTION 2: Seed Supply Details (Mahabeej & NSC)
              _buildCardSection(
                title: t('section_seeds'),
                children: [
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _mahabeejPeekCtrl,
                      labelText: t('mahabeejPeek'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                    _buildTextFormField(
                      controller: _mahabeejVaanCtrl,
                      labelText: t('mahabeejVaan'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _mahabeejKharediCtrl,
                      labelText: t('mahabeejKharediQuintal'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                    _buildTextFormField(
                      controller: _nscPeekCtrl,
                      labelText: t('nscPeek'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _nscVaanCtrl,
                      labelText: t('nscVaan'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                    _buildTextFormField(
                      controller: _nscKharediCtrl,
                      labelText: t('nscKharediQuintal'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 20),

              // SECTION 3: Expected Outcomes & Remarks
              _buildCardSection(
                title: t('section_outcomes'),
                children: [
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _ekunRakkamLakshCtrl,
                      labelText: t('ekunRakkamLaksh'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                    _buildTextFormField(
                      controller: _apekshitKshetraCtrl,
                      labelText: t('apekshitKshetraHectare'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                  ]),
                  _buildResponsiveRow(context, [
                    _buildTextFormField(
                      controller: _apekshitUtpadanMeTonCtrl,
                      labelText: t('apekshitUtpadanMeTon'),
                      keyboardType: TextInputType.number,
                      validator: (val) => _validateNumeric(val, requiredMsg, numericMsg),
                    ),
                    _buildTextFormField(
                      controller: _sheraCtrl,
                      labelText: t('shera'),
                      validator: (val) => _validateRequired(val, requiredMsg),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 32),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create a concrete record mapping form inputs to DB structure
                      final int codeA = int.tryParse(_aKraCtrl.text) ?? 0;
                      final newRecord = FodderDistributionModel(
                        // UI Properties mapping
                        a_kra: codeA,
                        jilha: _jilhyaacheNaavCtrl.text,
                        taluka: 'नमुद नाही',
                        hangam: 'खरीप/रब्बी',
                        pikacheNav: _mahabeejPeekCtrl.text.isNotEmpty 
                            ? _mahabeejPeekCtrl.text 
                            : _nscPeekCtrl.text,
                        van: _mahabeejVaanCtrl.text.isNotEmpty 
                            ? _mahabeejVaanCtrl.text 
                            : _nscVaanCtrl.text,
                        ghatakPravarg: 'सर्वसाधारण',
                        lakshyankKshetraHe: double.tryParse(_apekshitKshetraCtrl.text) ?? 0.0,
                        lakshyankParimanKvin: double.tryParse(_mahabeejKharediCtrl.text) ?? 0.0,
                        labharthiSankhyaLakshyank: 100,
                        vitaritParimanKvin: double.tryParse(_mahabeejKharediCtrl.text) ?? 0.0,
                        sadhyaLabharthiSankhya: 80,
                        sadhyaTakkevari: 100.0,

                        // Schema Properties
                        aKra: codeA,
                        jilhyaacheNaav: _jilhyaacheNaavCtrl.text,
                        ekunAarthikTartud: double.tryParse(_ekunAarthikTartudCtrl.text),
                        tantrikManjuriRakkam: double.tryParse(_tantrikManjuriRakkamCtrl.text),
                        shillakRakkam: double.tryParse(_shillakRakkamCtrl.text),
                        manjuriAadeshKramank: _manjuriAadeshKramankCtrl.text,
                        dinank: _dinankCtrl.text,
                        puravthaAadeshDinank: _puravthaAadeshDinankCtrl.text,
                        mahabeejPeek: _mahabeejPeekCtrl.text,
                        mahabeejVaan: _mahabeejVaanCtrl.text,
                        mahabeejKharediQuintal: _mahabeejKharediCtrl.text,
                        nscPeek: _nscPeekCtrl.text,
                        nscVaan: _nscVaanCtrl.text,
                        nscKharediQuintal: _nscKharediCtrl.text,
                        ekunRakkamLaksh: double.tryParse(_ekunRakkamLakshCtrl.text),
                        apekshitKshetraHectare: double.tryParse(_apekshitKshetraCtrl.text),
                        apekshitUtpadanMeTon: double.tryParse(_apekshitUtpadanMeTonCtrl.text),
                        shera: _sheraCtrl.text,
                      );

                      // Save to global provider
                      ref.read(recordsProvider.notifier).update((state) => [...state, newRecord]);

                      // Clear input values
                      _formKey.currentState!.reset();
                      _aKraCtrl.clear();
                      _jilhyaacheNaavCtrl.clear();
                      _ekunAarthikTartudCtrl.clear();
                      _tantrikManjuriRakkamCtrl.clear();
                      _shillakRakkamCtrl.clear();
                      _manjuriAadeshKramankCtrl.clear();
                      _dinankCtrl.clear();
                      _puravthaAadeshDinankCtrl.clear();
                      _mahabeejPeekCtrl.clear();
                      _mahabeejVaanCtrl.clear();
                      _mahabeejKharediCtrl.clear();
                      _nscPeekCtrl.clear();
                      _nscVaanCtrl.clear();
                      _nscKharediCtrl.clear();
                      _ekunRakkamLakshCtrl.clear();
                      _apekshitKshetraCtrl.clear();
                      _apekshitUtpadanMeTonCtrl.clear();
                      _sheraCtrl.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(t('successMessage')),
                          backgroundColor: AppColors.primaryGreen,
                        ),
                      );
                    }
                  },
                  child: Text(
                    t('saveButton'),
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Card wrapper to logically group form fields
  Widget _buildCardSection({required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkBlue),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  // Responsive layout row displaying two inputs side by side on wide screens, or vertically on mobile
  Widget _buildResponsiveRow(BuildContext context, List<Widget> children) {
    final double width = MediaQuery.of(context).size.width;
    if (width >= 600) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
              .map((child) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: child,
                    ),
                  ))
              .toList(),
        ),
      );
    } else {
      return Column(
        children: children
            .map((child) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: child,
                ))
            .toList(),
      );
    }
  }

  // Text input widget styling matching modern green theme guidelines
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14, color: AppColors.textLight),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  // Date picker field design
  Widget _buildDateFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14, color: AppColors.textLight),
        suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryGreen, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: () => _selectDate(context, controller),
      validator: validator,
    );
  }
}
