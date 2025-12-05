# Union Shop

A modern, responsive e-commerce application for the University of Portsmouth Students' Union shop. Built with Flutter, this mobile-first application provides students with an intuitive shopping experience for university-branded merchandise, clothing, and personalized items.

## 🎯 Key Features

- **Responsive Design**: Optimized for mobile, tablet, and desktop with adaptive layouts
- **Product Catalog**: Browse collections including clothing, merchandise, sale items, and exclusive ranges
- **Shopping Cart**: Full cart management with quantity controls, item removal, and checkout simulation
- **Print Shack**: Personalization service for custom text on clothing and merchandise
- **User Authentication**: Sign up and login functionality with form validation
- **Sale System**: Dedicated sale page with discounted items and detail views
- **Dynamic Navigation**: Browser-friendly routing with proper URL handling and back/forward support

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher) - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (2.17.0 or higher) - Included with Flutter
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Git** - For cloning the repository

### Platform-Specific Requirements

**For Android:**
- Android Studio with SDK
- Android device or emulator

**For iOS:**
- macOS with Xcode
- iOS simulator or device

**For Web:**
- Chrome browser

## 🚀 Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Joyeehing/union_shop.git
cd union_shop
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

**For Web (Recommended for development):**
```bash
flutter run -d chrome
```

**For Mobile:**
```bash
flutter run
```

**For specific platforms:**
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Windows
flutter run -d windows
```

## 📱 Usage Instructions

### Main Features

#### Browse Products
1. Navigate to the homepage to see featured collections
2. Click on collection tiles to view products in that category
3. Use the navigation menu to access different sections (Home, Products, About, Sale, Collections)

#### Shopping Cart
1. Add items to cart from product pages
2. View cart by clicking the cart icon in the header
3. Adjust quantities using +/- buttons
4. Remove items with the remove button
5. Proceed to checkout (simulated)

#### Print Shack Personalization
1. Navigate to "Print Shack" from the menu
2. Select personalization options:
   - Enter custom text
   - Choose font style
   - Select text color
   - Set text position
3. Add personalized item to cart

#### Sale Items
1. Access sale page from navigation menu
2. View discounted products with original and sale prices
3. Click on items for detailed information
4. Add sale items directly to cart

### Running Tests

Run all tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/cart_page_test.dart
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 🏗️ Project Structure

```
lib/
├── main.dart                      # App entry point and routing
├── models/                        # Data models
│   ├── cart_item.dart            # Cart item model
│   └── sale_item.dart            # Sale product model
├── services/                      # Business logic
│   └── cart_service.dart         # Cart state management
├── widgets/                       # Reusable components
│   ├── header.dart               # Navigation header
│   └── footer.dart               # Site footer
├── about_page.dart               # About Us page
├── about_print_shack_page.dart   # Print Shack information
├── cart_page.dart                # Shopping cart
├── collections_page.dart         # Product collections
├── login_page.dart               # User login
├── signup_page.dart              # User registration
├── personalisation_page.dart     # Print Shack personalization
├── product_page.dart             # Product details
├── sale_page.dart                # Sale items listing
└── sale_detail_page.dart         # Sale item details

test/
├── cart_page_test.dart           # Cart functionality tests
├── collections_page_test.dart    # Collections tests
├── auth_pages_test.dart          # Authentication tests
├── personalisation_page_test.dart # Personalization tests
├── navigation_test.dart          # Routing tests
├── widget_test.dart              # Widget tests
└── about_print_shack_page_test.dart # Print Shack page tests
```

## 🛠️ Technologies Used

### Core Technologies
- **Flutter 3.x**: UI framework for cross-platform development
- **Dart**: Programming language

### Key Packages
- `cupertino_icons`: iOS-style icons
- `flutter_test`: Testing framework

### Development Tools
- **VS Code / Android Studio**: IDE
- **Flutter DevTools**: Debugging and profiling
- **Git**: Version control

### State Management
- **ChangeNotifier**: For cart service state management
- **ListenableBuilder**: For reactive UI updates

### Architecture Patterns
- Service-based architecture for business logic
- Model classes for data structures
- Widget composition for UI components
- Navigator 2.0 routing with onGenerateRoute

## ✅ Implemented Features

### Basic Features (100% Complete)
- ✅ Static Homepage with hero section and featured products
- ✅ Navigation bar with responsive drawer
- ✅ About Us page
- ✅ Footer component with sections
- ✅ Collections page with grid layout
- ✅ Collection detail page with product listings
- ✅ Product detail page with variants
- ✅ Sale page with discounted items
- ✅ Authentication UI (login/signup forms)

### Intermediate Features (4/7 Complete)
- ✅ Browser Navigation (reload, back/forward support)
- ✅ Product Page with variants
- ✅ Shopping Cart with CRUD operations
- ✅ Responsive design (mobile/tablet/desktop)
- ⏳ Dynamic Collections (data service layer)
- ⏳ Dynamic Collection Page (URL query params)
- ⏳ Print Shack live preview

### Advanced Features (0/3 Complete)
- ⏳ Authentication System (Firebase integration)
- ⏳ Cart Management (persistent storage, tax/shipping)
- ⏳ Search System (live suggestions, results page)

## 🐛 Known Issues and Limitations

### Current Limitations
1. **Static Data**: Products and collections use hardcoded data
2. **Mock Authentication**: Login/signup forms exist but don't persist sessions
3. **Simulated Checkout**: Cart checkout shows confirmation but doesn't process orders
4. **No Payment Integration**: Payment processing not implemented
5. **Print Shack Preview**: Personalization form exists but live preview not functional
6. **No Backend**: All data stored in memory (resets on app restart)

### Network Issues
- Image loading requires internet connection
- HTTP requests return 400 in test environment (expected behavior)

## 🔮 Future Improvements

1. **Backend Integration**
   - Connect to real product database
   - Implement user authentication with Firebase
   - Add order management system

2. **Enhanced Features**
   - Live search with autocomplete
   - Product reviews and ratings
   - Wishlist functionality
   - Order history

3. **Payment Integration**
   - Stripe or PayPal checkout
   - Multiple payment methods
   - Invoice generation

4. **Performance**
   - Image caching
   - Lazy loading for product lists
   - Offline mode support

## 🤝 Contributing

This is an academic project for the University of Portsmouth. Contributions are currently not accepted.

## 📄 License

This project is created as part of university coursework and is not licensed for commercial use.

## 📞 Contact Information

**Developer**: Joyee Hing  
**Institution**: University of Portsmouth  
**GitHub**: [@Joyeehing](https://github.com/Joyeehing)

---

**Note**: This application is a student project demonstrating Flutter development skills. It is not affiliated with the University of Portsmouth Students' Union official shop.
