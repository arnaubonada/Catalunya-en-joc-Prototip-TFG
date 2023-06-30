class Item {
  final int image;
  final int price;
  final bool property;
  final String currency;

  const Item(
      {required this.image,
      required this.price,
      this.property = false,
      this.currency = ''});
}
