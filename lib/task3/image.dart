import 'package:image_picker/image_picker.dart';

class ImageDetails {
  final String title;
  final String description;
  final XFile? file;

  ImageDetails({
    required this.file,
    required this.title,
    required this.description,
  });
}