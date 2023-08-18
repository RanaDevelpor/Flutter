import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/model/model.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<NewsQueryModel> newsModelList =<NewsQueryModel>[];

List<String> navBarItem = ['Top News','Pakistan','World','Education','Sports' ,'Health'];

bool isLoading=true;

getNewsQuery(String query) async{
  String url=
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=252fe5cc878e4eea93711f0ab210eb40";
  Response response = await get(Uri.parse(url));

  Map data = jsonDecode(response.body);
  print(data);

  setState(() {
    data["articles"].forEach((element){
      NewsQueryModel newsQueryModel = new NewsQueryModel();
      newsQueryModel = NewsQueryModel.fromMap(element);
      newsModelList.add(newsQueryModel);

      setState(() {
        isLoading= false;
      });
    });
  });

}



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
           children: [

             //nav Bar
            Container(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                  itemCount: navBarItem.length,
                  itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    print(navBarItem[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child:Text(navBarItem[index],style: TextStyle(
                      fontSize: 19,fontWeight: FontWeight.bold,color: Colors.white,
                    ),
                    ),
                    ),
                  ),
                );
              }),
            ),


             //slider
             CarouselSlider(
                 items: items.map((item){
                   return Builder(builder: (BuildContext context){
                     return InkWell(
                       onTap: (){
                         print("on slider page");
                       },
                       child: Container(
                         margin: EdgeInsets.symmetric(horizontal: 5,vertical: 14),
                          decoration: BoxDecoration(
                            color: item
                          ),
                           ),
                     );}
                   );
                 }).toList(),
                 options: CarouselOptions(
                   height: 200,
                   autoPlay: true,
                   enlargeCenterPage: true,
                 )),



             //list view

             Container(
               child: ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                   itemCount: newsModelList.length,
                   itemBuilder: (context,index){
                 return Container(
                   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                   child: Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15)
                     ),
                     elevation: 1.0,
                     child: Stack(
                       children: [
                         ClipRRect(
                             borderRadius: BorderRadius.circular(15),
                             child: Image.network(newsModelList[index].newsImg)),
                         Positioned(
                           left: 0,
                             right: 0,
                             bottom: 0,
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 gradient: LinearGradient(
                                     colors: [
                                       Colors.black12.withOpacity(0),
                                       Colors.black,
                                     ],
                                   begin: Alignment.topCenter,
                                   end: Alignment.bottomCenter
                                 )
                               ),
                               padding: EdgeInsets.fromLTRB(15, 15, 10, 8),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("NEWS HEADLINE",
                                     style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                 Text("balh BALH BALH BALH .....",
                                 style: TextStyle(color: Colors.white, fontSize: 12),)
                                 ],
                               ),
                             )
                         )
                       ],
                     ),
                   )
                 );
               })
             )

            ],
          ),
      ),
      );
  }
  final List items = [Colors.orangeAccent,Colors.greenAccent,Colors.blueAccent,Colors.grey];
}


