// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageStore on _ImageStore, Store {
  final _$imagesAtom = Atom(name: '_ImageStore.images');

  @override
  ObservableList<ImageDetails> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(ObservableList<ImageDetails> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  final _$_ImageStoreActionController = ActionController(name: '_ImageStore');

  @override
  void fetchImageFromCamera({Function? onAdd}) {
    final _$actionInfo = _$_ImageStoreActionController.startAction(
        name: '_ImageStore.fetchImageFromCamera');
    try {
      return super.fetchImageFromCamera(onAdd: onAdd);
    } finally {
      _$_ImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchImageFromGallery({Function? onAdd}) {
    final _$actionInfo = _$_ImageStoreActionController.startAction(
        name: '_ImageStore.fetchImageFromGallery');
    try {
      return super.fetchImageFromGallery(onAdd: onAdd);
    } finally {
      _$_ImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
images: ${images}
    ''';
  }
}