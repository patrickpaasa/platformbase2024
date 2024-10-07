import 'dart:convert' as convert;

import 'package:dio/dio.dart';

import '../models/meals.dart';

class Connection_Meals{

  final dio = Dio();

  String tempURL = "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian";
  String baseURL = "https://www.themealdb.com/api/json/v1/1/filter.php";
  String lookupURL = "https://www.themealdb.com/api/json/v1/1/lookup.php";



  Future<List<Meals>> loadTemp() async {
    Response response = await dio.get(tempURL);
    List<Meals> allMeals = [];
    //  print(response.data['meals']);
    //  print("TEST: " + response.data);
     try{
        if(response.statusCode == 200){
          // List<dynamic> jsonResponse = convert.jsonDecode(response.data);
          
          for(var i = 0; i < response.data['meals'].length; i++){
            Meals oneMeal = Meals().getCountryMeal(response.data['meals'][i]);
            // print(response.data['meals'][i]['strMeal']);
             allMeals.add(oneMeal);
          }
          // print(allMeals.length);
          return allMeals;
        }else{
          return allMeals;
        }
     }catch(ex){      
      print(ex.toString());
      return allMeals;
     }
  }
  Future<List<Meals>> loadCountry(String country) async {
    Response response = await dio.get(baseURL,
      queryParameters: {'a': country},
    );
    List<Meals> allMeals = [];
    //  print(response.data['meals']);
    //  print("TEST: " + response.data);
     try{
        if(response.statusCode == 200){
          // List<dynamic> jsonResponse = convert.jsonDecode(response.data);
          
          for(var i = 0; i < response.data['meals'].length; i++){
            Meals oneMeal = Meals().getCountryMeal(response.data['meals'][i]);
            // print(response.data['meals'][i]['strMeal']);
             allMeals.add(oneMeal);
          }
          // print(allMeals.length);
          return allMeals;
        }else{
          return allMeals;
        }
     }catch(ex){      
      print(ex.toString());
      return allMeals;
     }
  }

  Future<MealDetails> loadMeal(Meals oneMeal) async {
    Response response = await dio.get(lookupURL,
      queryParameters: {'i': oneMeal.uid},
    );
    //  print(response.data['meals']);
    //  print("TEST: " + response.data);
    MealDetails details = MealDetails(); 
    details.uid = oneMeal.uid;
    details.name = oneMeal.name;
    details.imageURL = oneMeal.imageURL;
    
     try{
        if(response.statusCode == 200){
          details = MealDetails().getOneMeal(response.data['meals'][0]);
          // print(details.area);
          return details;
        }else{
          return details;
        }
     }catch(ex){      
      print(ex.toString());
      return details;
     }
  }
}