class Watchface {
  final String title;
  final String preview;
  final String url;
  final int length;

  Watchface({
    required this.title,
    required this.preview,
    required this.url,
    required this.length,
  });

  factory Watchface.fromJson(Map<String, dynamic> json) {
    return Watchface(
        title: json['data'][0]['list'][0]['display_name'],
        preview: json['data'][0]['list'][0]['icon'],
        url: json['data'][0]['list'][0]['config_file'],
        length: json.length);
  }
}
