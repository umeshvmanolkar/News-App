import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Favorite.dart';
import 'login_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}



//To get the saved list of favourite news from shared preferences
Future<List> getNamePreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> mList = (prefs.getStringList('favouriteNewsList') ?? List<String>());
  List<int> mOriginaList = mList.map((i)=> int.parse(i)).toList();
  return mOriginaList;
}


class _NewsPageState extends State<NewsPage> with WidgetsBindingObserver{
  List favouriteNewsList = [];
  int id;





  Future getNewsData() async{

    var response = await http.get(Uri.https("api.first.org", "data/v1/news"));  //API
    var jsonData = jsonDecode(response.body);

    List<News> newsList = [];

    //Getting news from API and storing into newsList
    for(var n in jsonData['data']){
      News news = News(n["id"],n["title"],n["summary"],n["published"]);
      newsList.add(news);
    }
    return newsList;
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
            FutureBuilder(

                  future: getNewsData(),
                  builder: (context, snapshot){

                    if(snapshot.data == null){
                      var now = DateTime.now();
                      return Container(
                        child: Center(
                          child: Text(now.timeZoneName),


                        ),
                      );
                    } else return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,i){
                      return
                        Container(
                          padding: EdgeInsets.only(left: 7,right: 7),
                          // height: 150,

                          decoration: new BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 20.0,
                              ),
                            ],
                          ),
                          child: Visibility(
                            visible: favouriteNewsList.contains(snapshot.data[i].id) ? false :true,
                            child: Card(
                              shadowColor: Colors.black,
                              elevation: 10,



                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),

                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                   ListTile(
                                    leading: IconButton(
                                        alignment: Alignment.center,
                                        onPressed: (){
                                          if(favouriteNewsList.contains(snapshot.data[i].id)){
                                          favouriteNewsList.remove(snapshot.data[i].id);
                                        }
                                        else {
                                          favouriteNewsList.add(snapshot.data[i].id);

                                          List<String> encoded_favList = favouriteNewsList
                                              .map((i) => i.toString()).toList();
                                        }
                                        List<String> encoded_favList = favouriteNewsList
                                            .map((i) => i.toString()).toList();

                                          setState(() {
                                            saveFavouriteList(encoded_favList);

                                          });
                                      },
                                        icon:Icon(
                                          Icons.favorite,
                                          size: 33,
                                          color: favouriteNewsList.contains(snapshot.data[i].id) ? Colors.red[300] : Colors.grey[400],
                                        )),


                                    title: Text(
                                        snapshot.data[i].title,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ), maxLines:2),


                                     subtitle: Text(
                                       snapshot.data[i].summary ??  ' ',
                                       maxLines: 2,
                                       style: TextStyle(color: Colors.black),),
                                  ),

                                  SizedBox(height: 27,),
                                  Row(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: 80)),

                                      Text(snapshot.data[i].published ??  ' ',
                                        style: TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                  SizedBox(height: 14,)
                                ],
                              ),
                            ),
                          ),


                        );
                    }
                    );
                  },
            ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [


                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: RaisedButton(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Icon(Icons.list,color: Colors.white,size: 40,),
                    SizedBox(width: 7,),
                    Text("News", style: TextStyle(color: Colors.white,fontSize: 21),)
                   ],
                 ),
                            color: Colors.blue[600],
                            onPressed: (){}
                            ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: RaisedButton(
                          color: Colors.grey[100],
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite,color: Colors.red[300],size: 32,),
                            SizedBox(width: 7,),
                            Text("Favs",style: TextStyle(fontSize: 21),)
                          ],
                        ),
                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: 10),

                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> Favorite() ));
                            }
                        ),
                      ),
                    ),

                  ],
                ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateFavList(List favList){
    setState(() {
      this.favouriteNewsList=favList;
    });
  }
}

class News {
  final int id;
  final String title,summary,published;

  News(this.id,this.title,this.summary,this.published);

}

void saveFavouriteList(List favouriteNewsList) {
  saveNamePreference(favouriteNewsList).then((bool committed){

  });
}

Future<bool> saveNamePreference(List favouriteNewsList) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("favouriteNewsList",favouriteNewsList);
  return prefs.commit();
}
