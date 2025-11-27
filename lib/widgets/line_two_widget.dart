

import '../global.dart';

class LineTwoWidget extends StatelessWidget {
  String? title;
  String? value;
  TextStyle? titleTextStyle;
  TextStyle? valueTextStyle;
  bool isLineOne;
  LineTwoWidget({required this.title, required this.value, this.titleTextStyle, this.valueTextStyle,this.isLineOne = false});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: titleTextStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold,),
          ),

          if(!isLineOne)
          Text(
            value ?? '',
            style: valueTextStyle ?? Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
    ;
  }
}
