class SearchModal {
  String? message;
  bool? success;
  int? code;
  List<Data>? data;

  SearchModal({this.message, this.success, this.code, this.data});

  SearchModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? size;
  String? sku;
  String? price;
  String? oldPrice;
  String? store;
  int? storeId;
  String? image;

  Data(
      {this.id,
        this.name,
        this.size,
        this.sku,
        this.price,
        this.oldPrice,
        this.store,
        this.storeId,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    sku = json['sku'];
    price = json['price'];
    oldPrice = json['old_price'];
    store = json['store'];
    storeId = json['store_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['store'] = this.store;
    data['store_id'] = this.storeId;
    data['image'] = this.image;
    return data;
  }
}
