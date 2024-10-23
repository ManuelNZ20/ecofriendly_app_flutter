import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier/verify_otp_notifier.dart';
import 'state/verify_otp_state.dart';

final otpUserFormProvider =
    StateNotifierProvider<VerifyOtpNotifier, VerifyOtpState>((ref) {
  final otpUserCallback = ref.watch(authProvider.notifier).otpUser;
  return VerifyOtpNotifier(
    otpCallback: otpUserCallback,
  );
});
