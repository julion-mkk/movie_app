import 'package:movie_app/model/Video.dart';

class VideoResponse {
    final List<Video> videos;
    final String error;

    VideoResponse(this.videos,this.error);

    VideoResponse.fromJson(Map<String,dynamic> json) :
        videos = (json["videos"] as List).map((i) => new Video.fromJson(i)).toList(),
        error = "";

    VideoResponse.withError(String errorValue) :
        videos = List(),
        error = errorValue;
}