import 'package:flutter/material.dart';

import '../screens/type_details.dart';

class TypeWidget extends StatefulWidget {
  final String typeName;
  final Color fontColor;
  final Color cardColor;
  const TypeWidget({
    super.key,
    required this.typeName,
    required this.fontColor,
    required this.cardColor
  });

  @override
  State<TypeWidget> createState() => _TypeWidgetState();
}

void navigateToTypeDetails(BuildContext context, String name, Color textColor, Color backgroundColor) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TypeDetails(
        typeName: name,
        textColor: textColor, backgroundColor: backgroundColor,
      ))
  );
}

class _TypeWidgetState extends State<TypeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width/2.25,
      child: Card(
        color: widget.cardColor,
        child: ListTile(
          onTap: () {
            navigateToTypeDetails(context, widget.typeName.toLowerCase(), widget.cardColor, widget.fontColor);
          },
          leading: CircleAvatar(
              backgroundColor: widget.fontColor,
              backgroundImage: AssetImage(
                  'assets/images/types/${widget.typeName}.png'
              )
          ),
          title: Text(
            widget.typeName,
            style: TextStyle(
                color: widget.fontColor,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}
