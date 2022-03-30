import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.cyan),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String studentName, studentId, studyProgramId;
  late double studentGPA;
  final studentname = TextEditingController();
  final studentid = TextEditingController();
  final programid = TextEditingController();
  final studygpa = TextEditingController();
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('MyStudents').snapshots();

  createdata() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "stdentId": studentId,
      "studyProgramId": studyProgramId,
      "studentGPA": studentGPA,
    };
    documentReference
        .set(students)
        .whenComplete(() => print("$studentName created"));
  }

  readdata() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);

    documentReference.get().then((datasnapshort) {
      print(datasnapshort['studentName']);
      print(datasnapshort['stdentId']);
      print(datasnapshort['studyProgramId']);
      print(datasnapshort['studentGPA']);
    });
  }

  updatdata() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "stdentId": studentId,
      "studyProgramId": studyProgramId,
      "studentGPA": studentGPA,
    };
    documentReference
        .set(students)
        .whenComplete(() => print("$studentName update"));
  }

  deletedata() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);
    documentReference
        .delete()
        .whenComplete(() => print('$studentName deleted'));
  }

  clearText() {
    studentname.clear();
    studentid.clear();
    programid.clear();
    studygpa.clear();
    print('clear');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter College'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: studentname,
              decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (name) {
                studentName = name;
              },
            ),
            TextFormField(
              controller: studentid,
              decoration: InputDecoration(
                  labelText: 'Student Id',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (id) {
                studentId = id;
              },
            ),
            TextFormField(
              controller: programid,
              decoration: InputDecoration(
                  labelText: 'Study Program Id',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (programid) {
                studyProgramId = programid;
              },
            ),
            TextFormField(
              controller: studygpa,
              decoration: InputDecoration(
                  labelText: 'GPA',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (gpa) {
                studentGPA = double.parse(gpa);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: createdata,
                  child: Text('Create'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                ElevatedButton(
                  onPressed: readdata,
                  child: Text('Read'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                ElevatedButton(
                  onPressed: updatdata,
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                ElevatedButton(
                  onPressed: deletedata,
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                ElevatedButton(
                  onPressed: () => clearText(),
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
              ],
            ),
            // // Padding(
            // //   padding: const EdgeInsets.all(8.0),
            // //   child: Row(
            // //     textDirection: TextDirection.ltr,
            // //     children: [
            // //       Expanded(child: Text('Name')),
            // //       Expanded(child: Text('Student Id')),
            // //       Expanded(child: Text('Program Id')),
            // //       Expanded(child: Text('GPA')),
            // //     ],
            // //   ),
            // ),
            //             StreamBuilder<QuerySnapshot>(
            //               stream: _usersStream,
            //               builder: (BuildContext context,
            //                   AsyncSnapshot<QuerySnapshot> snapshot) {
            //                 if (snapshot.hasError) {
            //                   return Text('Something went wrong');
            //                 }

            //                 if (snapshot.connectionState == ConnectionState.waiting) {
            //                   return Text("Loading");
            //                 }

            //                 return ListView(
            //                   children:
            //                       snapshot.data!.docs.map((DocumentSnapshot document) {
            //                     Map<String, dynamic> data =
            //                         document.data()! as Map<String, dynamic>;
            //                     return Row(
            //                       children: [
            // Text(document['studentName'])
            //                       ],
            //                     );}).toList(),
            //                 );
            //               },
            //             ),
          ],
        ),
      ),
    );
  }
}
