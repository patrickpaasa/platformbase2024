import 'package:flutter/material.dart';
import 'package:platformbase2024/src/models/meals.dart';
import 'package:platformbase2024/src/services/connmeals.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List<Meals> allMeals = [];
  

  List<String> country = ["Canadian", "French", "Italian", "Jamaican", "American","Indian","Filipino","Japanese","Chinese"];
  String dropdownValue = "Canadian";

  Widget countryDrop(){
    return DropdownButton<String>(
      value: dropdownValue,
      dropdownColor: Colors.red[100],

      icon: const Icon(Icons.flag),
      elevation: 25,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? value){
        loadCountryMeals(value!);
      },
      items: country.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(value)
          ),
        );
      }).toList(),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    loadTempMeals();
  }

  Future<void> loadTempMeals() async {
    List<Meals> temp = await Connection_Meals().loadTemp();
    setState(() {
      allMeals = temp;
    });
  }
  Future<void> loadCountryMeals(String dcountry) async {
    List<Meals> temp = await Connection_Meals().loadCountry(dcountry);
    setState(() {
      allMeals = temp;
      dropdownValue = dcountry;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    // print(allMeals.length); 
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("22-110 MSIT"),
            SizedBox(width: 20,),
            countryDrop(),
          ],
        ),
        backgroundColor: Colors.red[100],
      ),
      body: SafeArea(
        
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: allMeals.isNotEmpty ? Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: allMeals.map((oneMeal){
              return cardMeal(oneMeal);
              // return Text(oneMeal.name);
            }).toList(),
          ) : Container(width: MediaQuery.of(context).size.width,),

        )
      ),

    );
  }

  Padding cardMeal(Meals oneMeal) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  // Connection_Meals().loadMeal(oneMeal);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealScreen(oneMeal))
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image:  DecorationImage(
                            image: NetworkImage(oneMeal.imageURL),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFF7CED2)
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),                        
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(oneMeal.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              ),
            );
  }

  Container removed(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg/adduccfc.png"),
          fit: BoxFit.cover,
        ),         
      ),
      child: const Text("Child Widget Text"),
    );
  }
}

class MealScreen extends StatefulWidget {
  Meals oneMeal;
  MealScreen(this.oneMeal, {super.key,});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  MealDetails details = MealDetails();

  loadDetails() async {
    MealDetails detail = await Connection_Meals().loadMeal(widget.oneMeal);
    setState(() {
      details = detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.oneMeal.name),
        backgroundColor: Colors.red[100],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(details.instructions)
              ],
            ),
          ),
        )
      ),
    );
  }
}