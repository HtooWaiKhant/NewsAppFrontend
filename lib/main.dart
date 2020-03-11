import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'api/categories_api.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CategoriesApi categoriesApi= CategoriesApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: FutureBuilder(
          future: categoriesApi.fetchAllCategories(),
          builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot){

            switch(snapshot.connectionState){
              case ConnectionState.active:
                //STILL WORKING
                return _loading();
                break;
              case ConnectionState.waiting:
                //STILL WORKING
                return _loading();
                break;
              case ConnectionState.none:
                //ERROR
                return _error('No Connection has been made');
                break;
              case ConnectionState.done:
                //COMPLETE
                if(snapshot.hasError){
                  return _error(snapshot.error.toString());
                }

                if(snapshot.hasData){
                  return _drawCategoriesList(snapshot.data);
                }
                break;
            }
            return Container();
          },
        ),
      )
    );
  }

  Widget _drawCategoriesList( List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int position) {
        return InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(categories[position].title),
            ),
          ),
          onTap: (){
            
          },
        );
      },
    );
  }

  Widget _error(String error){
    return Container(
      child: Center(
        child: Text(error, style: TextStyle(color: Colors.red),),
      ),
    );
  }

  Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

