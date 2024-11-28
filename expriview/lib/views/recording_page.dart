import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class RecordingPage extends StatefulWidget {
  final String intervieweeName;

  const RecordingPage({super.key, required this.intervieweeName});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with interviewee name
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Interview with ${widget.intervieweeName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Camera preview
            Expanded(
              child: _controller?.value.isInitialized ?? false
                  ? CameraPreview(_controller!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
