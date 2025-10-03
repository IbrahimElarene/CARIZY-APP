class UpdateUserRequest {
  String? name;
  String? password;

  UpdateUserRequest({this.name, this.password});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }
}