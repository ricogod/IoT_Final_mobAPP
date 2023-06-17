import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

class autoWaterWidget extends StatefulWidget {
  @override
  State<autoWaterWidget> createState() => _autoWaterWidgetState();
}

class _autoWaterWidgetState extends State<autoWaterWidget> {
  var hour = 1;
  var minute = 0;
  var format = 'AM';
  String formattedTime='';
  String timeFormat='AM';
  bool ampm = false;
  String weekDay='Day';
  
  bool sunday=false;
  bool monday=false;
  bool tuesday=false;
  bool wednesday=false;
  bool thursday=false;
  bool friday=false;
  bool saturday=false;

  

 
  final String formattedWithPeriod = DateFormat('hh:mm a').format(DateTime.now());
  final DayHourMinSec=DateFormat('EEE HH:mm:ss');

  late DatabaseReference sundayRef;
  late DatabaseReference mondayRef;
  late DatabaseReference tuesdayRef;
  late DatabaseReference wednesdayRef;
  late DatabaseReference thursdayRef;
  late DatabaseReference fridayRef;
  late DatabaseReference saturdayRef;
  late DatabaseReference timeRef;
  late DatabaseReference timeDisplayRef;

  
  String displayDay='Every';

  
  @override
  void initState(){
    super.initState();
    
    sundayRef=FirebaseDatabase.instance.reference().child('test/sunday');
    mondayRef=FirebaseDatabase.instance.reference().child('test/monday');
    tuesdayRef=FirebaseDatabase.instance.reference().child('test/tuesday');
    wednesdayRef=FirebaseDatabase.instance.reference().child('test/wednesday');
    thursdayRef=FirebaseDatabase.instance.reference().child('test/thursday');
    fridayRef=FirebaseDatabase.instance.reference().child('test/friday');
    saturdayRef=FirebaseDatabase.instance.reference().child('test/saturday');
    timeRef=FirebaseDatabase.instance.reference().child('test/time');
    timeDisplayRef=FirebaseDatabase.instance.reference().child('test/timeDisplay');
  
  sundayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      sunday=event.snapshot.value as bool;
      sunday ?displayDay=displayDay +' Sun': displayDay=displayDay.replaceAll(' Sun', '');
    });
  }
  });
  mondayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      monday=event.snapshot.value as bool;
      monday ?displayDay=displayDay +' Mon': displayDay=displayDay.replaceAll(' Mon', '');
    });
   }
  });
  tuesdayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      tuesday=event.snapshot.value as bool;
      tuesday ?displayDay=displayDay +' Tue': displayDay=displayDay.replaceAll(' Tue', '');
    });
   }
  });
  wednesdayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      wednesday=event.snapshot.value as bool;
      wednesday ?displayDay=displayDay +' Wed': displayDay=displayDay.replaceAll(' Wed', '');
    });
   }
  });
  thursdayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      thursday=event.snapshot.value as bool;
      thursday ?displayDay=displayDay +' Thu': displayDay=displayDay.replaceAll(' Thu', '');
    });
   }
  });
  fridayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      friday=event.snapshot.value as bool;
      friday ?displayDay=displayDay +' Fri': displayDay=displayDay.replaceAll(' Fri', '');
    });
   }
  });
  saturdayRef.onValue.listen((event) {
   if (event.snapshot.value!=null){
    setState(() {
      saturday=event.snapshot.value as bool;
      saturday ?displayDay=displayDay +' Sat': displayDay=displayDay.replaceAll(' Sat', '');
    });
   }
  });
  // timeRef.onValue.listen((event) {  //for debug only
  //  if (event.snapshot.value!=null){
  //   setState(() {
  //     formattedTime=event.snapshot.value as String;
  //   });
  //  }
  // });
  
  // }

  }
void send() {
    setState(() {
      sundayRef.set(sunday);
      mondayRef.set(monday);
      tuesdayRef.set(tuesday);
      wednesdayRef.set(wednesday);
      thursdayRef.set(thursday);
      fridayRef.set(friday);
      saturdayRef.set(saturday);
      timeRef.set(hour.toString().padLeft(2,'0')+':'+minute.toString().padLeft(2,'0'));
      timeDisplayRef.set(hour.toString().padLeft(2,'0')+':'+minute.toString().padLeft(2,'0'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0A2647),
        body: Column(
          children: [
            Center(
              child: Padding(padding: EdgeInsets.only(
                top: 50.0,
                bottom: 0,
                left: 100,
                right: 10
                ),
                child: Row(
                  children: [
                    NumberPicker(
                      minValue: 0, 
                      maxValue: 23, 
                      value: hour, 
                      zeroPad: false,
                      infiniteLoop: true,
                      itemWidth: 80,
                      itemHeight: 80,
                      onChanged: (value){
                        setState(() {
                          hour = value;
                        });
                       
                       },
                       textStyle:  TextStyle(
                         color:  Color(0xFFFCFFE7).withOpacity(0.4),
                         fontSize: 48,
                         fontWeight: FontWeight.w200,
                              fontFamily: 'Inter',
                       ),
                       selectedTextStyle: TextStyle(
                         color:  Color(0xFFFCFFE7),
                         fontSize: 48,
                          fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                       ),
                      ),
                      Text(':',
                      style: TextStyle(
                         color:  Color(0xFFFCFFE7),
                         fontSize: 48,
                          fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
            
                       ),),
                    NumberPicker(
                      minValue: 0, 
                      maxValue: 59, 
                      value: minute, 
                      zeroPad: true,
                      infiniteLoop: true,
                      itemWidth: 80,
                      itemHeight: 80,
                      onChanged: (value){
                        setState(() {
                          minute = value;
                        });
                       },
                       textStyle:  TextStyle(
                         color:  Color(0xFFFCFFE7).withOpacity(0.4),
                         fontSize: 48,
                         fontWeight: FontWeight.w200,
                              fontFamily: 'Inter',
                       ),
                       selectedTextStyle: TextStyle(
                         color:  Color(0xFFFFFFFF),
                         fontSize: 48,
                          fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
            
                       ),
                      ),
                  // Padding(padding: EdgeInsets.only(left: 20),
                  //   child: Column(
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //               _textColor=_textColor== Color(0xFFFCFFE7)?Color(0xFFFCFFE7).withOpacity(0.4):Color(0xFFFCFFE7).withOpacity(0.4);
                  //               _containerColor=_textColor== Color(0xFFFCFFE7)?Color(0xFF144272):Color(0xFF144272);
                  //               _textColor1=_textColor== Color(0xFFFCFFE7).withOpacity(0.4)?Color(0xFFFCFFE7):Color(0xFFFCFFE7);
                  //             format='AM'; 
                  //             ampm=false;
                  //              if (ampm==true){
                  //          hourFinal=hour+12;
                  //         }
                  //          else{
                  //           hourFinal=hour;
                  //         }
                  //             });

                  //         },
                  //         child: Center(
                  //               child: Text('AM',
                  //               style: TextStyle(
                  //                 fontSize: 48,
                  //                 fontFamily: 'Inter',
                  //                 fontWeight: FontWeight.w200,
                  //                 color: _textColor1,
                        
                  //               ),
                  //               )
                  //             ),
                  //       ),
                  //        Padding(
                  //          padding: const EdgeInsets.only(top: 10,bottom: 0,right: 0,left: 0),
                  //          child: SizedBox(
                  //           height: 15,
                  //           width: 10,
                  //           ),
                  //        ),
                  //        GestureDetector(
                  //           onTap: (){
                  //             setState(() {
                  //               _containerColor=_containerColor==Color(0xFF144272)?Color(0xFFFCFFE7):Color(0xFFFCFFE7);
                  //               _textColor1=_textColor== Color(0xFFFCFFE7)?Color(0xFFFCFFE7).withOpacity(0.4):Color(0xFFFCFFE7).withOpacity(0.4);
                  //               _textColor=_textColor== Color(0xFFFCFFE7).withOpacity(0.4)?Color(0xFFFCFFE7):Color(0xFFFCFFE7);
                  //               format='PM';
                  //               ampm=true;
                  //                if (ampm==true){
                  //                   hourFinal=hour+12;
                  //                  }
                  //                 else{
                  //                   hourFinal=hour;
                  //                 }
                  //             });
                  //           },
                  //          child: Text('PM',
                  //               style: TextStyle(
                  //                 fontSize: 48,
                  //                 fontFamily: 'Inter',
                  //                 fontWeight: FontWeight.w200,
                  //                 color: _textColor,
                         
                  //               ),
                  //               )
                  //        ),
                  //     ],
                  //   ),
                  //   )
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 10,
              right: 0
            ),
            ),
           Padding(padding: EdgeInsets.only(
            left: 0,
            top: 0,
            right: 0,
            bottom : 0
            ),
             child: Column(
              children: [
                Container(
                  width: 366,
                  height: 316,
                  decoration: BoxDecoration(
                    color: Color(0xff144272),
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only( left: 20,top: 15,right: 0,bottom : 0),
                      
                      child: Row(
                        children: [
                           
                          Text(
                            '$displayDay',style: 
                            TextStyle(
                                color: Color(0xFFFCFFE7),
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      ),
                      Padding(padding: EdgeInsets.only( left: 5,top: 15,),
                        child: Row(
                             children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    
                                    // if(sunday=true){
                                    //   displayDay=displayDay +' Sunday';
                                    // }
                                    sunday=!sunday;
                                    sunday ?displayDay=displayDay +' Sun': displayDay=displayDay.replaceAll(' Sun', '');
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),
                                        color:sunday  ? Color(0xffD9D9D9) : Color(0xff144272),
                                      // color: Color(0xff144272), 
                                    ),
                                    child: Center(
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xffFF5E59),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                  monday=!monday;
                                  monday ?displayDay=displayDay +' Mon': displayDay=displayDay.replaceAll(' Mon', '');
                                  
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),

                                      color:monday  ? Color(0xffD9D9D9) : Color(0xff144272),
                                      // activeBoxIndex == 1 ? Color(0xffD9D9D9) : Color(0xff144272),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: monday ? Color(0xff144272) : Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                 tuesday=!tuesday ;
                                 tuesday ?displayDay=displayDay +' Tue': displayDay=displayDay.replaceAll(' Tue', '');
                                 
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),

                                      color: tuesday ? Color(0xffD9D9D9) : Color(0xff144272),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'T',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: tuesday ? Color(0xff144272) : Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() { 
                                  wednesday=!wednesday;
                                  wednesday ?displayDay=displayDay +' Wed': displayDay=displayDay.replaceAll(' Wed', '');
                                  
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),

                                      color: wednesday ? Color(0xffD9D9D9) : Color(0xff144272),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'W',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: wednesday ? Color(0xff144272) : Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                 
                                  thursday=!thursday;
                                  thursday ?displayDay=displayDay +' Thu': displayDay=displayDay.replaceAll(' Thu', '');
                                   
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),

                                      color: thursday ? Color(0xffD9D9D9) : Color(0xff144272),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'T',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: thursday ? Color(0xff144272) : Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {  
                                  friday=!friday;
                                  friday ?displayDay=displayDay +' Fri': displayDay=displayDay.replaceAll(' Fri', '');
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),

                                      color: friday ? Color(0xffD9D9D9) : Color(0xff144272),
                                      // Color(0xff144272),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'F',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: friday ? Color(0xff144272) : Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                  weekDay='Saturday';  
                                  saturday=!saturday;
                                  saturday ?displayDay=displayDay +' Sat': displayDay=displayDay.replaceAll(' Sat', '');
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffD9D9D9)
                                      ),

                                      color: saturday ? Color(0xffD9D9D9) : Color(0xff144272),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: saturday ? Color(0xff144272) : Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                              ),
                             ],
                          
                        ),
                      ),
                      SizedBox(height: 80,),
                      Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                             Padding(
                                
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                 Navigator.pop(context);
                                 
                                  });
                                  
                                },
                                 child:
                                   Container(
                                    width: 85,
                                    height: 35,
                                   
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color:  Color(0xffD9D9D9) ,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                                        
                              ),
                              Padding(
                                
                                padding: const EdgeInsets.only(left: 140),
                                child: GestureDetector(
                                onTap: () {
                      setState(() {
                        if (
                          monday == false &&
                          tuesday == false &&
                          wednesday == false &&
                          thursday == false &&
                          friday == false &&
                          saturday == false &&
                          sunday == false
                        ) {
                          // If no day is selected, show an error message
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Please select at least one day.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Valid option selected, do something with displayDay
                          print('Selected days: $displayDay');
                          Navigator.pop(context);
                          send();
                        }
                      });
                    },
                                 child:
                                   Container(
                                    width: 85,
                                    height: 35,
                                   
                                    child: Center(
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color:  Color(0xffD9D9D9) ,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                                          ),
                                                  
                                                           ),
                                        
                              ),
                                
                              ],
                              
                          ),
                      
                      ),
                    ],
                    
                    ),
                ),
                
                // Text('hour= $hourFinal minute= $minute format= $format formattedTime= $formattedTime',),
                // Text( '',style: 
                // TextStyle(
                //   color: Color(0xFFFCFFE7),
                //   fontSize: 25,
                //   fontWeight: FontWeight.w800,
                //   fontFamily: 'Inter',
                // ),
                // ),
                // Text('bool value: $ampm',style:
                // TextStyle(
                //   color: Color(0xFFFCFFE7),
                // ),),    for debug only
              ],
             ),
            ),
          ],
        ),
      ), 
    );
  }
}