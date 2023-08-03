class Product {
  String name;
  String telphone;
  String description;
  String datetime;
  String time;
  int pay;
  String? referenceId;

  static const collestionName = 'products';
  static const colName = 'name';
  static const colDescription = 'description';
  static const colTelphone = 'telphone';
  static const colDatetime = 'datetime';
  static const colTime = 'time';
  static const colPay = 'pay';

  Product({
    required this.name,
    required this.description,
    required this.telphone,
    required this.datetime,
    required this.time,
    required this.pay,
    this.referenceId});

  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{
      colName: name,
      colDescription: description,
      colTelphone: telphone,
      colDatetime: datetime,
      colTime: time,
      colPay: pay
    };
    return mapData;
  }

  Map<String, dynamic> toJson() {
    var jsonData = <String, dynamic>{
      colName: name,
      colDescription: description,
      colTelphone: telphone,
      colDatetime: datetime,
      colTime: time,
      colPay: pay
    };
    return jsonData;
  }
}
