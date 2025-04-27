import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget EditedTextField({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  Color iconcolor=Colors.black,
  bool obscureText = false,
}) {
  return TextField(
    obscureText: obscureText,
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon,color: iconcolor,),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 2.0),
      ),
    ),
  );
}

Widget Button({required ontab, required String name,required bool isstate}) {
  return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: ontab, child: isstate?Center(child: CircularProgressIndicator(),):Text(name)));
}

void Navigateto({required BuildContext context, required Widget ScreenName}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenName));
}

void Navigatetopush({required BuildContext context, required Widget ScreenName}) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenName));
}
//GcKATHYE8JMBADmx4JNf5mpuiJi1