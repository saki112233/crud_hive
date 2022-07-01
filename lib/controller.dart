

import 'package:crud_operation/api_model.dart';

import 'auth_service.dart';

class Bb{
  static List<Data> postList = [];

  static loadData()async{
    postList=await GetData().fetchData();
  }
  static addData(Data data)async{

    postList.add(data);

  }
  static removeData(int i){
    postList.removeAt(i);
  }
  static upDateData(int i,Data data){
    postList[i]=data;
  }
}