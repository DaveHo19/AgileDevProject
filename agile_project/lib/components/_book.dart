class Book{
  final String ISBN_13;
  final String title;
  final String? description;
  final String author;
  final String publishedDate;
  final String imageCoverURL;
  final double tradePrice;
  final double retailPrice;
  final int quantity;

  const Book(
    {
      required this.ISBN_13,
      required this.title,
      this.description,
      required this.author,
      required this.publishedDate,
      required this.imageCoverURL,
      required this.tradePrice,
      required this.retailPrice,
      required this.quantity,
    }
  );
}