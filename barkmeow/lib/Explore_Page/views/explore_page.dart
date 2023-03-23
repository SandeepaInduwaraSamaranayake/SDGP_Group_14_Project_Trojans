// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';

// class ExplorePage extends StatefulWidget {
//   const ExplorePage({Key? key}) : super(key: key);

//   @override
//   _ExplorePageState createState() => _ExplorePageState();
// }

// class _ExplorePageState extends State<ExplorePage> {
//   final List<Map<String, dynamic>> items = [
//     {
//       'title': 'Item 1',
//       'image': "assets/images/explore_page/image1.jpg",
//     },
//     {
//       'title': 'Item 2',
//       'image': 'assets/images/explore_page/image2.jpg',
//     },
//     {
//       'title': 'Item 3',
//       'image': 'assets/images/explore_page/image3.jpg',
//     },
//   ];
//   List<Map<String, dynamic>> filteredItems = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredItems = items;
//   }

//   void _filterItems(String query) {
//     setState(() {
//       filteredItems = items
//           .where((item) =>
//               item['title'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     int currentIndex = 0;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       //Navigator Bar
//       bottomNavigationBar: BottomNavigation(
//         currentIndex: currentIndex,
//       ),
//       body: Column(
//         children: <Widget>[
//           const SizedBox(height: 3.0),
//           Container(
//             padding: const EdgeInsets.all(2.0),
//             decoration: BoxDecoration(
//               color: Colors.black38,
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             child: TextField(
//               decoration: const InputDecoration(
//                 suffixIcon: Icon(Icons.search),
//                 hintText: 'Search...',
//               ),
//               onChanged: _filterItems,
//             ),
//           ),
//           Expanded(
//             child: StaggeredGridView.countBuilder(
//               crossAxisCount: 2,
//               itemCount: filteredItems.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/item',
//                         arguments: filteredItems[index]);
//                   },
//                   child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         side: BorderSide(
//                           color: Colors.grey.withOpacity(0.2),
//                           width: 1.0,
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: Image.asset(
//                           filteredItems[index]['image'],
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 150,
//                         ),
//                       )),
//                 );
//               },
//               staggeredTileBuilder: (int index) {
//                 if (index == 0) {
//                   return const StaggeredTile.count(1, 1.8);
//                 } else if (index == 1) {
//                   return const StaggeredTile.count(1, 0.9);
//                 } else if (index == 2) {
//                   return const StaggeredTile.count(1, 0.9);
//                 } else {
//                   return const StaggeredTile.count(2, 0.8);
//                 }
//               },
//               mainAxisSpacing: 4.0,
//               crossAxisSpacing: 4.0,
//             ),
//           ),
//         ],
//       ),
//       //bottomNavigationBar: const MyBottomNavigationBar(),
//     );
//   }
// }
