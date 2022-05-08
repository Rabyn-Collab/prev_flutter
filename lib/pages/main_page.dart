import 'package:flutter/material.dart';
import 'package:project_start/widgets/tab_bar_widgets.dart';



class MainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 20),
            indicatorColor: Colors.red,
              tabs: [
                Tab(
                  text: 'Hollywood',
                ),
                Tab(
                  text: 'Gaming',
                ),
              ]
          ),
        ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            height: 300,
            child: TabBarView(
                children: [
                TabBarWidget('hollywood'),
                TabBarWidget('gaming'),
                ]
            ),
          )
      ),
    );
  }
}
