import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/photo_box.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Pixabay 객체에 대해 의존성을 가진 상태
  // 인스턴스 생성을 클래스 안에서 하는건 피하고 외부에서 생성를 한 뒤 받아서 사용하는게 바람직하다

  final _controller = TextEditingController();

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
                    context.read<HomeViewModel>().fetch(query);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Consumer<HomeViewModel>(
              builder: (_, viewModel, child) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: viewModel.photos.length,
                    itemBuilder: (context, idx) => PhotoBox(
                      photo: viewModel.photos[idx],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
