# 🚀 Portfolio App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-222222?style=for-the-badge&logo=GitHub%20Pages&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)

**Professional portfolio app for Abdelrahman Emad - Flutter Developer**

[![Live Demo](https://img.shields.io/badge/🌐_Live_Demo-000000?style=for-the-badge&logo=githubpages&logoColor=white)](https://abdoemad11.github.io/portfolio/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/AbdoEmad11/portfolio)

</div>

---

## ✨ Features

- 🎨 **Modern UI/UX** - Clean, responsive design with smooth animations
- 🖌️ **Blue & Black Theme** - Unified deep-blue accents on near-black surfaces
- 🚀 **2s Splash Screen** - Minimal logo splash with subtle fade/scale
- 📱 **Cross-Platform** - Works on Web, Android, iOS, Windows, macOS, and Linux
- 🎭 **Interactive Animations** - Lottie animations and custom transitions
- 🌐 **Web Deployed** - Automatically deployed to GitHub Pages
- 📊 **Project Showcase** - Display your work with beautiful project cards
- 🎯 **Contact Integration** - Direct links to social media and contact info
- 🎨 **Custom Theming** - Dark/Light mode support
- ⚡ **Fast Performance** - Optimized for speed and smooth interactions

## 🛠️ Tech Stack

### Core Technologies
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Material Design 3** - Modern design system

### State Management & Navigation
- **Flutter Bloc** - Predictable state management
- **Go Router** - Declarative routing

### UI & Animations
- **Google Fonts** - Typography
- **Font Awesome** - Icon library
- **Lottie** - Vector animations
- **Animations** - Custom transitions

### Utilities
- **Shared Preferences** - Local storage
- **URL Launcher** - External links

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AbdoEmad11/portfolio.git
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile
   flutter run
   
   # For desktop
   flutter run -d windows  # or macos, linux
   ```

## 📱 Screenshots

<div align="center">
  <img src="assets/images/screenshot1.png" alt="Home Screen" width="300"/>
  <img src="assets/images/screenshot2.png" alt="Projects Screen" width="300"/>
  <img src="assets/images/screenshot3.png" alt="About Screen" width="300"/>
</div>

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── utils/          # Utility functions
│   └── widgets/        # Reusable widgets
├── data/
│   └── models/         # Data models
├── presentation/
│   ├── cubite/         # State management
│   ├── pages/          # App screens
│   └── widgets/        # UI components
└── main.dart          # App entry point
```

## 🎨 Customization

### Adding Your Information
1. Update `lib/data/models/` with your personal data
2. Replace images in `assets/images/`
3. Modify colors in your theme configuration
4. Update project information in the models

### Theming
- Customize colors in `lib/core/theme/`
- Add your own fonts in `pubspec.yaml`
- Modify animations in `assets/animations/`

## 🚀 Deployment

This project is automatically deployed to GitHub Pages using GitHub Actions.

### Deployment via GitHub Actions (recommended)
1. Push to `main`. A workflow builds web with `--base-href /portfolio/` and deploys to Pages.
2. Repo Settings → Pages → Source: GitHub Actions.
3. Live at: https://abdoemad11.github.io/portfolio/

### Manual Deployment
```bash
# Build for web
flutter build web --release --base-href /portfolio/

# Deploy to GitHub Pages
# (Automatically handled by GitHub Actions)
```

### Troubleshooting (stale page after deploy)
- Hard refresh (Ctrl+Shift+R / Cmd+Shift+R) to bypass the service worker cache.
- Or open `https://abdoemad11.github.io/portfolio/version.json?cacheBust=123` then reload.

## 📊 Performance

- ⚡ **Fast Loading** - Optimized bundle size
- 🎯 **Smooth Animations** - 60fps animations
- 📱 **Responsive** - Works on all screen sizes
- 🌐 **SEO Optimized** - Meta tags and structured data

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Abdelrahman Emad**
- GitHub: [@AbdoEmad11](https://github.com/AbdoEmad11)
- Portfolio: [Live Demo](https://abdoemad11.github.io/portfolio/)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- All open source contributors

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

Made with ❤️ and Flutter

</div>