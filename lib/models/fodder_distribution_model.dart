class FodderDistributionModel {
  // UI Fields
  final int a_kra;
  final String jilha;
  final String taluka;
  final String hangam;
  final String pikacheNav;
  final String van;
  final String ghatakPravarg;
  final double lakshyankKshetraHe;
  final double lakshyankParimanKvin;
  final int labharthiSankhyaLakshyank;
  final double vitaritParimanKvin;
  final int sadhyaLabharthiSankhya;
  final double sadhyaTakkevari;

  // Schema Fields (Nullable/Optional)
  final int? aKra;
  final String? jilhyaacheNaav;
  final double? ekunAarthikTartud;
  final double? tantrikManjuriRakkam;
  final double? shillakRakkam;
  final String? manjuriAadeshKramank;
  final String? dinank;
  final String? puravthaAadeshDinank;
  final String? mahabeejPeek;
  final String? mahabeejVaan;
  final String? mahabeejKharediQuintal;
  final String? nscPeek;
  final String? nscVaan;
  final String? nscKharediQuintal;
  final double? ekunRakkamLaksh;
  final double? apekshitKshetraHectare;
  final double? apekshitUtpadanMeTon;
  final String? shera;

  FodderDistributionModel({
    required this.a_kra,
    required this.jilha,
    required this.taluka,
    required this.hangam,
    required this.pikacheNav,
    required this.van,
    required this.ghatakPravarg,
    required this.lakshyankKshetraHe,
    required this.lakshyankParimanKvin,
    required this.labharthiSankhyaLakshyank,
    required this.vitaritParimanKvin,
    required this.sadhyaLabharthiSankhya,
    required this.sadhyaTakkevari,
    this.aKra,
    this.jilhyaacheNaav,
    this.ekunAarthikTartud,
    this.tantrikManjuriRakkam,
    this.shillakRakkam,
    this.manjuriAadeshKramank,
    this.dinank,
    this.puravthaAadeshDinank,
    this.mahabeejPeek,
    this.mahabeejVaan,
    this.mahabeejKharediQuintal,
    this.nscPeek,
    this.nscVaan,
    this.nscKharediQuintal,
    this.ekunRakkamLaksh,
    this.apekshitKshetraHectare,
    this.apekshitUtpadanMeTon,
    this.shera,
  });
}
