class KhachHang {
  final String idCustomer;
  final String username;
  final String email;
  final String phone;
  final String address;
  final String birthday;

  KhachHang({
    required this.idCustomer,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.birthday
  });

  factory KhachHang.fromJson(Map<String, dynamic> json) {
    return KhachHang(
        idCustomer: json['id_customer'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        birthday: json['birthday'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id_customer' : idCustomer,
    'username' : username,
    'email' : email,
    'phone' : phone,
    'address' : address,
    'birthday' : birthday,
  };
}