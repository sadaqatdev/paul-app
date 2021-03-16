class Shipping {
  Shipping({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
      };
}
