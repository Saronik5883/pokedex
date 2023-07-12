import 'package:flutter/material.dart';
import 'package:pokedex_app/utils/type_button_colors.dart';
import '../../../utils/capitalize.dart';
import '../screens/type_details.dart';

class TypeButton extends StatelessWidget {
  final String typeName;
  const TypeButton({super.key, required this.typeName,});

  @override
  Widget build(BuildContext context) {

    void navigateToTypeDetails(BuildContext context, String name, Color textColor, Color backgroundColor) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TypeDetails(
            typeName: name,
            textColor: textColor, backgroundColor: backgroundColor,
          ))
      );
    }


    final typeColor = TypeBottonColors();

    final color1 = typeColor.getTypeColors(typeName);
    final color2 = typeColor.getTextColor(typeName);


    return InkWell(
      onTap: () => navigateToTypeDetails(context, typeName, color1, color2),
      child: Chip(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        avatar: CircleAvatar(
          backgroundColor: color2,
          child: Image.asset(
            'assets/images/types/${capitalize(typeName)}.png',
            fit: BoxFit.contain,
          ),
        ),
        label: Text(
          capitalize(typeName),
          style: TextStyle(
            color: color2,
          ),
        ),
        backgroundColor: color1,
      ),
    );
  }
}
