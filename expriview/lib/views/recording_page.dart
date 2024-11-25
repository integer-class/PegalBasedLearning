import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class RecordingPage extends StatefulWidget {
  final String intervieweeName;

  const RecordingPage({super.key, required this.intervieweeName});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  CameraController? _controller;
  bool _isRecording = false;
  Timer? _timer;
  int _frameCount = 0;

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
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _frameCount = 0;
    });

    // Capture frame every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (_controller != null && _controller!.value.isInitialized) {
        try {
          final image = await _controller!.takePicture();
          setState(() {
            _frameCount++;
          });
          
          // Here you would send the image to your API
          debugPrint('Frame captured: ${image.path}');
          // TODO: Implement API call here
          
        } catch (e) {
          debugPrint('Error capturing frame: $e');
        }
      }
    });
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Recording: ${widget.intervieweeName}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_isRecording)
                  Text(
                    'Frames captured: $_frameCount',
                    style: const TextStyle(fontSize: 16),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording ? Colors.red : Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: Text(
                    _isRecording ? 'Stop Recording' : 'Start Recording',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 