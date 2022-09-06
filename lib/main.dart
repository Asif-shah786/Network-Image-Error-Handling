import 'package:flutter/material.dart';

import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Images',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child : FutureBuilder<List<String>>(
          future: ApiService().getImages(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if(snapshot.hasData){
              print('has Data');
              print("Has Data : ${snapshot.data?.length}");
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Image.network(snapshot.data![index],
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Center(child: Text('Image is Loading'));
                        },
                      ),
                    );
                  },),
              );
            }
            return const Center(child: Text('Still working'));
          },),
      ),
    );
  }
}