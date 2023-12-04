class ProductDetailModal {
  String? message;
  bool? success;
  int? code;
  List<Data>? data;

  ProductDetailModal({this.message, this.success, this.code, this.data});

  ProductDetailModal.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? size;
  String? sku;
  String? ingridients;
  String? thumbType;
  num? thumbScore;
  String? image;
  String? thumbTypeColor;
  String? store;
  int? storeId;
  String? price;
  String? oldPrice;

  Data(
      {this.id,
        this.name,
        this.description,
        this.size,
        this.sku,
        this.ingridients,
        this.thumbType,
        this.thumbScore,
        this.image,
        this.thumbTypeColor,
        this.store,
        this.storeId,
        this.price,
        this.oldPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    size = json['size'];
    sku = json['sku'];
    ingridients = json['ingridients'];
    thumbType = json['thumb_type'];
    thumbScore = json['thumb_score'];
    image = json['image'];
    thumbTypeColor = json['thumb_type_color'];
    store = json['store'];
    storeId = json['store_id'];
    price = json['price'];
    oldPrice = json['old_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['size'] = this.size;
    data['sku'] = this.sku;
    data['ingridients'] = this.ingridients;
    data['thumb_type'] = this.thumbType;
    data['thumb_score'] = this.thumbScore;
    data['image'] = this.image;
    data['thumb_type_color'] = this.thumbTypeColor;
    data['store'] = this.store;
    data['store_id'] = this.storeId;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    return data;
  }
}
