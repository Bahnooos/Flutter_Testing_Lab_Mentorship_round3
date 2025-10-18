import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/app_regex.dart';
import 'package:flutter_testing_lab/widgets/password_validation.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool hasValidEmail = false;
  bool hasValidName = false;

  bool _isLoading = false;
  String _message = '';
  void setupPasswordListener() {
    _passwordController.addListener(() {
      setState(() {
        hasMinLength = AppRegex.hasMinLength(_passwordController.text);
        hasNumber = AppRegex.hasNumber(_passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          _passwordController.text,
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setupPasswordListener();
    _emailController.addListener(() {
      setState(() {
        hasValidEmail = AppRegex.isEmailValid(_emailController.text);
      });
    });

    _nameController.addListener(() {
      setState(() {
        hasValidName = AppRegex.hasMinLengthForName(_nameController.text);
      });
    });
  }

  bool isValidEmail(String email) {
    return AppRegex.isEmailValid(email);
  }

  bool isValidPassword(String password) {
    return AppRegex.isPasswordValid(password);
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = false;
        _message = 'Please fix the errors in the form.';
      });
      return;
    } else {
      setState(() {
        _isLoading = false;
        _message = 'Registration successful!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (!AppRegex.hasMinLengthForName(value)) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              buildValidationRow('At least 2 characters', hasValidName),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!isValidEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              buildValidationRow('Valid email format', hasValidEmail),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (!isValidPassword(value)) {
                    return 'Password is too weak';
                  }
                  return null;
                },
              ),
              PasswordValidations(
                hasSpecialCharacters: hasSpecialCharacters,
                hasNumber: hasNumber,
                hasMinLength: hasMinLength,
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
              if (_message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _message,
                    style: TextStyle(
                      color: _message.contains('successful')
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
