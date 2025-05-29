import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_applications_flutter/core/ui/components/button.dart';
import 'package:tv_applications_flutter/core/ui/components/input.dart';
import 'package:tv_applications_flutter/features/auth/presentation/providers/auth_provider.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _isResending = false;
  bool _isVerifying = false;

  final TextEditingController _verification = TextEditingController();

  Future<void> _resendVerificationEmail() async {
    setState(() => _isResending = true);
    try {
      // final authProvider = context.read<AuthProvider>();
     // await authProvider.resendVerificationEmail(widget.email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification email sent successfully'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to resend verification email: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  Future<void> _checkVerificationStatus() async {
    setState(() => _isVerifying = true);
    try {
      final authProvider = context.read<AuthProvider>();
      final isVerified = await authProvider.checkEmailVerification(widget.email,_verification.text );
      if (isVerified && mounted) {
        context.go('/dashboard');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not verified yet. Please check your inbox.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to verify email: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.mark_email_unread_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Verify your email',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'We sent a verification email to:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                ShadcnInput(
                  controller: _verification,
                  label: 'Verification code',
                  hintText: 'Enter your verification code',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ShadcnButton(
                  onPressed: _checkVerificationStatus,
                  isLoading: _isVerifying,
                  isFullWidth: true,
                  child: const Text('I\'ve verified my email'),
                ),
                const SizedBox(height: 16),
                ShadcnButton(
                  onPressed: _resendVerificationEmail,
                  isLoading: _isResending,
                  variant: ButtonVariant.outline,
                  isFullWidth: true,
                  child: const Text('Resend verification email'),
                ),
                const SizedBox(height: 16),
                ShadcnButton(
                  onPressed: () => context.go('/login'),
                  variant: ButtonVariant.link,
                  child: const Text('Back to login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 