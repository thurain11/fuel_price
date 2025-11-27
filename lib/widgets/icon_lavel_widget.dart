import '../global.dart';

class IconLabelWidget extends StatelessWidget {
  IconData? iconName;
  double? size;
  double? padding;
  double? borderRadius;
  Color? color;
  IconLabelWidget({required this.iconName, this.size = 17.0, this.padding = 10.0, this.borderRadius = 15.0,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius!),
          color: color==null ? Theme.of(context).primaryColor.withOpacity(0.1): color!.withOpacity(0.1)),
      child: Icon(
        iconName,
        size: size,
        color: color==null ? Theme.of(context).primaryColor : color,
      ),
    );
  }
}