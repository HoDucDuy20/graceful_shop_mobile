class ProductObject {
  final String title;
  final String img;
  final int price;
  final int favorite;

  ProductObject(this.title, this.img, this.price, this.favorite);

  ProductObject.fromJson(Map<String, dynamic> r)
      : title = r["title"],
        img = r["img"],
        price = r["price"],
        favorite = r["favorite"];
}