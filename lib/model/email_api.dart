import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailApi {
  final userName;
  final userPhone;
  final userEmail;
  final userModel;
  final userProblem;

  EmailApi(
    this.userName,
    this.userPhone,
    this.userEmail,
    this.userModel,
    this.userProblem,
  );

  Future<String> sendEmail() async {
    String status;
    final serviceId = 'service_jy00pfr';
    final templateId = 'template_kjny1hx';
    final userId = 'user_LDIqsbkjpjjxAzTLYSHez';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': userName,
          'user_phone': userPhone,
          'user_email': userEmail,
          'user_model': userModel,
          'user_problem': userProblem,
        }
      }),
    );

    status = response.body;
    print(response.body);
    return status;
  }
}
