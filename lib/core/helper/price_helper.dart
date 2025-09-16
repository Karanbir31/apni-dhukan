class PriceHelper {
  static String getOriginalPrice(
    double sellingPrice,
    double discountPercentage,
  ) {
    if (discountPercentage >= 100) {
      throw ArgumentError("Discount percentage cannot be 100 or more.");
    }
    final mrp = sellingPrice / (1 - (discountPercentage / 100));
    return mrp.toStringAsFixed(2);
  }

  static String roundOffPrice(double price) {
    return price.toStringAsFixed(2);
  }
}
