// ignore_for_file: prefer_const_constructors, file_names, prefer_typing_uninitialized_variables, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, use_full_hex_values_for_flutter_colors


import 'AllExport.dart';

class MyButton2 extends StatelessWidget {
  final void Function() onpress;
  var buttontext;
  MyButton2({
    super.key,
    required this.onpress,
    required this.buttontext,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xfffE89E2A),
            foregroundColor: Appcolor.backcolors,
            disabledForegroundColor: Colors.white,
            disabledBackgroundColor: Color(0xfffE89E2A),
            shadowColor: Color(0xfffE89E2A),
            side: BorderSide(
                color: Color(0xfffE89E2A), width: 1, style: BorderStyle.solid)),
        onPressed: () {
          onpress();
        },
        child: Text(
          buttontext,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: "bold"),
        ));
  }
}
