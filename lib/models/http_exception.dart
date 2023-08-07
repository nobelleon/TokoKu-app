class HttpException implements Exception {
  final String pesan;

  HttpException(this.pesan);

  @override
  String toString() {
    return pesan;
    //return super.toString();   // Instance of HttpException
  }
}
