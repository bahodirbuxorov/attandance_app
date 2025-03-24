import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isObscured = useState(true);
    final isLoading = useState(false);

    return Center(
      child: SingleChildScrollView(
        child: Animate(
          effects: [FadeEffect(), SlideEffect(begin: const Offset(0, 0.1))],
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Xush kelibsiz",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    "Iltimos, tizimga kirish uchun ma'lumotlaringizni kiriting.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(24),
                  IntlPhoneField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Telefon raqam',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialCountryCode: 'UZ',
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    value == null || value.completeNumber.isEmpty
                        ? 'Telefon raqam kerak'
                        : null,
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObscured.value,
                    decoration: InputDecoration(
                      labelText: 'Parol',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          isObscured.value = !isObscured.value;
                        },
                      ),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Parolni kiriting' : null,
                  ),
                  const Gap(24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading.value
                          ? null
                          : () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;

                          // TODO: backend orqali login tekshirish

                          await Future.delayed(const Duration(seconds: 1));
                          isLoading.value = false;

                          // Muvaffaqiyatli login bo‘lsa, home sahifaga yo‘naltirish
                          if (context.mounted) {
                            context.go('/app'); // 👈 Endi navbarli sahifaga yo‘naltiradi
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: isLoading.value
                          ? const CircularProgressIndicator.adaptive()
                          : const Text("Kirish"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
