import 'package:fileuploader_frontend/screens/file_upload_screen.dart';
import 'package:flutter/material.dart';

class UploadSuccessScreen extends StatelessWidget {
  const UploadSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        title: const Text(
          'Finish',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Successfully Uploaded!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            // Circular success icon
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Link display with copy and share buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'tlyport.to/zafran/234',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add functionality to copy link
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Link copied!')),
                            );
                          },
                          icon: const Icon(Icons.copy, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add functionality to share
                          },
                          icon: const Icon(Icons.share, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Sign Up button
            ElevatedButton(
              onPressed: () {
                // Add sign-up functionality
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FileUploadScreen(),
                  ),
                  (route) => false, // Remove all previous routes
                );
              },
              child: const Text(
                'Send Again',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.lightGreenAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
