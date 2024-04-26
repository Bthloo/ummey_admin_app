
class MealModel{
  static const String collectionName = 'meal';
  String? id;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  MealModel({this.id,this.name,this.description,this.price,this.imageUrl});

  MealModel.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          name: data?['name'],
          price: data?['price'],
          imageUrl: data?['imageUrl'],
          description: data?['description'],
            //.map<IngredientsModel>((mapString) => IngredientsModel.fromMap(mapString)).toList()
      );

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'name':name,
      'description':description,
      'imageUrl':imageUrl,
      'price':price,
          //?.map((i) => i.toMap()).toList()
    };

  }


}

class IngredientsModel{
  static const String collectionName = 'ingredients';

  String? title;
  String? number;
  IngredientsModel({this.number,this.title});



  IngredientsModel.fromFireStore(Map<String,dynamic>? data):
        this(
          title : data?['title'],
          number : data?['number']
      );



  Map<String,dynamic> toFireStore(){
    return {
      'title': title,
      'number':number
    };

  }




}