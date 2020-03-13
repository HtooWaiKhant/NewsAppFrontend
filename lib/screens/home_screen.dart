import 'package:flutter/material.dart';
import 'package:frontend/api/posts_api.dart';
import 'package:frontend/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PostsApi postsApi = PostsApi();
  List<Post>postsWithImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(color: Colors.redAccent),
            ),
            ListTile(
              title: Text('Categories'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/categories');
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: postsApi.fetchAllPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.none:
              return _error('No connection has been made');
              break;
            case ConnectionState.done:

              if(snapshot.hasError) {
                return _error(snapshot.error.toString());
              }

              if(! snapshot.hasData) {
                return _error('No Data fetched yet');
              }
              
              if(snapshot.hasData) {
                return _drawHomeScreen(snapshot.data);
              }
              break;
          }
          return Container();
        },
      )
    );
  }

  Widget _drawHomeScreen(List<Post> posts){
    for(Post post in posts){
      if(post.images.length > 0){
        print('ga');
        postsWithImages.add(post);
      }
    }
    print(postsWithImages.length);
    return Column(
      children: <Widget>[
        _slider(postsWithImages),
      ],
    );
  }

  Widget _slider(List<Post> posts){
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: PageView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position){
          return Stack(
            children: <Widget>[
              Image(
                image: NetworkImage(
                  posts[position].images[0].image_url
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(error, style: TextStyle(color: Colors.red),),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}
