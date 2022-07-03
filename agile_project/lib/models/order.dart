class OrderInfo{
  String? orderCode;
  String buyerName;
  String recipientName;
  String contactNumber;
  String billingAddress;
  String shippingAddress;
  Map<String, int> orderItems;
  double orderItemPrices;
  int deliveryFee; 
  DateTime orderDate; 
  
  OrderInfo({
    this.orderCode,
    required this.buyerName, 
    required this.recipientName, 
    required this.contactNumber,
    required this.billingAddress, 
    required this.shippingAddress, 
    required this.orderItems,
    required this.orderItemPrices, 
    required this.deliveryFee,
    required this.orderDate,
    }); 

  static OrderInfo createEmpty(String code){
    return OrderInfo(
      orderCode: code,
      buyerName: "", 
      recipientName: "", 
      contactNumber: "", 
      billingAddress: "", 
      shippingAddress: "", 
      orderItems: {}, 
      orderItemPrices: 0, 
      deliveryFee: 0,
      orderDate: DateTime.now());
  }
  void toInfo(){
    print("Order Code: $orderCode\nBuyer Name: $buyerName\nRecipient Name: $recipientName\nContact Number: $contactNumber\nBilling Adress: $billingAddress\nShipping Address: $shippingAddress\nOrder Items: $orderItems\nOrder Item Price: $orderItemPrices\nDelivery Fee: $deliveryFee\nOrder Date: $orderDate");
  }
}