import 'dart:convert';

IncomFoods incomFoodsFromJson(String str) =>
    IncomFoods.fromJson(json.decode(str));
String incomFoodsToJson(IncomFoods data) => json.encode(data.toJson());

class IncomFoods {
  final List<TblIncompatibleFood> tblIncompatibleFood;

  IncomFoods({
    required this.tblIncompatibleFood,
  });

  factory IncomFoods.fromJson(Map<String, dynamic> json) => IncomFoods(
        tblIncompatibleFood: List<TblIncompatibleFood>.from(
            json["Tbl_IncompatibleFood"]
                .map((x) => TblIncompatibleFood.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Tbl_IncompatibleFood":
            List<dynamic>.from(tblIncompatibleFood.map((x) => x.toJson())),
      };
}

class TblIncompatibleFood {
  final int id;
  final String foodA;
  final String foodB;
  final String description;

  TblIncompatibleFood({
    required this.id,
    required this.foodA,
    required this.foodB,
    required this.description,
  });

  factory TblIncompatibleFood.fromJson(Map<String, dynamic> json) =>
      TblIncompatibleFood(
        id: json["Id"],
        foodA: json["FoodA"],
        foodB: json["FoodB"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "FoodA": foodA,
        "FoodB": foodB,
        "Description": description,
      };
}
