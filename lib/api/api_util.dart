class ApiUtil {

  static const String MAIN_API_URL = 'http://192.168.1.2/api';

  static const String All_CATEGORIES = '/categories';

  static const String All_POSTS = '/posts';

  static  String categoryPosts(String categoryID){
    return MAIN_API_URL + All_CATEGORIES + '/' + categoryID + '/post';
  }
}