import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final sessionProvider = Provider<Session?>((ref) {
  return ref.watch(authStateProvider).value?.session;
});

final userProvider = Provider<User?>((ref) {
  return ref.watch(sessionProvider)?.user;
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier() : super(const AsyncValue.data(null));

  final _supabase = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _supabase.auth.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
      return AuthNotifier();
    });
