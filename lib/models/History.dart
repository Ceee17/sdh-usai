class HistoryItem {
  final String imageUrl;
  final String title;
  final String date;
  final String category;
  final String finalPrice;
  final String paymentMethod;

  const HistoryItem({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.category,
    required this.finalPrice,
    required this.paymentMethod,
  });
}
