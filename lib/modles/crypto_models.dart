class CryptoModel {
  String? name;
  String? fa;
  num? price;
  String? priceStr;
  String? logo;
  String? symbol;
  int? timestamp;

  CryptoModel(
      {this.name,
      this.fa,
      this.price,
      this.priceStr,
      this.logo,
      this.symbol,
      this.timestamp});

  CryptoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fa = json['fa'];
    price = json['price'];
    priceStr = json['priceStr'];
    logo = json['logo'];
    symbol = json['symbol'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['fa'] = fa;
    data['price'] = price;
    data['priceStr'] = priceStr;
    data['logo'] = logo;
    data['symbol'] = symbol;
    data['timestamp'] = timestamp;
    return data;
  }
}
