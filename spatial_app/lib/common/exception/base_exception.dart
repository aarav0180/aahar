/// The [BaseException] class serves as a base class for custom exceptions.
/// It implements the [Exception] interface and provides a structure for
/// defining exceptions with an optional code and a message.
///
///
///
/// Example of extending [BaseException]:
///
/// ```
/// class NetworkException extends BaseException {
///   final int statusCode;
///
///   const NetworkException(String message, {String? code, required this.statusCode})
///       : super(message, code: code);
///
///   @override
///   String toString() {
///     return "NetworkException: $message (status code: $statusCode)";
///   }
/// }
/// ```
///
/// Usage:
///
/// ```
/// void fetchData() {
///   try {
///     // Simulate a network call that fails
///     throw NetworkException("Failed to fetch data", statusCode: 404);
///   } catch (e) {
///     print(e); // Output: NetworkException: Failed to fetch data (status code: 404)
///   }
/// }
///
/// void main() {
///   fetchData();
/// }
/// ```
class BaseException implements Exception {

  /// An optional error code to identify the exception type.
  final String? code;

  /// A message describing the exception.
  final String message;

  const BaseException(this.message, {this.code});

  @override
  /// Returns a string representation of the exception.
  String toString() {
    return "Exception: $message";
  }
}
