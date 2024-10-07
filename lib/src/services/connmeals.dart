import 'dart:convert' as convert;

import 'package:dio/dio.dart';

import '../models/meals.dart';

class Connection_Meals{

  final dio = Dio();

  String tempURL = "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian";
  String baseURL = "https://www.themealdb.com/api/json/v1/1/filter.php?a=";



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
}