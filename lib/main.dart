import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _onlineController;
  late VideoPlayerController _offlineController;
  late Future<void> _initializeOnlineVideoPlayerFuture;
  late Future<void> _initializeOfflineVideoPlayerFuture;
  

  @override
  void initState() {
    super.initState();
    _onlineController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _initializeOnlineVideoPlayerFuture = _onlineController.initialize();
    _onlineController.setLooping(true);

    _offlineController = VideoPlayerController.asset(
        '/Users/prachi/Documents/pr/ios/Runner/Assets.xcassets/sample_video.mp4');
    _initializeOfflineVideoPlayerFuture = _offlineController.initialize();
    _offlineController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player by D22IT212 Prachi'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _initializeOnlineVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        AspectRatio(
                          aspectRatio: _onlineController.value.aspectRatio,
                          child: VideoPlayer(_onlineController),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_onlineController.value.isPlaying) {
                                _onlineController.pause();
                              } else {
                                _onlineController.play();
                              }
                            });
                          },
                          child: Icon(
                            _onlineController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 20),
              FutureBuilder(
                future: _initializeOfflineVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        AspectRatio(
                          aspectRatio: _offlineController.value.aspectRatio,
                          child: VideoPlayer(_offlineController),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_offlineController.value.isPlaying) {
                                _offlineController.pause();
                              } else {
                                _offlineController.play();
                              }
                            });
                          },
                          child: Icon(
                            _offlineController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 20),
              Image.asset(
                '/Users/prachi/Documents/pr/ios/Runner/Assets.xcassets/placeholder_image.jpg', // Use the relative path here
                width: 300,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _onlineController.dispose();
    _offlineController.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: MyVideoPlayer(),
    debugShowCheckedModeBanner: false,
  ));
}
