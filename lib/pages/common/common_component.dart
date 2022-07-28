import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomMaterailButton extends StatelessWidget {
  Color buttonColor;
  Color? textColor;
  double borderRadious;
  Widget child;
  double width;
  VoidCallback callback;

  CustomMaterailButton(
      {Key? key,
      required this.borderRadious,
      required this.buttonColor,
      required this.child,
      this.textColor,
      required this.width,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: width,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadious)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadious),
        child: MaterialButton(
          onPressed: callback,
          child: child,
          height: 45.0,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyInputField extends StatelessWidget {
  MyInputField(
      {Key? key,
      this.textEditingController,
      required this.title,
      required this.hint,
      this.widget})
      : super(key: key);
  TextEditingController? textEditingController;
  String title;
  String hint;
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getTTitle(title),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(2),
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        readOnly: widget == null ? false : true,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          iconColor: Colors.grey[300],
                          hintText: hint,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.grey[600])),
                  ),
                  const Spacer(),
                  widget ?? Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getTTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
          textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      )),
    );
  }
}
