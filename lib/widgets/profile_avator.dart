//
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../../../global.dart';
//
// class ProfileAvatarWidget extends StatelessWidget {
//   String? url;
//   double size;
//   ProfileAvatarWidget({this.url, this.size = 45});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(width: 1, color: Colors.grey.shade300)),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         clipBehavior: Clip.antiAlias,
//         child: CachedNetworkImage(
//           fit: BoxFit.fill,
//           imageUrl: url ?? '',
//           placeholder: (context, url) => Icon(CupertinoIcons.person_crop_rectangle),
//           errorWidget: (context, url, err) => Icon(CupertinoIcons.person_crop_rectangle, color: Colors.grey.shade300),
//         ),
//       ),
//     );
//   }
// }
