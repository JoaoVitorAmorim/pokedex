abstract interface class IServiceWebResponse {
  final String body;
  final int statusCode;
  final Map<String, String> headers;

  const IServiceWebResponse(this.body, this.statusCode, this.headers);
}
