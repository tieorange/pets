// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies

mixin _$PostsStore on PostsStoreBase, Store {
  final _$postsListAtom = Atom(name: 'PostsStoreBase.postsList');

  @override
  List<Post> get postsList {
    _$postsListAtom.reportObserved();
    return super.postsList;
  }

  @override
  set postsList(List<Post> value) {
    _$postsListAtom.context
        .checkIfStateModificationsAreAllowed(_$postsListAtom);
    super.postsList = value;
    _$postsListAtom.reportChanged();
  }

  final _$PostsStoreBaseActionController =
      ActionController(name: 'PostsStoreBase');

  @override
  dynamic getPosts() {
    final _$actionInfo = _$PostsStoreBaseActionController.startAction();
    try {
      return super.getPosts();
    } finally {
      _$PostsStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
