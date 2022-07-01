import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'api_model.dart';
import 'controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var box =Hive.box('api_data');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController editedtitleController = TextEditingController();
  TextEditingController editeddescriptionController = TextEditingController();



  _HomePageState();

  Future<void> addData(Data data) async {
    int num=box.length +1;
    if (titleController.text != '' && descriptionController.text != '') {
      num++;
      setState(() {
        box.put(num, titleController.text);
        box.put(num, descriptionController.text);
        Bb. postList.add(data);
      });
    }
    titleController.clear();
    descriptionController.clear();
  }

  bool isLoading = false;
  getPost() async {
    // final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    // postList = await GetPostService().fetchData();
    await Bb.loadData();
    setState(() {
      isLoading = false;
    });
  }

  void editTask(int i,Data data ) {
    showDialog(context: context, builder: (_){
      return AlertDialog(
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            if(editedtitleController.text !='' && editeddescriptionController.text !=''){
              setState((){
                Data data=Data(title: editedtitleController.text,body: editeddescriptionController.text);
                Bb.postList.add(data);
                editedtitleController.clear();
                editeddescriptionController.clear();
                Navigator.pop(context);
              });
            }
          }, child: Text('Update'))
        ],
        title: Text('Edit'),
        content: Column(
          children: [
            TextFormField(
              autofocus: true,
              enableSuggestions: true,
              controller: editedtitleController,
              decoration: InputDecoration(
                hintText:Bb. postList[i].title,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            TextFormField(
              autofocus: true,
              enableSuggestions: true,
              controller:editeddescriptionController ,
              decoration: InputDecoration(
                hintText:Bb. postList[i].body,
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    children: [
                      Text(
                        'Add to Task',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        autofocus: true,
                        enableSuggestions: true,
                        controller: titleController,
                        decoration: InputDecoration(
                            labelText: 'title',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onEditingComplete: () {},
                        autofocus: true,
                        enableSuggestions: true,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            labelText: 'description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        onPressed: () {
                          final data = Data(
                              title: titleController.text,
                              body: descriptionController.text);
                          box.add(data);
                          addData(data);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Insert',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
      ),
      body: Container(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.separated(
              shrinkWrap: true,
              reverse: true,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(
                    thickness: 2,
                  ),
              itemCount: Bb.postList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    editTask(i,Data(title: editedtitleController.text,body: editeddescriptionController.text));
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) => ModifiedData(
                    //       index: i,
                    //     ));
                  },
                  trailing: IconButton(
                      key: UniqueKey(),
                      onPressed: () {

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete'),
                                content: Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            Bb. postList.removeAt(i);
                                            //
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("Yes"))
                                  ],
                                ),
                              );

                            });
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                  title: Text(
                    Bb. postList[i].title.toString(),
                  ),
                  subtitle: Text(Bb.postList[i].body.toString()),
                );
              })),
    );

  }
}