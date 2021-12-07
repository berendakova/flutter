import 'image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'image_store.g.dart';

// This is the class used by rest of your codebase
class ImageStore = _ImageStore with _$ImageStore;

// The store-class
abstract class _ImageStore with Store {
  @observable
  ObservableList<ImageDetails> images = ObservableList.of([]);

  @action
  void fetchImageFromCamera({Function? onAdd}) {
    ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      var img = ImageDetails(file: value, title: 'Img #' + Uuid().v1(), description: 'Beautiful img');
      this.images.add(img);
      if (onAdd != null) {
        onAdd();
      }
      print(this.images);
    }).catchError((error) {
      print(error.toString());
    });
  }

  @action
  void fetchImageFromGallery({Function? onAdd}) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      this.images.add(ImageDetails(file: value, title: 'Img #' +  Uuid().v1(), description: 'Beautiful img'));
      if (onAdd != null) {
        onAdd();
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}