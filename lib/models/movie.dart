




class Movie{

  final String title;
  final String poster_path;
  final String release_date;
  final String vote_average;
  final String overview;

  Movie({
    required this.title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.vote_average
});

factory Movie.fromJson(Map<String, dynamic> json){
  return Movie(
      title: json['title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      release_date: json['release_date'],
      vote_average: '${json['vote_average']}'
  );

}




}



