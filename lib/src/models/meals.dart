class Meals {
  String uid;
  String name;
  String imageURL;

  Meals({this.uid = "", this.name = "", this.imageURL = ""});

  @override
  String toString() {
    // TODO: implement toString
    return '$this.uid: $this.name';
  }

  Meals getCountryMeal(Map<dynamic, dynamic> json){
    
    return Meals(uid: json["idMeal"], name: json["strMeal"], imageURL: json["strMealThumb"]);
  }

}