// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ChooseBar extends StatefulWidget {
//   const ChooseBar({super.key});

//   @override
//   State<ChooseBar> createState() => _ChooseBarState();
// }

// class _ChooseBarState extends State<ChooseBar> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       child: Container(
//         height: 41.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           color: Color(0xFF32363C),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedIndex = 0;
//                     });
//                   },
//                   child: Container(
//                     width: 80.w,
//                     height: 33.h,
//                     decoration: BoxDecoration(
//                       color: _selectedIndex == 0
//                           ? Color(0xFF2A2D32)
//                           : Color(0xFF32363C),
//                       borderRadius: BorderRadius.circular(6.r),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Markets",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedIndex = 1;
//                     });
//                   },
//                   child: Container(
//                     width: 80.w,
//                     height: 33.h,
//                     decoration: BoxDecoration(
//                       color: _selectedIndex == 1
//                           ? Color(0xFF2A2D32)
//                           : Color(0xFF32363C),
//                       borderRadius: BorderRadius.circular(6.r),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "PR&Team",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedIndex = 2;
//                     });
//                   },
//                   child: Container(
//                     width: 80.w,
//                     height: 33.h,
//                     decoration: BoxDecoration(
//                       color: _selectedIndex == 2
//                           ? Color(0xFF2A2D32)
//                           : Color(0xFF32363C),
//                       borderRadius: BorderRadius.circular(6.r),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Legal",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedIndex = 3;
//                     });
//                   },
//                   child: Container(
//                     width: 80.w,
//                     height: 33.h,
//                     decoration: BoxDecoration(
//                       color: _selectedIndex == 3
//                           ? Color(0xFF2A2D32)
//                           : Color(0xFF32363C),
//                       borderRadius: BorderRadius.circular(6.r),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Specials",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
