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
    
    return Meals(
      uid: json["idMeal"] ?? "", 
      name: json["strMeal"] ?? "", 
      imageURL: json["strMealThumb"] ?? ""
    );
  }

}

class MealDetails extends Meals{
  String category;
  String area;
  String instructions;
  String tags;
  String ytLink;
  List<String> ?ingredients = [];
  List<String> ?measurements = [];

  MealDetails getOneMeal(Map<dynamic, dynamic> json){
    return MealDetails(
      category: json["strCategory"] ?? "", 
      area: json["strArea"] ?? "", 
      instructions: json["strInstructions"] ?? "", 
      tags: json["strTags"] ?? "", 
      ytLink: json["strYoutube"] ?? "", 
    );
  }

  MealDetails(    
    {    
    this.category = "",
    this.area = "",
    this.instructions = "",
    this.tags = "",
    this.ytLink = "",
    this.ingredients,
    this.measurements,
  });
}