import 'package:cat/core/data_base/models/meal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/categories_model.dart';
import 'models/drivers.dart';
import 'models/ride_request.dart';
import 'models/user.dart';

class MyDataBase{

  static CollectionReference<User> getUsersCollection(){
    return FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }

  static Future<void> addUser(User user){
    var collection = getUsersCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String id)async{
    var collection = getUsersCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }

  static CollectionReference<CategoryModel> getCategoryCollection(){
    return FirebaseFirestore.instance.collection(CategoryModel.collectionName)
        .withConverter<CategoryModel>(
      fromFirestore: (snapshot, options) => CategoryModel.fromFireStore(snapshot.data()),
      toFirestore: (category, options) => category.toFireStore(),
    );
  }

  static Future<QuerySnapshot<CategoryModel>>getCategories(){
    return getCategoryCollection()
        .get();
  }

  static Future<void> addCategory(CategoryModel category){
    var collection = getCategoryCollection().doc();
    category.id = collection.id;
    return collection.set(category);
  }
  static Future<void> listenState()async {
    getCategoryCollection().doc().snapshots().listen((event) { });
  }

  static Stream<DocumentSnapshot<CategoryModel>>getCategoryRealTimeUpdate(String id){
    return getCategoryCollection().doc(id)
        .snapshots();
  }
  static Future<void> deleteCategory(String mealID){
    return getCategoryCollection()
        .doc(mealID)
        .delete();
  }
  static Future<void> editCategory(CategoryModel category){
    return getCategoryCollection().doc(category.id).update(category.toFireStore());

  }




  static CollectionReference<MealModel> getMealCollection(String? categoryId){
    var categoryCollection = getCategoryCollection();
    return categoryCollection.doc(categoryId).collection(MealModel.collectionName)
        .withConverter<MealModel>(
      fromFirestore: (snapshot, options) => MealModel.fromFireStore(snapshot.data()),
      toFirestore: (meal, options) => meal.toFireStore(),
    );
  }
  static Future<void> addMeal({required MealModel mealModel,required String? categoryId}){
    mealModel.id = getMealCollection(categoryId).doc().id;
   return getMealCollection(categoryId).doc(mealModel.id).set(mealModel);
  }



  static CollectionReference<IngredientsModel> getIngredientsCollection(
      {required String? categoryId,required String? mealId}){
    var mealCollection = getMealCollection(categoryId);
    return mealCollection.doc(mealId).collection(IngredientsModel.collectionName)
        .withConverter<IngredientsModel>(
      fromFirestore: (snapshot, options) => IngredientsModel.fromFireStore(snapshot.data()),
      toFirestore: (meal, options) => meal.toFireStore(),
    );
  }

  static Future<void> addIngredients({required IngredientsModel ingredientsModel,required String? categoryId,required String? mealId}){
   return getIngredientsCollection(categoryId: categoryId,mealId: mealId).add(ingredientsModel)
      // .doc(mealId).set(ingredientsModel)
   ;

  }


  static Future<void> updateHistory({required RideRequest? rideRequest,required String? id}){
    var collection = getUsersCollection();
    return collection.doc(id).collection('History')
        .withConverter<RideRequest>(
      fromFirestore: (snapshot, options) => RideRequest.fromFireStore(snapshot.data()),
      toFirestore: (ride, options) => ride.toFireStore(),
    ).doc(rideRequest!.id).update(rideRequest.toFireStore());
  }
  static Future<void> deleteHistory({required RideRequest? rideRequest,required String? id,String? tripId}){
    var collection = getUsersCollection();
    return collection.doc(id).collection('History')
        .withConverter<RideRequest>(
      fromFirestore: (snapshot, options) => RideRequest.fromFireStore(snapshot.data()),
      toFirestore: (ride, options) => ride.toFireStore(),
    ).doc(rideRequest?.id).delete();
  }


  static Future<QuerySnapshot<RideRequest>> getHistory({required String? id}){
    var collection = getUsersCollection();

    var historyCollection = collection.doc(id).collection('History').withConverter<RideRequest>(
      fromFirestore: (snapshot, options) => RideRequest.fromFireStore(snapshot.data()),
      toFirestore: (ride, options) => ride.toFireStore(),
    ).get();


    return historyCollection;

  }

  static CollectionReference<Driver> getDriverCollection(){
    return FirebaseFirestore.instance.collection(Driver.collectionName)
        .withConverter<Driver>(
      fromFirestore: (snapshot, options) => Driver.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }
  static Future<Driver?> readDriver(String id)async{
    var collection = getDriverCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }


  static Future<void> updateDriverHistory({required RideRequest? rideRequest,required String? id}){
    var collection = getDriverCollection();
    return collection.doc(id).collection('History')
        .withConverter<RideRequest>(
      fromFirestore: (snapshot, options) => RideRequest.fromFireStore(snapshot.data()),
      toFirestore: (ride, options) => ride.toFireStore(),
    ).doc(rideRequest!.id).update(rideRequest.toFireStore());
  }

}