# MeteoRwanda Platform - Flutter Application

## Project Overview
MeteoRwanda is a hybrid digital platform designed to provide timely, localized, and actionable weather information to vulnerable populations in Rwanda. This Flutter application serves as the mobile interface for the platform, offering real-time weather forecasts, severe weather alerts, and sector-specific advisories.

## Key Features
- Real-time localized weather forecasts
- Severe weather alerts and notifications
- Offline-first architecture with SMS fallback
- Multilingual support (Kinyarwanda, French, English)
- Voice-enabled forecasts for low-literacy users
- Community weather reporting functionality
- Sector-specific modules (Agriculture, Health, Disaster Risk)

## Technical Stack
- **Frontend**: Flutter (Android/iOS compatible)
- **Backend**: FastAPI, PostgreSQL
- **AI/ML**: TensorFlow, XGBoost
- **SMS/USSD**: Telecommunication APIs
- **Authentication**: OAuth2

## Getting Started

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK (version 2.17 or higher)
- Android Studio/Xcode (for emulator/simulator)
- Google Maps API key (for location services)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/nexventures-ltd/PPI_METEO.git
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the root directory with your configuration:
   ```
   API_BASE_URL=your_api_url
   MAPS_API_KEY=your_google_maps_key
   SMS_API_KEY=your_sms_provider_key
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## MVP Screenshots
![WhatsApp Image 2025-06-23 at 5 35 54 PM](https://github.com/user-attachments/assets/1269e00f-93ec-4c05-aaed-ce54ac4f63ff)
![WhatsApp Image 2025-06-23 at 5 35 54 PM (1)](https://github.com/user-attachments/assets/2f7ad784-bc24-4e9f-a41f-ef0377ad62c9)
![WhatsApp Image 2025-06-23 at 5 35 55 PM](https://github.com/user-attachments/assets/7e5ff270-1e82-409b-b668-e91fc2ca95c0)
![WhatsApp Image 2025-06-23 at 5 35 55 PM (1)](https://github.com/user-attachments/assets/14e957af-45ff-4d23-80e7-768aee2c5b7d)
![WhatsApp Image 2025-06-23 at 5 35 56 PM](https://github.com/user-attachments/assets/0980f0ef-d18e-4198-b6ee-bb6c64bcaba9)
![WhatsApp Image 2025-06-23 at 5 35 53 PM](https://github.com/user-attachments/assets/bb08b3a4-c374-465e-a3ba-5f76970782b9)


## Configuration
The app can be configured through the following files:
- `lib/config/app_config.dart` - Main application configuration
- `lib/config/route_config.dart` - Navigation routes
- `lib/config/theme_config.dart` - UI theming

## Build Variants
To build for different environments:
```bash
# Development build
flutter build apk --flavor dev -t lib/main_dev.dart

# Production build
flutter build apk --flavor prod -t lib/main_prod.dart
```

## Testing
Run unit tests:
```bash
flutter test
```

Run widget tests:
```bash
flutter test test/widget_test.dart
```

## Contributing
We welcome contributions from the community. Please follow these steps:
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Contact
For technical inquiries:
- Lead Developer: Loue Sauveur Christian - lscblack@newventures.net
- AI/ML Engineer: Alain Muhirwa Michael - amuhirwa@newventures.net

For project coordination:
- Project Manager: Daniel Iryivuze - diryivuze@newventures.net

## Acknowledgments
- Rwanda Meteorological Agency for data partnership
- RISA Innovation Cookbook for guidance
- Local farming cooperatives for user testing
