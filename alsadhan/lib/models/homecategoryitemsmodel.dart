class HomeCategoryinfo {
  List<ItemModel> getallcategoris() {
    List<ItemModel> items = new List<ItemModel>();
    items.add(new ItemModel(id: 0, name: 'FRESH', bannerurl: 'url'));
    items.add(new ItemModel(id: 1, name: 'FOOD & BEVERAGES', bannerurl: 'url'));
    items.add(new ItemModel(id: 2, name: 'HEALTHY LIVING', bannerurl: 'url'));
    items.add(new ItemModel(id: 3, name: 'HEALTH & BEAUTY', bannerurl: 'url'));
    items.add(new ItemModel(id: 4, name: 'HOUSEHOLD', bannerurl: 'url'));
    items.add(new ItemModel(id: 5, name: 'BABY', bannerurl: 'url'));
    items.add(new ItemModel(id: 6, name: 'PETS', bannerurl: 'url'));
  }
}

class ItemModel {
  int id;
  String name;
  String bannerurl;

  ItemModel({this.id, this.name, this.bannerurl});
}
