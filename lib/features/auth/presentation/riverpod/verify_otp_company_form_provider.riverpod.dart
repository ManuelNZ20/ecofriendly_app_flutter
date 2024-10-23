import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier/verify_otp_notifier.dart';
import 'state/verify_otp_state.dart';

final otpCompanyFormProvider =
    StateNotifierProvider<VerifyOtpNotifier, VerifyOtpState>((ref) {
  final otpCompanyCallback = ref.watch(authProvider.notifier).otpCompany;
  return VerifyOtpNotifier(otpCallback: otpCompanyCallback);
});
