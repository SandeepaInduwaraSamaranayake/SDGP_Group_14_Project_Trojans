import 'package:flutter/material.dart';

import '../../Bottom_Nav_Bar/nav_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final int _selectedIndex = 1;

  final List<String> _categories = [
    'Trending',
    'Pet Food',
    'Pet Fashion',
    'Pet Fitness',
    'Pet Stores',
  ];

  final List<String> _images = [
    'https://picsum.photos/id/237/200/300',
    'https://images.unsplash.com/photo-1472491235688-bdc81a63246e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80/300/300',
    'https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZG9nc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60/300/300',
    'https://images.unsplash.com/photo-1587300003388-59208cc962cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80/300/300',
    'https://images.unsplash.com/photo-1477884213360-7e9d7dcc1e48?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80/300/300',
    'https://images.unsplash.com/photo-1558788353-f76d92427f16?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=438&q=80/300/300',
    'https://images.unsplash.com/photo-1605568427561-40dd23c2acea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80/300/300',
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(_categories[index]),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(_images.length, (index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        _images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
