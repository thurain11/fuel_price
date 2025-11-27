// import 'package:flutter/material.dart';
//
// class LoadingWidget extends StatelessWidget {
//   final double size;
//   final Color color;
//   LoadingWidget({this.size = 40, this.color = Colors.black54});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//           width: size,
//           height: size,
//           child: CircularProgressIndicator(),
//
//         ),
//       ),
//     );
//   }
// }

import 'package:shimmer/shimmer.dart';

import '../global.dart';

class ShimmerLoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Loading ဖြစ်နေစဉ် ပြသမယ့် item အရေအတွက်
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(width: 50.0, height: 50.0, color: Colors.white),
            title: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.white,
            ),
            subtitle: Container(
              width: double.infinity,
              height: 12.0,
              color: Colors.white,
            ),
            trailing: Icon(Icons.more_vert_outlined),
          ),
        );
      },
    );
  }
}

class ShimmerLoadingWidget extends StatelessWidget {
  double? width;
  double? height;
  ShimmerLoadingWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white, // background color for the container
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  double size;
  LoadingWidget({this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 12,
          color: Theme.of(context).primaryColor,
        ),
        // child: Stack(
        //   children: <Widget>[
        //     // Align(
        //     //   alignment: Alignment.center,
        //     //   child: ClipRRect(
        //     //     borderRadius: BorderRadius.circular(size),
        //     //     child: Container(
        //     //       alignment: Alignment.center,
        //     //       decoration: BoxDecoration(
        //     //         // color: Theme.of(context).primaryColor.withOpacity(0.7),
        //     //         borderRadius: BorderRadius.circular(50),
        //     //       ),
        //     //       width: size,
        //     //       height: size,
        //     //       // child: Lottie.asset('assets/anim/load.json'),
        //     //      child:  Text("Up+",
        //     //         textAlign: TextAlign.center,
        //     //         style: GoogleFonts.cherrySwash(
        //     //         textStyle: TextStyle(color: Theme.of(context).primaryColor, letterSpacing: .5,fontSize: 16,fontWeight: FontWeight.bold),
        //     //       ),),
        //     //     ),
        //     //   ),
        //     // ),
        //     Align(
        //       child: SpinKitCircle(
        //         size: size+20,
        //         color: BuildThemeData.greenM3,
        //         // lineWidth: 2,
        //       ),
        //       alignment: Alignment.center,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
