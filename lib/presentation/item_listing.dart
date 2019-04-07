import 'package:adaptive_master_detail_layouts/domain/Post.dart';
import 'package:adaptive_master_detail_layouts/presentation/item.dart';
import 'package:adaptive_master_detail_layouts/repository/posts_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:meta/meta.dart';

/*class ItemListing extends StatelessWidget {
  ItemListing({
    @required this.itemSelectedCallback,
    this.selectedItem,
  });

  final ValueChanged<Item> itemSelectedCallback;
  final Item selectedItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: buildList(),
    );
  }

  List<ListTile> buildList() {
    return items.map((item) {
      return ListTile(
        title: Text(item.title),
        onTap: () => itemSelectedCallback(item),
        selected: selectedItem == item,
      );
    }).toList();
  }
}*/

class ItemListing extends StatefulWidget {
  @override
  _ItemListingState createState() => _ItemListingState();
}

class _ItemListingState extends State<ItemListing> {
  final postsStore = PostsStore();

  @override
  void initState() {
    super.initState();
    postsStore.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          var dataIsValid = ((postsStore.postsList != null) &&
                (postsStore.postsList.isNotEmpty));

          return dataIsValid
            ? buildList(postsStore.postsList)
            : buildProgress();
        },
      ),
    );
  }

  buildList(List<Post> postsList) {
    return postsList.map((item) {
      return ListTile(
        title: Text(item.title),
        subtitle: Text(item.body),
      );
    }).toList();
  }

  buildProgress() => Text('loading');
}
