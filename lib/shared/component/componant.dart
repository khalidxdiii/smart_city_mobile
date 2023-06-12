// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/colors.dart';

class DefaultTextFild extends StatelessWidget {
  const DefaultTextFild({
    super.key,
    required this.label,
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChanged,
    required this.validator,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixPressad,
    this.IsPassword = false,
    this.isNationalID = false,
    this.floatingLabel = false,
    this.radius = 10,
    this.minLines = 1,
    this.maxLines = 1,
  });
  final String? label;
  final TextEditingController? controller;
  final TextInputType? type;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool IsPassword;
  final VoidCallback? suffixPressad;
  final double radius;
  final bool floatingLabel;
  final int minLines;
  final int maxLines;
  final bool isNationalID;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: IsPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      inputFormatters: isNationalID
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(14),
            ]
          : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        //isDense: true,
        floatingLabelBehavior: floatingLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            prefixIcon,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressad,
                  icon: Icon(Icons.remove_red_eye),
                )
              : null,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        filled: true,
        //fillColor: Colors.grey[200],
        fillColor: Color(0xffEEEEEE),
        //labelStyle: TextStyle(fontWeight: FontWeight.bold),
        //floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget DefaultTextFild({
//   required String label,
//   required TextEditingController controller,
//   required TextInputType type,
//   ValueChanged<String>? onSubmit,
//   ValueChanged<String>? onChanged,
//   required FormFieldValidator<String>? validator,
//   required IconData prefixIcon,
//   IconData? suffixIcon,
//   bool IsPassword = false,
//   VoidCallback? suffixPressad,
//   double radius = 50,
//   bool floatingLabel = false,
//   int minLines = 1,
//   int maxLines = 1,
//   bool isNationalID = false,
// }) {
//   return TextFormField(
//     controller: controller,
//     keyboardType: type,
//     obscureText: IsPassword,
//     onFieldSubmitted: onSubmit,
//     onChanged: onChanged,
//     validator: validator,
//     minLines: minLines,
//     maxLines: maxLines,
//     inputFormatters: isNationalID
//         ? [
//             FilteringTextInputFormatter.digitsOnly,
//             LengthLimitingTextInputFormatter(14),
//           ]
//         : null,
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.all(20),
//       //isDense: true,
//       floatingLabelBehavior: floatingLabel
//           ? FloatingLabelBehavior.always
//           : FloatingLabelBehavior.auto,
//       labelText: label,
//       prefixIcon: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Icon(
//           prefixIcon,
//         ),
//       ),
//       suffixIcon: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: suffixIcon != null
//             ? IconButton(
//                 onPressed: suffixPressad,
//                 icon: Icon(Icons.remove_red_eye),
//               )
//             : null,
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radius),
//       ),
//       filled: true,
//       //fillColor: Colors.grey[200],
//       fillColor: Color(0xffEEEEEE),
//       //labelStyle: TextStyle(fontWeight: FontWeight.bold),
//       //floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//     ),
//   );
// }

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.background = kDprimaryColor,
    required this.function,
    required this.text,
    this.height = 50,
    this.isUpperCase = true,
    this.radius = 10,
    this.width = double.infinity,
  });
  final double? width;
  final double? height;
  final Color? background;
  final bool isUpperCase;
  final double radius;
  final void Function()? function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: GoogleFonts.almarai(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// Widget DefaultButton({
//   double? width = double.infinity,
//   double? height = 50,
//   Color? background = kDprimaryColor,
//   bool isUpperCase = true,
//   double radius = 50,
//   required VoidCallback function,
//   required String text,
// }) {
//   return Container(
//     width: width,
//     height: height,
//     child: MaterialButton(
//       onPressed: function,
//       child: Text(
//         isUpperCase ? text.toUpperCase() : text,
//         style: GoogleFonts.almarai(color: Colors.white),
//       ),
//     ),
//     decoration: BoxDecoration(
//       color: background,
//       borderRadius: BorderRadius.circular(radius),
//     ),
//   );
// }

class IconCardItem extends StatelessWidget {
  const IconCardItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.color = kDprimaryColor});
  final String title;
  final IconData icon;
  final Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                child: Icon(
                  icon,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

// Card IconCardItem({
//   required String title,
//   required IconData icon,
//   required Function()? onTap,
//   Color color = kDprimaryColor,
// }) {
//   return Card(
//     elevation: 1.0,
//     margin: EdgeInsets.all(8.0),
//     child: Container(
//       width: 200,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           verticalDirection: VerticalDirection.down,
//           children: <Widget>[
//             SizedBox(height: 50.0),
//             Center(
//               child: Icon(
//                 icon,
//                 size: 60.0,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Center(
//               child: Text(
//                 title.toUpperCase(),
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 50.0),
//           ],
//         ),
//       ),
//     ),
//   );
// }

class ReportDetailsImageCard extends StatelessWidget {
  const ReportDetailsImageCard({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: kDprimaryColor,
          width: 2.0,
        ),
        color: Colors.white,
      ),
      // child: const Icon(
      //   Icons.camera,
      //   size: 50,
      // ),

      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FadeInImage.assetNetwork(
            placeholder: 'images/FadeInImage.png',
            image: imageUrl,
            fit: BoxFit.fill,
            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
              'images/FadeInImageError.png',
            ),
          )),
    );
  }
}

// Widget reportDetailsImageCard({required String imageUrl}) {
//   return Container(
//     height: 320,
//     width: double.infinity,
//     margin: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(15),
//       border: Border.all(
//         color: kDprimaryColor,
//         width: 2.0,
//       ),
//       color: Colors.white,
//     ),
//     // child: const Icon(
//     //   Icons.camera,
//     //   size: 50,
//     // ),

//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: Image.network(
//         imageUrl,
//         fit: BoxFit.fill,
//         errorBuilder: (_, _o, _s) {
//           return Image.asset(
//             'images/01.png',
//             color: Colors.red,
//           );
//         },
//       ),
//     ),
//   );
// }

class ReportCardDetailsWidget extends StatelessWidget {
  const ReportCardDetailsWidget({
    super.key,
    required this.text,
    required this.icon,
    this.fontWeight = FontWeight.normal,
  });
  final String text;
  final IconData icon;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[100],
          border: Border.all(
            color: kDprimaryColor,
            width: 2.0,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: kDprimaryColor,
            radius: 20,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(icon),
            ),
          ),
          title: Text(
            text,
            style: GoogleFonts.almarai(fontWeight: fontWeight),
          ),
        ),
      ),
    );
  }
}

// Widget reportCardDetailsWidget({
//   required String text,
//   required IconData icon,
//   FontWeight fontWeight = FontWeight.normal,
// }) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//         border: Border.all(
//           color: kDprimaryColor,
//           width: 2.0,
//         ),
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: kDprimaryColor,
//           radius: 20,
//           child: CircleAvatar(
//             radius: 18,
//             backgroundColor: Colors.white,
//             child: Icon(icon),
//           ),
//         ),
//         title: Text(
//           text,
//           style: GoogleFonts.almarai(fontWeight: fontWeight),
//         ),
//       ),
//     ),
//   );
// }

class DefaultDropdownFormField extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final List<String> options;
  final double radius;
  //final ValueChanged<String>? onChanged;
  final void Function(String?)? onChanged;

  const DefaultDropdownFormField({
    Key? key,
    required this.labelText,
    required this.initialValue,
    required this.options,
    this.radius = 10,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      value: initialValue,
      // dropdownColor: Colors.grey[300],
      items: options.map<DropdownMenuItem<String>>((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
