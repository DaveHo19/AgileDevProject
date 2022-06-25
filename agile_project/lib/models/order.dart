class OrderInfo{
  String? orderCode;
  String buyerName;
  String recipientName;
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
    required this.billingAddress, 
    required this.shippingAddress, 
    required this.orderItems,
    required this.orderItemPrices, 
    required this.deliveryFee,
    required this.orderDate,
    }); 

  void toInfo(){
    print("Order Code: $orderCode\nBuyer Name: $buyerName\nRecipient Name: $recipientName\nBilling Adress: $billingAddress\nShipping Address: $shippingAddress\nOrder Items: $orderItems\nOrder Item Price: $orderItemPrices\nDelivery Fee: $deliveryFee\nOrder Date: $orderDate");
  }
}