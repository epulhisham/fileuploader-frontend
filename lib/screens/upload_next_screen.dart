import 'package:file_picker/file_picker.dart';
import 'package:fileuploader_frontend/screens/upload_progress_screen.dart';
import 'package:flutter/material.dart';

class UploadNextScreen extends StatelessWidget {
  final List<PlatformFile> files;

  const UploadNextScreen({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    final totalSize = files.fold(0, (sum, file) => sum + file.size);
    final totalSizeMB = (totalSize / (1024 * 1024)).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        title: const Text(
          'Files Summary',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Total Files
              _buildCircularIndicator(
                title: "Total Files",
                value: files.length.toString(),
                unit: '',
              ),
              // Total Size
              _buildCircularIndicator(
                title: "Total Size",
                value: totalSizeMB,
                unit: 'MB',
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Key (example value)
              Column(
                children: const [
                  Icon(Icons.key, color: Colors.white70),
                  SizedBox(height: 8),
                  Text(
                    "234567",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              // Timer (example value)
              Column(
                children: const [
                  Icon(Icons.timer, color: Colors.white70),
                  SizedBox(height: 8),
                  Text(
                    "24 hrs left",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadProgressScreen(files: files),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Send',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator({
    required String title,
    required String value,
    required String unit,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 0.7, // Replace with dynamic value if available
                strokeWidth: 8,
                backgroundColor: Colors.white12,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
