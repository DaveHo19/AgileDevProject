class UserInfomation {
  final String uid;
  final String userName;
  final String emailAddress;

  /*
    account level
    0 = Admin
    1 = Client 
  */
  final int accountLevel;
  
  String? phoneNumber;
  String? gender;

  List<String> wishList;
  Map<String, dynamic> addressMap;

  String? gender;
  String? phoneNumber;
  //future uses
  List<String> orderList;

  UserInfomation({
    required this.uid,
    required this.userName,
    required this.emailAddress,
    required this.accountLevel,
    this.gender,
    this.phoneNumber,
    this.wishList = const [],
    this.addressMap = const {},
    this.orderList = const [],
  });
}
