import 'package:digital_notice_board/share_post.dart';
import 'package:digital_notice_board/users.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'comments.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String LOG_NAME='screen.home';

 bool isLiked=false;
 int _selectedIndex = 0;
 bool isVisible=false;



 List<User> users=[ User(firstName: "Lungelo", lastName: "Ncube", url: "assets/one.jpg",date:"Monday July 9, 12:15pm", post:"lorem ipsum ", media:"assets/post_image.jpg" ),
   User(firstName: "Amanda", lastName: "Ncube", url: "assets/two.jpg",date:"Monday July 9, 12:15pm",post:"lorem ipsum " , media:"assets/post_image.jpg"),
  User(firstName: "Yolanda", lastName: "Ndlovu", url: "assets/three.jpg",date:"Monday July 9, 12:15pm",post:"lorem ipsum ", media:"assets/post_image.jpg" ),
   User(firstName: "Lethu", lastName: "Timm", url: "assets/four.jpg",date:"Monday July 9, 12:15pm",post:"lorem ipsum " , media:"assets/post_image.jpg"),
   User(firstName: "Anele", lastName: "Moyo", url: "assets/five.png",date:"Monday July 9, 12:15pm",post:"lorem ipsum " , media:"assets/post_image.jpg"),
   User(firstName: "Aisha", lastName: "Ncube", url: "assets/six.png",date:"Monday July 9, 12:15pm",post:"lorem ipsum " , media:"assets/post_image.jpg")];

 @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Notice Board"),
          actions: [Icon(Icons.search, color: Colors.black,)],
        ),
        body: _buildFeed(width),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.green,child:Icon(Icons.add),onPressed: (){
        Navigator.push(
            context,
        MaterialPageRoute(
          builder: (context) => SharePost(),
        )
        );
      }, ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        selectedItemColor:Colors.blue[900],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 5,
        type: BottomNavigationBarType.fixed,// this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Notifications'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Customers')
          )
        ],
      ),
    );
  }

 void _onItemTapped(int index) {
   setState(() {
     dev.log('dfsdsf', name: LOG_NAME);
     _selectedIndex = index;
   });
 }

 Widget _buildFeed(width){
   return Container(
     child: ListView.builder(itemCount:users.length,itemBuilder: (context, index){
       return
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       CircleAvatar(
                         radius: 22,
                         backgroundColor: Colors.grey,
                         child: CircleAvatar(
                           radius: 20,
                           backgroundImage: AssetImage(users[index].url),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(width: 10),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('${users[index].firstName +" "+ users[index].lastName}'),
                       Text(users[index].date)
                     ],
                   ),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Icon(Icons.more_vert, size:30,color: Colors.blue[900])
                       ],
                     ),
                   ),
                 ],
               ),

             ),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Column(children: [
                 Text('${users[index].post}'*30),
                 SizedBox(height:15),
                 Container(
                     width:width,child: Image.asset(users[index].media,fit: BoxFit.fill,)),
                 SizedBox(height:15),
                 Row(

                   children: [
                     Expanded(
                         flex:4,
                         child: GestureDetector(onTap:(){
                          // Navigator.pushNamed(context, "/comments",

                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => Comments(firstName: users[index].firstName,
                               lastName: users[index].lastName,date: users[index].date,post:users[index].post, media: users[index].media, url: users[index].url,),
                             ),
                           );

                           // setState(() {
                           //   isVisible=!isVisible;
                           // });
                         },child: Text("View Comments"))),
                     Expanded(
                         flex:1,
                         child:IconButton(icon: Icon(isLiked?Icons.thumb_up:Icons.thumb_up_alt_outlined, color:Colors.blue), onPressed: (){
                           setState(() {
                             isLiked=!isLiked;
                           });
                         })),
                     // child: widget(child: Icon(isLiked?Icons.thumb_up:Icons.thumb_up_alt_outlined, color: Colors.blue))),
                     Expanded(
                         flex:1,
                         child: Icon(Icons.comment,color:Colors.blue)),

                   ],
                 ),
                 Visibility(
                   visible: isVisible,
                   child: Column(
                     children: [

                     ],
                   ),
                 )


               ],),
             )
           ],
         );
     }),
   );
 }
}
