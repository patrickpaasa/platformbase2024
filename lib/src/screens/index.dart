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
  
  @override
  Widget build(BuildContext context) {
    // print(allMeals.length); 
    return Scaffold(
      appBar: AppBar(
        title: const Text("22-110 MSIT"),
        backgroundColor: Colors.red[100],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: allMeals.isNotEmpty ? Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: allMeals.map((oneMeal){
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),                        
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(oneMeal.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              );
              // return Text(oneMeal.name);
            }).toList(),
          ) : Container(),

        )
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