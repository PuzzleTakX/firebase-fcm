
import 'package:fcm_firebase/component_textformfield.dart';
import 'package:fcm_firebase/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String keyFirebase = "";
  String title = "";
  String content = "";
  String image = "";
  String link = "";
  String id = "";



  @override
  void initState() {
    super.initState();
    getPermission();
  }

  Future<void> getPermission() async {
    await Utils.requestPermissionNotification;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:_content() ,
    ));

  }


  Widget _content(){
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.deepPurpleAccent,
              child: const Text(" •PuzzleTak FireBase• ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
              ),
            ),
            SizedBox(height: 15,),
            InputTypeService(title: "Key Firebase", onResult: (p0, p1) {
              setState(() {
                keyFirebase = p1;
              });
            }, dataKey: "data_ky", hint: "Input Key Firebase eample : AAAQ65dsd5f6...",textDirection: TextDirection.ltr,textAlign: TextAlign.left,),
            InputTypeService(title: "Title", onResult: (p0, p1) {
              setState(() {
                title = p1;
              });
            }, dataKey: "data_title", hint: "Input Title",textDirection: TextDirection.ltr,textAlign: TextAlign.left,),
            InputTypeService(title: "Content", onResult: (p0, p1) {
              setState(() {
                content = p1;
              });
            },keyboardType: TextInputType.multiline, dataKey: "data_content", hint: "Input Content",textDirection: TextDirection.ltr,textAlign: TextAlign.left,),
            InputTypeService(title: "Link", onResult: (p0, p1) {
              setState(() {
                link = p1;
              });
            }, dataKey: "data_link", hint: "Input Link",textDirection: TextDirection.ltr,textAlign: TextAlign.left,),
            InputTypeService(title: "Image", onResult: (p0, p1) {
              setState(() {
                image = p1;
              });
            }, dataKey: "data_image", hint: "Input Image",textDirection: TextDirection.ltr,textAlign: TextAlign.left,),
            InputTypeService(title: "Id", onResult: (p0, p1) {
              setState(() {
                id = p1;
              });
            }, dataKey: "data_id", hint: "Input Id",textDirection: TextDirection.ltr,textAlign: TextAlign.left,),
            const SizedBox(height: 5,),
            Container(
              width: double.maxFinite,height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white
                ),
                onPressed:onClickSendNotification,
                child: const Text("Send Notification",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  void onClickSendNotification(){

  }


}
