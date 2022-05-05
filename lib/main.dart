import 'package:flutter/material.dart';



//
// Future<String> getData() async{
//   print('hello');
//   await Future.delayed(Duration(seconds: 2));
//   return 'hello user k cha';
//   // throw Exception('some error');
// }


void main() async {
 // getData().then((value) => print(value)).catchError((err) => print(err));
 //  try{
 //    final data = await getData();
 //    print(data);
 //  }catch (err){
 //    print('err cha $err');
 //  }


  runApp(Home());
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
