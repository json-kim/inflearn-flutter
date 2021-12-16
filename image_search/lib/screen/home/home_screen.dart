import 'package:flutter/material.dart';
import 'package:image_search/data/api.dart';
import 'package:image_search/model/photo.dart';

import 'components/photo_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  // Pixabay 객체에 대해 의존성을 가진 상태
  final api = PixabayApi();

  List<Photo> _photos = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                suffixIcon: IconButton(
                  onPressed: () async {
                    //TODO: 검색
                    final query = _controller.text;
                    final photos = await api.fetchPhotos(query);
                    setState(() {
                      _photos = photos;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: _photos.length,
                itemBuilder: (context, idx) => PhotoBox(
                  photo: _photos[idx],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
