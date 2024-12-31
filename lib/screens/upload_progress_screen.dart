import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:fileuploader_frontend/screens/upload_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UploadProgressScreen extends StatefulWidget {
  final List<PlatformFile> files;

  const UploadProgressScreen({super.key, required this.files});

  @override
  _UploadProgressScreenState createState() => _UploadProgressScreenState();
}

class _UploadProgressScreenState extends State<UploadProgressScreen> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    startUpload();
  }

  void startUpload() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progress >= 1.0) {
        timer.cancel();
        saveToDatabase();
      } else {
        setState(() {
          progress += 0.02; // Increment progress by 2%
        });
      }
    });
  }

  Future<void> saveToDatabase() async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    final url = '$baseUrl/uploads';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add files
    for (var file in widget.files) {
      if (file.path == null) {
        continue;
      }
      request.files.add(await http.MultipartFile.fromPath(
        'files[]', // Use the same key as your backend expects
        file.path!,
      ));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // On success, navigate to the success screen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UploadSuccessScreen()),
          );
        }
      } else {
        print('Failed to upload files: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Uploading...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
