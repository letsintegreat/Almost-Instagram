class Post {
  String image;
  String name;
  String location;
  String post;
  String caption;
  String date;
  bool liked;
  Post(
      {required this.image,
      required this.name,
      this.location = "Tokyo, Japan",
      required this.post,
      required this.caption,
      this.date = "12 September",
      this.liked = false});
}
