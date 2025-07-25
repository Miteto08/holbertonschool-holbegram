import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isSearching = value.isNotEmpty;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Images Grid
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No posts found'),
                  );
                }

                var posts = snapshot.data!.docs;
                
                // Filter posts if searching
                if (_isSearching) {
                  posts = posts.where((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    String caption = data['caption']?.toString().toLowerCase() ?? '';
                    String username = data['username']?.toString().toLowerCase() ?? '';
                    String searchTerm = _searchController.text.toLowerCase();
                    return caption.contains(searchTerm) || username.contains(searchTerm);
                  }).toList();
                }

                return MasonryGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var data = posts[index].data() as Map<String, dynamic>;
                    String imageUrl = data['imageUrl'] ?? '';
                    
                    return GestureDetector(
                      onTap: () {
                        // Handle image tap - could show full image or post details
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                width: double.infinity,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 