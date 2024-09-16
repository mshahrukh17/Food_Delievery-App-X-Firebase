// ignore_for_file: file_names

import 'AllExport.dart';

void message(error, message) {
  Get.snackbar(error, message,
      snackPosition: SnackPosition.TOP,
      borderColor: error == "Error" ? Colors.red : Colors.green,
      backgroundColor: Colors.grey.shade200,
      borderRadius: 20,
      borderWidth: 3,
      duration: const Duration(seconds: 1));
}
