class Client {
  int? id;
  String? firstName;
  String? lastName;
  int? blocked = 0;

  Client(this.firstName, this.lastName, this.blocked);

  Client.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    blocked = json['blocked'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['blocked'] = blocked;
    return map;
  }
}
