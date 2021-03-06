class Book {
  final String ISBN_13;
  final String title;
  final String? description;
  final String author;
  final DateTime publishedDate;
  final String imageCoverURL;
  final List<String> tags;
  final double tradePrice;
  final double retailPrice;
  final int quantity;

  const Book({
    required this.ISBN_13,
    required this.title,
    this.description,
    required this.author,
    required this.publishedDate,
    required this.imageCoverURL,
    required this.tags,
    required this.tradePrice,
    required this.retailPrice,
    required this.quantity,
  });

  static Book createEmptyBook(String isbn){
    return Book(
      ISBN_13: isbn, 
      title: "", 
      author: "", 
      publishedDate: DateTime.now(), 
      imageCoverURL: "", 
      tags: [], 
      tradePrice: 0, 
      retailPrice: 0, 
      quantity: 0); 
  }

  void toInfo() {
    print(
        "ISBN_13: $ISBN_13, Title: $title, Author: $author, P.Date: ${publishedDate.toString()}, imgCover: $imageCoverURL, tags: $tags, tPrice: $tradePrice, rPrice: $retailPrice, qty: $quantity");
  }
}
