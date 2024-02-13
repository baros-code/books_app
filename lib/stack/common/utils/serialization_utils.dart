import 'dart:convert';

abstract class SerializationUtils {
  /// Deserializes a JSON string into a model that has 'fromJson'
  /// factory constructor implemented.
  static TModel fromJsonString<TModel>(String str) {
    return (TModel as dynamic).fromJson(json.decode(str));
  }

  /// Serializes a model that has 'toJson' method implemented
  /// into a JSON string.
  static String toJsonString<TModel>(TModel data) {
    return json.encode((data as dynamic).toJson());
  }
}
