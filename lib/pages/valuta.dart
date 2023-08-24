class ValutaModel {
  int? id;
  String? code;
  String? ccy;
  String? ccyNmRU;
  String? ccyNmUZ;
  String? ccyNmUZC;
  String? ccyNmEN;
  String? nominal;
  String? rate;
  String? diff;
  String? date;

  ValutaModel({
    this.id,
    this.code,
    this.ccy,
    this.ccyNmRU,
    this.ccyNmUZ,
    this.ccyNmUZC,
    this.ccyNmEN,
    this.nominal,
    this.rate,
    this.diff,
    this.date,
  });

  factory ValutaModel.fromJson(Map<String, Object?> json) => ValutaModel(
    id: json['id'] as int?,
    code: json['Code'] as String?,
    ccy: json['Ccy'] as String?,
    ccyNmRU: json['CcyNm_RU'] as String?,
    ccyNmUZ: json['CcyNm_UZ'] as String?,
    ccyNmUZC: json['CcyNm_UZC'] as String?,
    ccyNmEN: json['CcyNm_EN'] as String?,
    nominal: json['Nominal'] as String?,
    rate: json['Rate'] as String?,
    diff: json['Diff'] as String?,
    date: json['Date'] as String?,
  );
}

