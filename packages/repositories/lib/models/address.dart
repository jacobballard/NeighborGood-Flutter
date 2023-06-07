class Address {
  final String? address_line_1;
  final String? address_line_2;
  final String? city;
  final String state;
  final String zip;

  Address(this.address_line_1, this.address_line_2, this.city, this.state,
      this.zip);

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      json['address_line_1'],
      json['address_line_2'],
      json['city'],
      json['state'],
      json['zip'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line_1'] = this.address_line_1;
    data['address_line_2'] = this.address_line_2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    return data;
  }
}
