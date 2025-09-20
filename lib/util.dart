import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveGrantId(int grantId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('pendingGrant', grantId.toString());
}

Future<String?> loadGrantId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('pendingGrant');
}
