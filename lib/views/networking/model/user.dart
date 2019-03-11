class UserResponse {
  List<User> users;
  Info info;
  final String error;

  UserResponse(this.users, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : users = (json["results"] as List).map((i) {
          new User.fromJson(i);
        }).toList(),
        error = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['results'] = this.users.map((v) => v.toJson()).toList();
    }
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }

  UserResponse.withError(String errorValue)
      : users = List(),
        error = errorValue;
}

class User {
  String nat;
  String gender;
  String phone;
  Dob dob;
  Name name;
  Registered registered;
  Location location;
  Id id;
  Login login;
  String cell;
  String email;
  Picture picture;

  User(
      {this.nat,
      this.gender,
      this.phone,
      this.dob,
      this.name,
      this.registered,
      this.location,
      this.id,
      this.login,
      this.cell,
      this.email,
      this.picture});

  User.fromJson(Map<String, dynamic> json) {
    nat = json['nat'];
    gender = json['gender'];
    phone = json['phone'];
    dob = json['dob'] != null ? new Dob.fromJson(json['dob']) : null;
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    registered = json['registered'] != null ? new Registered.fromJson(json['registered']) : null;
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    login = json['login'] != null ? new Login.fromJson(json['login']) : null;
    cell = json['cell'];
    email = json['email'];
    picture = json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nat'] = this.nat;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    if (this.dob != null) {
      data['dob'] = this.dob.toJson();
    }
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.registered != null) {
      data['registered'] = this.registered.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    if (this.login != null) {
      data['login'] = this.login.toJson();
    }
    data['cell'] = this.cell;
    data['email'] = this.email;
    if (this.picture != null) {
      data['picture'] = this.picture.toJson();
    }
    return data;
  }
}

class Dob {
  String date;
  int age;

  Dob({this.date, this.age});

  Dob.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['age'] = this.age;
    return data;
  }
}

class Name {
  String last;
  String title;
  String first;

  Name({this.last, this.title, this.first});

  Name.fromJson(Map<String, dynamic> json) {
    last = json['last'];
    title = json['title'];
    first = json['first'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last'] = this.last;
    data['title'] = this.title;
    data['first'] = this.first;
    return data;
  }
}

class Registered {
  String date;
  int age;

  Registered({this.date, this.age});

  Registered.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['age'] = this.age;
    return data;
  }
}

class Location {
  String city;
  String street;
  LocationTimezone timezone;
  int postcode;
  LocationCoordinates coordinates;
  String state;

  Location({this.city, this.street, this.timezone, this.postcode, this.coordinates, this.state});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    street = json['street'];
    timezone = json['timezone'] != null ? new LocationTimezone.fromJson(json['timezone']) : null;
    postcode = json['postcode'];
    coordinates = json['coordinates'] != null ? new LocationCoordinates.fromJson(json['coordinates']) : null;
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['street'] = this.street;
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['postcode'] = this.postcode;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['state'] = this.state;
    return data;
  }
}

class LocationTimezone {
  String offset;
  String description;

  LocationTimezone({this.offset, this.description});

  LocationTimezone.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['description'] = this.description;
    return data;
  }
}

class LocationCoordinates {
  String latitude;
  String longitude;

  LocationCoordinates({this.latitude, this.longitude});

  LocationCoordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Id {
  String name;
  String value;

  Id({this.name, this.value});

  Id.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Login {
  String sha1;
  String password;
  String salt;
  String sha256;
  String uuid;
  String username;
  String md5;

  Login({this.sha1, this.password, this.salt, this.sha256, this.uuid, this.username, this.md5});

  Login.fromJson(Map<String, dynamic> json) {
    sha1 = json['sha1'];
    password = json['password'];
    salt = json['salt'];
    sha256 = json['sha256'];
    uuid = json['uuid'];
    username = json['username'];
    md5 = json['md5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sha1'] = this.sha1;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['sha256'] = this.sha256;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['md5'] = this.md5;
    return data;
  }
}

class Picture {
  String thumbnail;
  String large;
  String medium;

  Picture({this.thumbnail, this.large, this.medium});

  Picture.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class Info {
  String seed;
  int page;
  int results;
  String version;

  Info({this.seed, this.page, this.results, this.version});

  Info.fromJson(Map<String, dynamic> json) {
    seed = json['seed'];
    page = json['page'];
    results = json['results'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seed'] = this.seed;
    data['page'] = this.page;
    data['results'] = this.results;
    data['version'] = this.version;
    return data;
  }
}
