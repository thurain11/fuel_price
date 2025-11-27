

import '../global.dart';

class MyCard extends StatelessWidget {
  Widget? child;
  Function? onTap;
  Color? color;
  double borderRadius;
  double? ml, mr, mt, mb, pl, pr, pt, pb, ma, pa, mh, mv, ph, pv;
  BoxBorder? border;
  double? width;
  bool hasBoxShadow;

  MyCard(
      {this.child,
        this.onTap,
        this.borderRadius = 8,
        this.ml = 8,
        this.mr = 8,
        this.mb = 8,
        this.mt = 8,
        this.pb = 8,
        this.pt = 8,
        this.pr = 8,
        this.pl = 8,
        this.ma,
        this.pa,
        this.mh,
        this.mv,
        this.ph,
        this.pv,
        this.color,
        this.border,
        this.width,
        this.hasBoxShadow = false}) {
    if (this.pa != null) {
      pl = pa;
      pr = pa;
      pb = pa;
      pt = pa;
    }

    if (this.mh != null) {
      ml = mh;
      mr = mh;
    }
    if (this.mv != null) {
      mt = mv;
      mb = mv;
    }
    if (this.ph != null) {
      pl = ph;
      pr = ph;
    }
    if (this.pv != null) {
      pt = pv;
      pb = pv;
    }

    if (this.ma != null) {
      ml = ma;
      mr = ma;
      mb = ma;
      mt = ma;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left: ml!, right: mr!, top: mt!, bottom: mb!),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          boxShadow:
          hasBoxShadow ? [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 1, offset: Offset(0.1, 2),
                spreadRadius: 0.3),
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 1, offset: Offset(0.1, -0.6),
                spreadRadius: 0.3),

                ]

              : [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: .5, offset: Offset(0.1, 1.3),
                spreadRadius: 0.1),

            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: .5, offset: Offset(0.7, -0.6),
                spreadRadius: 0.1),


          ] ),
      child: Material(
        color: Colors.transparent,

        child: InkWell(
          // hoverColor: Colors.red,
          splashColor: Theme.of(context).cardColor,
          child: Padding(padding: EdgeInsets.only(left: pl!, right: pr!, top: pt!, bottom: pb!), child: child),
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap as void Function()?,
        ),
      ),
    );
  }
}
