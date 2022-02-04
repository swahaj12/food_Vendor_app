import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider with ChangeNotifier {
  String selectedCategory = 'Not Selected';
  String selectedSubCategory = 'Not Selected';
  late File image;
  String pickerError = '';
  selectCategory(selected) {
    this.selectedCategory = selected;
    notifyListeners();
  }

  selectSubCategory(selected) {
    this.selectedSubCategory = selected;
    notifyListeners();
  }

  Future<File> getProductImage() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    if (pickedFile != null) {
      this.image = File(pickedFile.path);
      notifyListeners();
    } else {
      this.pickerError = 'no image selected';
      print('no image selected');
      notifyListeners();
    }
    return this.image;
  }
}
