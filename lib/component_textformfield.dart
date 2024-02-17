

import 'dart:async';

import 'package:fcm_firebase/utils/style.dart';
import 'package:flutter/material.dart';

class InputTypeService extends StatefulWidget {
  final String title;
  final String dataKey;
  final String hint;
  final TextDirection? textDirection;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Function(String,dynamic) onResult;

  const InputTypeService(
      {super.key,
        required this.title,
        this.textAlign,
        required this.onResult,
        this.textDirection,
        required this.dataKey,
        required this.hint,
        this.keyboardType});

  @override
  State<InputTypeService> createState() => _InputTypeServiceState();
}

class _InputTypeServiceState extends State<InputTypeService> {
  final TextEditingController controller = TextEditingController();

  late Timer timer;
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  bool runTimer = false;

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 1), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      width: double.maxFinite,
      height: 65,
      child: Directionality(
        textDirection: (widget.textDirection == null) ? TextDirection.rtl : widget.textDirection!,
        child: TextFormField(
          autofocus: false,
          controller: controller,
          style: MyStyle.fontMedium.copyWith(
              color: Colors.black87.withAlpha(255), fontSize: 14),
          maxLines: 1,
          keyboardType: (widget.keyboardType == null)
              ? TextInputType.text
              : widget.keyboardType,
          maxLength: 30,
          minLines: 1,
          textDirection: (widget.textDirection != null)
              ? widget.textDirection
              : TextDirection.rtl,
          textAlign: (widget.textAlign == null) ? TextAlign.right : widget.textAlign!,
          onChanged: (value) {
            currentTime = (DateTime.now().millisecondsSinceEpoch + 600);
            if (runTimer == false) {
              runTimer = true;
              startTimer.call();
            }
          },
          decoration: InputDecoration(
            isDense: false,
            labelText: widget.title,
            counter: const SizedBox(
              width: 0,
              height: 0,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              wordSpacing: 5.0,
            ),
            floatingLabelStyle: MyStyle.fontMedium.copyWith(
                color: Colors.black87.withAlpha(200),
                fontSize: 12,
                fontWeight: FontWeight.bold),
            labelStyle: MyStyle.fontMedium.copyWith(
                color: Colors.black87.withAlpha(122), fontSize: 12),
            hintText: widget.hint,
            hintStyle: MyStyle.fontMedium.copyWith(
                color: Colors.black87.withAlpha(95), fontSize: 11),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            border: OutlineInputBorder(
                gapPadding: 4.0,
                borderSide: BorderSide(

                    color: Colors.black54.withAlpha(20),
                    width: 0.9),
                borderRadius: BorderRadius.circular(borderRadiusAllApp)),
            errorBorder: OutlineInputBorder(
                gapPadding: 2.0,
                borderSide: BorderSide(
                    color: Colors.black54.withAlpha(80),
                    width: 0.7),
                borderRadius: BorderRadius.circular(borderRadiusAllApp)),
            enabledBorder: OutlineInputBorder(
                gapPadding: 2.0,
                borderSide: BorderSide(
                    color: Colors.black54.withAlpha(80),
                    width: 0.7),
                borderRadius: BorderRadius.circular(borderRadiusAllApp)),
            disabledBorder: OutlineInputBorder(
                gapPadding: 4.0,
                borderSide: BorderSide(
                    color: Colors.green.withAlpha(150),
                    width: 0.9),
                borderRadius: BorderRadius.circular(borderRadiusAllApp)),
            focusedBorder: OutlineInputBorder(
                gapPadding: 4.0,
                borderSide: BorderSide(
                    color: Colors.deepPurple.withAlpha(250), width: 1.4),
                borderRadius: BorderRadius.circular(borderRadiusAllApp)),
          ),
        ),
      ),
    );
  }



  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) async {
      // print(controller.text);
      if (DateTime.now().millisecondsSinceEpoch >= currentTime && runTimer) {
        timer.cancel();
        runTimer = false;
        // print(widget.dataKey == "date_end_work");
        widget.onResult.call(widget.dataKey, controller.text.toString().trim());
          setState(() {
            runTimer = false;
            timer.cancel();
          });

      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
