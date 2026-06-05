# untitled2

A new Flutter project.

# files structure

lib/
core/
constants/
api_endpoints.dart
api_colors dart
api_strings dart

network/
api_servios.dart
api_exceptions.dart

utils/
helpers.dart
validators dart

features/

food/

data/
food_model.dart
food_repository.dart

view/
food_list_page.dart
food_detail_page.dart

cubit/

widgets/
food_card.dart


// الجديد
core/
├── network/
│    ├── dio_client.dart
│    ├── api_services.dart
│
├── cache/
│    └── cache_helper.dart

features/auth/
├── data/
│    └── auth_repository.dart
│
├── cubit/
│    ├── auth_cubit.dart
│    └── auth_state.dart


main.dart

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
 