
class UserModel {
  String name;
  String id;
  String phone;
  List<String> location;
  int banScore;
  List<String> favCategory;
  String password;
  UserModel({
    this.location,
    this.id,
    this.banScore = 0,
    this.favCategory,
    this.name,
    this.phone,
    this.password,
  });
}
