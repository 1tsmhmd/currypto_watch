class CurrencyModel {
  String priceStr;
  int price;
  String currency;
  String fa;
  String name;
  String svg;
  int timestamp;
  double usd;

  CurrencyModel({
    required this.priceStr,
    required this.price,
    required this.currency,
    required this.fa,
    required this.name,
    required this.svg,
    required this.timestamp,
    required this.usd,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      priceStr: json['priceStr'],
      price: json['price'] is int
          ? json['price']
          : (json['price'] as num).toInt(),
      currency: json['currency'],
      fa: json['fa'],
      name: json['name'],
      svg: json['svg'],
      timestamp: json['timestamp'],
      usd: (json['usd'] is int)
          ? json['usd'].toDouble()
          : json['usd'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priceStr': priceStr,
      'price': price,
      'currency': currency,
      'fa': fa,
      'name': name,
      'svg': svg,
      'timestamp': timestamp,
      'usd': usd,
    };
  }
}
