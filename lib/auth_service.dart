import 'package:hive/hive.dart';

import 'api_model.dart';
import 'package:http/http.dart' as http;
class GetData{
  var box = Hive.box('api_data');
  Future<List<Data>> fetchData() async {
    List<Data> postList;
    String? data = box.get("hello");
    if(data !=null){
      postList = dataFromJson(data);
    }else{
      try {
        var response = await http
            .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
        box.put("hello", response.body);
        String? data = box.get("hello");
        postList = dataFromJson(data!);
      }catch(e){
        postList=[];
      }

    }
    return postList;
  }


}