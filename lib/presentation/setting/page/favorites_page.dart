import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách các mục yêu thích mẫu
    final favoriteItems = [
      {'title': 'Item 1', 'image': 'https://png.pngtree.com/png-clipart/20230511/ourmid/pngtree-isolated-cat-on-white-background-png-image_7094927.png', 'price': '\$20'},
      {'title': 'Item 2', 'image': 'https://png.pngtree.com/png-clipart/20230511/ourmid/pngtree-isolated-cat-on-white-background-png-image_7094927.png', 'price': '\$35'},
      {'title': 'Item 3', 'image': 'https://png.pngtree.com/png-clipart/20230511/ourmid/pngtree-isolated-cat-on-white-background-png-image_7094927.png', 'price': '\$50'},
      {'title': 'Item 4', 'image': 'https://png.pngtree.com/png-clipart/20230511/ourmid/pngtree-isolated-cat-on-white-background-png-image_7094927.png', 'price': '\$15'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconAppbar(),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favoriteItems.isNotEmpty
            ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Hiển thị 2 cột
            crossAxisSpacing: 16, // Khoảng cách giữa các cột
            mainAxisSpacing: 16, // Khoảng cách giữa các hàng
            childAspectRatio: 0.75, // Tỷ lệ khung hình của mỗi mục
          ),
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteItems[index];
            return _favoriteCard(
              title: item['title']!,
              image: item['image']!,
              price: item['price']!,
            );
          },
        )
            : const Center(
          child: Text(
            'No favorites added yet.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _favoriteCard({
    required String title,
    required String image,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        // Xử lý khi nhấn vào mục yêu thích
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh sản phẩm
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            // Tên sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Giá và nút yêu thích
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Xử lý xóa khỏi danh sách yêu thích
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
