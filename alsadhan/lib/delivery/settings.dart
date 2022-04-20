
import 'package:alsadhan/home/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:alsadhan/address.dart';



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: new AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.blueAccent,
                  Colors.blueAccent,
                  Colors.blue[900]
                ])),
          ),
                  title: Center(
                    child: Text('Settings'),
                  ),
                  actions: <Widget>[
                IconButton(icon: Icon(Icons.close,size: 30.0), onPressed: () => Navigator.of(context).pop()),        
               ],
 
               
        backgroundColor: Colors.blue,
         ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title:  Text("Delivery Location", style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold) ),
              subtitle: Text('Country/Saudi Arabia'),
              trailing: new IconButton(icon:  Icon(Icons.keyboard_arrow_right,color: Colors.blue[900]),
              
             onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen()));
                         })
            ),
            // Divider(color: Colors.blue,),
            // ListTile(
            //   title:  Text("Delivery Mode",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold)),
            //   subtitle: Text('Home Delivery'),
            //   trailing: new IconButton(icon:  Icon(Icons.keyboard_arrow_right,color: Colors.blue[900]),
            //  onPressed: (){}
            //                 // Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen()));
                         
            //              )
            // ),
            
            Divider(color: Colors.blue),
            // ListTile(
            //   title:  Text("Delivery Slot",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
            //   subtitle: Text('Date Time'),
            //   trailing: new IconButton(icon:  Icon(Icons.keyboard_arrow_right),
            //  onPressed: (){
            //                 // Navigator.push(context, MaterialPageRoute(builder: (context) => DeliverySlotScreen()));
            //              })
            
            // ),
            // Divider(),
            ListTile(
              title:  Text("Language",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold)),
              subtitle: Text('English'),
              trailing: new IconButton(icon:  Icon(Icons.keyboard_arrow_right, color: Colors.blue[900],),
             onPressed: (){
                             
                         })
            ),
             Divider(color: Colors.blue),
             ListTile(
              title:  Text("Profile",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold)),
              //subtitle: Text('English'),
              trailing: new IconButton(icon:  Icon(Icons.keyboard_arrow_right, color: Colors.blue[900],),
             onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                             
                         })
            ),
            Divider(color: Colors.blue),
          ],
          
        ));
  }

  
}
