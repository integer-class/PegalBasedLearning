import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../services/api_service.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class RecordingPage extends StatefulWidget {
  final String intervieweeName;
  final int intervieweeId;

  const RecordingPage({
    super.key,
    required this.intervieweeName,
    required this.intervieweeId,
  });

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final ApiService _apiService = ApiService();
  CameraController? _controller;
  Timer? _timer;
  String? _currentEmotion;
  bool _isProcessing = false;
  bool _isRecording = false;

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
        _startCapturing();
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void _startCapturing() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_controller?.value.isInitialized ?? false) {
        if (!_isProcessing && _isRecording) {
          _captureAndAnalyze();
        }
      }
    });
  }

  Future<void> _captureAndAnalyze() async {
    try {
      setState(() => _isProcessing = true);

      final XFile image = await _controller!.takePicture();

      try {
        final response = await _apiService
            .analyzeEmotion(kIsWeb ? await image.readAsBytes() : image.path);

        setState(() {
          _currentEmotion =
              '${response.emotion} (${(response.confidence * 100).toStringAsFixed(1)}%)';
          _isProcessing = false;
        });

        if (!kIsWeb) {
          await File(image.path).delete();
        }
      } catch (e) {
        setState(() {
          _currentEmotion = e.toString().contains('No faces detected')
              ? 'No face detected'
              : 'Error analyzing emotion';
          _isProcessing = false;
        });
      }
    } catch (e) {
      debugPrint('Error capturing/analyzing frame: $e');
      setState(() {
        _currentEmotion = 'Error capturing image';
        _isProcessing = false;
      });
    }
  }

  Future<void> _toggleRecording() async {
    try {
      if (!_isRecording) {
        // Start session
        await _apiService.startSession();
        setState(() => _isRecording = true);
      } else {
        // End session and get results
        final emotionCounts =
            await _apiService.endSession(widget.intervieweeId);
        setState(() => _isRecording = false);

        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Session Results'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Angry: ${emotionCounts['angry']}'),
                  Text('Disgust: ${emotionCounts['disgust']}'),
                  Text('Fear: ${emotionCounts['fear']}'),
                  Text('Happy: ${emotionCounts['happy']}'),
                  Text('Sad: ${emotionCounts['sad']}'),
                  Text('Surprise: ${emotionCounts['surprise']}'),
                  Text('Neutral: ${emotionCounts['neutral']}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _isRecording = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview (full screen)
          if (_controller?.value.isInitialized ?? false)
            Container(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(_controller!),
            ),

          // Header with interviewee name (overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
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
          ),

          // Bottom controls (overlay)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Emotion overlay
                if (_currentEmotion != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Emotion: $_currentEmotion',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),

                // Recording button
                Center(
                  child: GestureDetector(
                    onTap: _toggleRecording,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        color: _isRecording ? Colors.red : Colors.black87,
                      ),
                      child: Center(
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isRecording ? Colors.red : Colors.white,
                              width: 2,
                            ),
                            color: _isRecording ? Colors.red : Colors.black87,
                          ),
                        ),
                      ),
                    ),
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
