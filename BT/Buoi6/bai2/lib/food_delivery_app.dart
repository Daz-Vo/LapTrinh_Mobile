import 'dart:math' as math;

import 'package:flutter/material.dart';

const _ink = Color(0xFF20201F);
const _muted = Color(0xFF85837F);
const _paper = Color(0xFFF8F7F4);
const _coral = Color(0xFFF15B49);
const _line = Color(0xFFECEAE6);

const _categories = <FoodCategory>[
  FoodCategory(name: 'All', icon: '🍽️'),
  FoodCategory(name: 'Pizza', icon: '🍕'),
  FoodCategory(name: 'Burgers', icon: '🍔'),
  FoodCategory(name: 'Asian', icon: '🍜'),
  FoodCategory(name: 'Healthy', icon: '🥗'),
  FoodCategory(name: 'Dessert', icon: '🍰'),
];

const sampleRestaurants = <Restaurant>[
  Restaurant(
    id: 'casa-napoli',
    name: 'Casa Napoli',
    cuisine: 'Italian · Pizza · Pasta',
    category: 'Pizza',
    rating: 4.8,
    reviews: '1.2k',
    deliveryTime: '20–30 min',
    deliveryFee: 0,
    offer: '20% OFF',
    imageUrl: 'assets/images/casa_napoli.jpg',
    heroUrl: 'assets/images/truffle_pizza.jpg',
    items: [
      MenuItem(
        id: 'truffle-burrata',
        name: 'Truffle Burrata',
        description: 'San Marzano tomato, creamy burrata, basil and truffle oil.',
        price: 18.90,
        category: 'Pizza',
        badge: 'BESTSELLER',
        imageUrl: 'assets/images/truffle_pizza.jpg',
      ),
      MenuItem(
        id: 'margherita',
        name: 'Classic Margherita',
        description: 'San Marzano tomato, mozzarella, fresh basil.',
        price: 15.50,
        category: 'Pizza',
        imageUrl: 'assets/images/margherita.jpg',
      ),
      MenuItem(
        id: 'rigatoni',
        name: 'Rigatoni Vodka',
        description: 'Silky tomato cream, parmesan and a touch of chili.',
        price: 17.25,
        category: 'Pasta',
        imageUrl: 'assets/images/pasta.jpg',
      ),
      MenuItem(
        id: 'tiramisu',
        name: 'House Tiramisu',
        description: 'Espresso-soaked layers with mascarpone cream.',
        price: 8.50,
        category: 'Desserts',
        imageUrl: 'assets/images/tiramisu.jpg',
      ),
    ],
  ),
  Restaurant(
    id: 'green-grain',
    name: 'Green & Grain',
    cuisine: 'Healthy · Bowls · Salads',
    category: 'Healthy',
    rating: 4.7,
    reviews: '840',
    deliveryTime: '15–25 min',
    deliveryFee: 1.49,
    offer: 'FREE DRINK',
    imageUrl: 'assets/images/harvest_bowl.jpg',
    heroUrl: 'assets/images/harvest_bowl.jpg',
    items: [
      MenuItem(
        id: 'harvest-bowl',
        name: 'Harvest Glow Bowl',
        description: 'Avocado, quinoa, roasted chickpeas and lemon tahini.',
        price: 16.50,
        category: 'Popular',
        badge: 'FAN FAVORITE',
        imageUrl: 'assets/images/green_salad.jpg',
      ),
      MenuItem(
        id: 'green-goddess',
        name: 'Green Goddess Salad',
        description: 'Crisp greens, cucumber, herbs and green goddess dressing.',
        price: 14.25,
        category: 'Healthy',
        imageUrl: 'assets/images/green_salad.jpg',
      ),
    ],
  ),
  Restaurant(
    id: 'good-burger',
    name: 'Good Burger Co.',
    cuisine: 'Burgers · American',
    category: 'Burgers',
    rating: 4.6,
    reviews: '960',
    deliveryTime: '25–35 min',
    deliveryFee: 0,
    imageUrl: 'assets/images/good_burger.jpg',
    heroUrl: 'assets/images/good_burger.jpg',
    items: [
      MenuItem(
        id: 'smash-burger',
        name: 'Double Smash Burger',
        description: 'Two crispy-edged patties, American cheese and house sauce.',
        price: 17.50,
        category: 'Popular',
        badge: 'BESTSELLER',
        imageUrl: 'assets/images/good_burger.jpg',
      ),
    ],
  ),
  Restaurant(
    id: 'little-tokyo',
    name: 'Little Tokyo',
    cuisine: 'Japanese · Sushi · Ramen',
    category: 'Asian',
    rating: 4.9,
    reviews: '2.1k',
    deliveryTime: '20–35 min',
    deliveryFee: 2.49,
    imageUrl: 'assets/images/sushi.jpg',
    heroUrl: 'assets/images/sushi.jpg',
    items: [
      MenuItem(
        id: 'salmon-roll',
        name: 'Salmon Aburi Roll',
        description: 'Torched salmon, avocado, scallion and ponzu.',
        price: 18.75,
        category: 'Popular',
        imageUrl: 'assets/images/sushi.jpg',
      ),
    ],
  ),
];

class FoodCategory {
  const FoodCategory({required this.name, required this.icon});

  final String name;
  final String icon;
}

class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.imageUrl,
    required this.heroUrl,
    required this.items,
    this.offer,
  });

  final String id;
  final String name;
  final String cuisine;
  final String category;
  final double rating;
  final String reviews;
  final String deliveryTime;
  final double deliveryFee;
  final String imageUrl;
  final String heroUrl;
  final String? offer;
  final List<MenuItem> items;
}

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.badge,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final String? badge;
}

class CartLine {
  CartLine({required this.restaurant, required this.item, this.quantity = 1});

  final Restaurant restaurant;
  final MenuItem item;
  int quantity;
}

class FoodDeliveryApp extends StatefulWidget {
  const FoodDeliveryApp({super.key});

  @override
  State<FoodDeliveryApp> createState() => _FoodDeliveryAppState();
}

class _FoodDeliveryAppState extends State<FoodDeliveryApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _tab = 0;
  String _category = 'All';
  String _query = '';
  String _address = '214 Bedford Avenue';
  final Set<String> _favorites = {};
  final Set<String> _filters = {};
  final List<CartLine> _cart = [];
  bool _hasOrder = false;

  List<Restaurant> get _visibleRestaurants {
    final query = _query.trim().toLowerCase();
    return sampleRestaurants.where((restaurant) {
      final matchesCategory = _category == 'All' ||
          restaurant.category == _category ||
          restaurant.cuisine.toLowerCase().contains(_category.toLowerCase());
      final matchesQuery = query.isEmpty ||
          restaurant.name.toLowerCase().contains(query) ||
          restaurant.cuisine.toLowerCase().contains(query) ||
          restaurant.items.any((item) => item.name.toLowerCase().contains(query));
      final matchesFavorites = _tab != 3 || _favorites.contains(restaurant.id);
      final matchesRating = !_filters.contains('4.7+') || restaurant.rating >= 4.7;
      final matchesDelivery =
          !_filters.contains('Free delivery') || restaurant.deliveryFee == 0;
      final matchesTime =
          !_filters.contains('Under 30 min') || !restaurant.deliveryTime.startsWith('30');
      return matchesCategory &&
          matchesQuery &&
          matchesFavorites &&
          matchesRating &&
          matchesDelivery &&
          matchesTime;
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Foood Develivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _coral,
          surface: _paper,
          onSurface: _ink,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _ink),
          bodyLarge: TextStyle(color: _ink),
        ),
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          final appWidth = math.min(constraints.maxWidth, 480.0);
          return Scaffold(
            backgroundColor: const Color(0xFFECEAE6),
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: appWidth,
                  height: constraints.maxHeight,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: _paper),
                    child: Column(
                      children: [
                        Expanded(child: _buildSelectedPage()),
                        _BottomNavigation(
                          selectedIndex: _tab,
                          cartCount: _cart.fold<int>(
                            0,
                            (total, line) => total + line.quantity,
                          ),
                          onSelected: (index) => setState(() => _tab = index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedPage() {
    return switch (_tab) {
      0 => _HomePage(
          address: _address,
          category: _category,
          restaurants: _visibleRestaurants,
          favorites: _favorites,
          query: _query,
          onAddressTap: _chooseAddress,
          onCategorySelected: (category) => setState(() => _category = category),
          onQueryChanged: (query) => setState(() => _query = query),
          onFilterTap: _showFilters,
          onNotificationsTap: _showNotifications,
          onSeeAll: () => setState(() => _tab = 1),
          onFavoriteTap: _toggleFavorite,
          onRestaurantTap: _openRestaurant,
        ),
      1 => _SearchPage(
          query: _query,
          restaurants: _visibleRestaurants,
          favorites: _favorites,
          onQueryChanged: (query) => setState(() => _query = query),
          onFilterTap: _showFilters,
          onFavoriteTap: _toggleFavorite,
          onRestaurantTap: _openRestaurant,
        ),
      2 => _OrdersPage(hasOrder: _hasOrder, onExplore: () => setState(() => _tab = 0)),
      3 => _FavoritesPage(
          restaurants: _visibleRestaurants,
          favorites: _favorites,
          onFavoriteTap: _toggleFavorite,
          onRestaurantTap: _openRestaurant,
        ),
      _ => _AccountPage(address: _address, onAddressTap: _chooseAddress),
    };
  }

  void _toggleFavorite(Restaurant restaurant) {
    setState(() {
      if (!_favorites.add(restaurant.id)) _favorites.remove(restaurant.id);
    });
  }

  void _openRestaurant(Restaurant restaurant) {
    _navigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => _PhonePage(
          child: _RestaurantPage(
            restaurant: restaurant,
            isFavorite: _favorites.contains(restaurant.id),
            onFavoriteTap: () => _toggleFavorite(restaurant),
            onAddToCart: _addToCart,
          ),
        ),
      ),
    );
  }

  void _addToCart(Restaurant restaurant, MenuItem item, int quantity) {
    setState(() {
      final index = _cart.indexWhere((line) => line.item.id == item.id);
      if (index == -1) {
        _cart.add(CartLine(restaurant: restaurant, item: item, quantity: quantity));
      } else {
        _cart[index].quantity += quantity;
      }
    });
    _navigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => _PhonePage(
          child: _CartPage(
            lines: _cart,
            onQuantityChanged: _changeQuantity,
            onCheckout: _openCheckout,
          ),
        ),
      ),
    );
  }

  void _changeQuantity(String itemId, int delta) {
    setState(() {
      final index = _cart.indexWhere((line) => line.item.id == itemId);
      if (index == -1) return;
      _cart[index].quantity += delta;
      if (_cart[index].quantity <= 0) _cart.removeAt(index);
    });
  }

  void _openCheckout() {
    _navigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => _PhonePage(
          child: _CheckoutPage(
            total: _cartTotal,
            address: _address,
            onPlaceOrder: _placeOrder,
          ),
        ),
      ),
    );
  }

  double get _cartTotal {
    final subtotal = _cart.fold<double>(
      0,
      (total, line) => total + line.item.price * line.quantity,
    );
    final delivery = _cart.isEmpty ? 0 : _cart.first.restaurant.deliveryFee;
    return subtotal + delivery + subtotal * 0.112;
  }

  void _placeOrder() {
    _navigatorKey.currentState!.popUntil((route) => route.isFirst);
    setState(() {
      _cart.clear();
      _hasOrder = true;
      _tab = 2;
    });
  }

  Future<void> _chooseAddress() async {
    const addresses = [
      '214 Bedford Avenue',
      '80 Wythe Avenue',
      '25 Kent Avenue',
    ];
    final selected = await showModalBottomSheet<String>(
      context: _navigatorKey.currentContext!,
      backgroundColor: _paper,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Delivery address', style: _sectionTitle),
              const SizedBox(height: 12),
              for (final address in addresses)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.location_on_outlined, color: _coral),
                  title: Text(address),
                  trailing: address == _address
                      ? const Icon(Icons.check, color: _coral)
                      : null,
                  onTap: () => Navigator.pop(context, address),
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) setState(() => _address = selected);
  }

  Future<void> _showNotifications() {
    return showModalBottomSheet<void>(
      context: _navigatorKey.currentContext!,
      backgroundColor: _paper,
      showDragHandle: true,
      builder: (context) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notifications', style: _sectionTitle),
              SizedBox(height: 18),
              _NotificationRow(
                icon: Icons.local_offer_outlined,
                title: 'A tasty deal is waiting',
                subtitle: 'Save up to 30% on healthy picks today.',
              ),
              SizedBox(height: 14),
              _NotificationRow(
                icon: Icons.delivery_dining_outlined,
                title: 'Free delivery nearby',
                subtitle: 'Casa Napoli is delivering for free.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showFilters() async {
    final result = await showModalBottomSheet<Set<String>>(
      context: _navigatorKey.currentContext!,
      backgroundColor: _paper,
      showDragHandle: true,
      builder: (context) => _FilterSheet(initialFilters: _filters),
    );
    if (result != null) {
      setState(() {
        _filters
          ..clear()
          ..addAll(result);
      });
    }
  }
}

class _PhonePage extends StatelessWidget {
  const _PhonePage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(constraints.maxWidth, 480.0);
        final height = constraints.maxHeight - MediaQuery.paddingOf(context).vertical;
        return Scaffold(
          backgroundColor: const Color(0xFFECEAE6),
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: width,
                height: height,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: _paper),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({
    required this.address,
    required this.category,
    required this.restaurants,
    required this.favorites,
    required this.query,
    required this.onAddressTap,
    required this.onCategorySelected,
    required this.onQueryChanged,
    required this.onFilterTap,
    required this.onNotificationsTap,
    required this.onSeeAll,
    required this.onFavoriteTap,
    required this.onRestaurantTap,
  });

  final String address;
  final String category;
  final List<Restaurant> restaurants;
  final Set<String> favorites;
  final String query;
  final VoidCallback onAddressTap;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onFilterTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onSeeAll;
  final ValueChanged<Restaurant> onFavoriteTap;
  final ValueChanged<Restaurant> onRestaurantTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _DeliveryHeader(
              address: address,
              onAddressTap: onAddressTap,
              onNotificationsTap: onNotificationsTap,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What are you craving?', style: _heroTitle),
                const SizedBox(height: 4),
                const Text(
                  'Discover something delicious nearby.',
                  style: TextStyle(color: _muted, fontSize: 14),
                ),
                const SizedBox(height: 18),
                _SearchField(
                  initialValue: query,
                  onChanged: onQueryChanged,
                  onFilterTap: onFilterTap,
                ),
                const SizedBox(height: 18),
                const _DealBanner(),
                const SizedBox(height: 24),
                _SectionHeader(title: 'Explore categories', onSeeAll: onSeeAll),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = _categories[index];
                      return _CategoryTile(
                        category: item,
                        selected: category == item.name,
                        onTap: () => onCategorySelected(item.name),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                _SectionHeader(title: 'Popular near you', onSeeAll: onSeeAll),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        if (restaurants.isEmpty)
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
            sliver: SliverToBoxAdapter(child: _NoResults()),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 252,
                child: ListView.separated(
                  key: const ValueKey('popular-restaurants'),
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurants.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => SizedBox(
                    width: 254,
                    child: _RestaurantCard(
                      restaurant: restaurants[index],
                      isFavorite: favorites.contains(restaurants[index].id),
                      onFavoriteTap: () => onFavoriteTap(restaurants[index]),
                      onTap: () => onRestaurantTap(restaurants[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                _SectionHeader(title: 'More to explore', onSeeAll: onSeeAll),
                const SizedBox(height: 10),
                for (final restaurant in restaurants.skip(1).take(2)) ...[
                  _RestaurantListTile(
                    restaurant: restaurant,
                    onTap: () => onRestaurantTap(restaurant),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DeliveryHeader extends StatelessWidget {
  const _DeliveryHeader({
    required this.address,
    required this.onAddressTap,
    required this.onNotificationsTap,
  });

  final String address;
  final VoidCallback onAddressTap;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DELIVER TO',
                style: TextStyle(
                  color: _muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onAddressTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18, color: _coral),
                    const SizedBox(width: 6),
                    Text(
                      address,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        _RoundIconButton(
          icon: Icons.notifications_none_rounded,
          label: 'Notifications',
          onTap: onNotificationsTap,
          hasDot: true,
        ),
      ],
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.initialValue,
    required this.onChanged,
    required this.onFilterTap,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.initialValue,
        selection: TextSelection.collapsed(offset: widget.initialValue.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.only(left: 16, right: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _line),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 21),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _controller,
              onChanged: widget.onChanged,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Search dishes or restaurants',
                hintStyle: TextStyle(color: _muted, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: _ink,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: widget.onFilterTap,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.tune_rounded, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DealBanner extends StatelessWidget {
  const _DealBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 144,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _FoodImage(url: 'assets/images/harvest_bowl.jpg'),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xF222211F), Color(0xDD22211F), Color(0x10181818)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  'TASTY DEAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 18,
              right: 100,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fresh flavor, less spend',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.08,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Up to 30% off healthy picks',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSeeAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Expanded(child: Text(title, style: _sectionTitle)),
              TextButton(
                onPressed: onSeeAll,
                style: TextButton.styleFrom(
                  foregroundColor: _coral,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('See all', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _sectionTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _ink);
const _heroTitle = TextStyle(fontSize: 27, height: 1.12, fontWeight: FontWeight.w800, color: _ink);

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final FoodCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Material(
        color: selected ? _coral : Colors.white,
        borderRadius: BorderRadius.circular(17),
        child: InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: selected ? Colors.white.withValues(alpha: 0.17) : _paper,
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: Text(category.icon, style: const TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 5),
              Text(
                category.name,
                maxLines: 1,
                style: TextStyle(
                  color: selected ? Colors.white : _ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  const _RestaurantCard({
    required this.restaurant,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
  });

  final Restaurant restaurant;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 132,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _FoodImage(url: restaurant.imageUrl),
                  if (restaurant.offer != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: _OfferTag(label: restaurant.offer!),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _CircleAction(
                      icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? _coral : _ink,
                      label: isFavorite ? 'Remove favorite' : 'Add favorite',
                      onTap: onFavoriteTap,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 9, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    restaurant.cuisine,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _muted, fontSize: 10.5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFE8A93C), size: 15),
                      const SizedBox(width: 3),
                      Text('${restaurant.rating}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          restaurant.deliveryTime,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: _muted, fontSize: 10.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant.deliveryFee == 0
                        ? r'$0 delivery'
                        : '\$${restaurant.deliveryFee.toStringAsFixed(2)} delivery',
                    style: const TextStyle(color: _muted, fontSize: 10.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RestaurantListTile extends StatelessWidget {
  const _RestaurantListTile({required this.restaurant, required this.onTap});

  final Restaurant restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: SizedBox(width: 62, height: 62, child: _FoodImage(url: restaurant.imageUrl)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(restaurant.cuisine, style: const TextStyle(color: _muted, fontSize: 12)),
                    const SizedBox(height: 6),
                    Text(
                      '★ ${restaurant.rating}  ·  ${restaurant.deliveryTime}  ·  ${restaurant.deliveryFee == 0 ? 'Free delivery' : '\$${restaurant.deliveryFee.toStringAsFixed(2)} delivery'}',
                      style: const TextStyle(color: _muted, fontSize: 10.5),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: _muted),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage({
    required this.query,
    required this.restaurants,
    required this.favorites,
    required this.onQueryChanged,
    required this.onFilterTap,
    required this.onFavoriteTap,
    required this.onRestaurantTap,
  });

  final String query;
  final List<Restaurant> restaurants;
  final Set<String> favorites;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onFilterTap;
  final ValueChanged<Restaurant> onFavoriteTap;
  final ValueChanged<Restaurant> onRestaurantTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Find your next favorite', style: _heroTitle),
                const SizedBox(height: 6),
                const Text('Search local dishes and restaurants.', style: TextStyle(color: _muted)),
                const SizedBox(height: 18),
                _SearchField(initialValue: query, onChanged: onQueryChanged, onFilterTap: onFilterTap),
                const SizedBox(height: 20),
                const Text('Popular searches', style: _sectionTitle),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Pizza', 'Salad bowls', 'Burgers', 'Pasta'].map((suggestion) {
                    return ActionChip(
                      label: Text(suggestion),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: _line),
                      onPressed: () => onQueryChanged(suggestion),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(query.isEmpty ? 'Popular near you' : 'Search results', style: _sectionTitle),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        if (restaurants.isEmpty)
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(child: _NoResults()),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.separated(
              itemCount: restaurants.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return _RestaurantCard(
                  restaurant: restaurant,
                  isFavorite: favorites.contains(restaurant.id),
                  onFavoriteTap: () => onFavoriteTap(restaurant),
                  onTap: () => onRestaurantTap(restaurant),
                );
              },
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _FavoritesPage extends StatelessWidget {
  const _FavoritesPage({
    required this.restaurants,
    required this.favorites,
    required this.onFavoriteTap,
    required this.onRestaurantTap,
  });

  final List<Restaurant> restaurants;
  final Set<String> favorites;
  final ValueChanged<Restaurant> onFavoriteTap;
  final ValueChanged<Restaurant> onRestaurantTap;

  @override
  Widget build(BuildContext context) {
    final saved = restaurants.where((restaurant) => favorites.contains(restaurant.id)).toList();
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your favorites', style: _heroTitle),
                SizedBox(height: 5),
                Text('The places you love, all in one spot.', style: TextStyle(color: _muted)),
              ],
            ),
          ),
        ),
        if (saved.isEmpty)
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            sliver: SliverToBoxAdapter(
              child: _EmptyState(
                icon: Icons.favorite_border_rounded,
                title: 'No favorites yet',
                message: 'Tap the heart on a restaurant to save it here.',
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.separated(
              itemCount: saved.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _RestaurantCard(
                restaurant: saved[index],
                isFavorite: true,
                onFavoriteTap: () => onFavoriteTap(saved[index]),
                onTap: () => onRestaurantTap(saved[index]),
              ),
            ),
          ),
      ],
    );
  }
}

class _OrdersPage extends StatelessWidget {
  const _OrdersPage({required this.hasOrder, required this.onExplore});

  final bool hasOrder;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      children: [
        const Text('Your orders', style: _heroTitle),
        const SizedBox(height: 5),
        const Text('Good food has a way of bringing us back.', style: TextStyle(color: _muted)),
        const SizedBox(height: 28),
        if (hasOrder)
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.check_circle, color: Color(0xFF3E9171)), SizedBox(width: 9), Text('Order confirmed', style: TextStyle(fontWeight: FontWeight.w800))]),
                SizedBox(height: 9),
                Text('Your order has been placed. Your delicious picks are on their way.', style: TextStyle(color: _muted)),
              ],
            ),
          )
        else
          _EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'No orders yet',
            message: 'Your next great meal is just a few taps away.',
            actionLabel: 'Explore restaurants',
            onAction: onExplore,
          ),
      ],
    );
  }
}

class _AccountPage extends StatelessWidget {
  const _AccountPage({required this.address, required this.onAddressTap});

  final String address;
  final VoidCallback onAddressTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const Text('Your account', style: _heroTitle),
        const SizedBox(height: 5),
        const Text('A few details make every order easier.', style: TextStyle(color: _muted)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: const Row(
            children: [
              CircleAvatar(radius: 27, backgroundColor: Color(0xFFFFE5DF), child: Icon(Icons.person_outline, color: _coral)),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Welcome to Foood', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)), SizedBox(height: 3), Text('Guest account', style: TextStyle(color: _muted, fontSize: 13))]),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _AccountRow(icon: Icons.location_on_outlined, title: 'Delivery address', subtitle: address, onTap: onAddressTap),
        const SizedBox(height: 8),
        const _AccountRow(icon: Icons.payment_outlined, title: 'Payment methods', subtitle: 'Add a card at checkout'),
        const SizedBox(height: 8),
        const _AccountRow(icon: Icons.help_outline_rounded, title: 'Help & support', subtitle: 'We are here to help'),
      ],
    );
  }
}

class _RestaurantPage extends StatefulWidget {
  const _RestaurantPage({
    required this.restaurant,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onAddToCart,
  });

  final Restaurant restaurant;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final void Function(Restaurant, MenuItem, int) onAddToCart;

  @override
  State<_RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<_RestaurantPage> {
  String _menuCategory = 'Popular';
  final Map<String, int> _quantities = {};

  List<MenuItem> get _items {
    if (_menuCategory == 'Popular') return widget.restaurant.items;
    return widget.restaurant.items
        .where((item) => item.category == _menuCategory)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;
    const categories = ['Popular', 'Pizza', 'Pasta', 'Desserts', 'Drinks'];

    return Scaffold(
      backgroundColor: _paper,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(tag: 'restaurant-${restaurant.id}', child: _FoodImage(url: restaurant.heroUrl)),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent, Colors.black12],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.45, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.paddingOf(context).top + 8,
                    left: 18,
                    right: 18,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _RoundIconButton(icon: Icons.arrow_back_rounded, label: 'Go back', onTap: () => Navigator.pop(context)),
                        Row(
                          children: [
                            _RoundIconButton(icon: Icons.ios_share_rounded, label: 'Share restaurant', onTap: () => _showShareMessage(context)),
                            const SizedBox(width: 9),
                            _RoundIconButton(
                              icon: widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                              label: 'Favorite restaurant',
                              color: widget.isFavorite ? _coral : _ink,
                              onTap: () {
                                widget.onFavoriteTap();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFE7F4EC), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Open until 10:30 PM', style: TextStyle(color: Color(0xFF3E8465), fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded, color: Color(0xFFE8A93C), size: 17),
                      const SizedBox(width: 3),
                      Text('${restaurant.rating}', style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text(' (${restaurant.reviews})', style: const TextStyle(color: _muted, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(restaurant.name, style: const TextStyle(fontSize: 28, height: 1.1, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('Authentic ${restaurant.cuisine}', style: const TextStyle(color: _muted, fontSize: 14)),
                  const SizedBox(height: 15),
                  _RestaurantStats(restaurant: restaurant),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _MenuTabHeader(
              categories: categories,
              selected: _menuCategory,
              onSelected: (category) => setState(() => _menuCategory = category),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            sliver: SliverList.list(
              children: [
                Text(_menuCategory == 'Popular' ? 'Most loved' : _menuCategory, style: _sectionTitle),
                const SizedBox(height: 12),
                if (_items.isEmpty)
                  const _EmptyState(
                    icon: Icons.restaurant_menu_rounded,
                    title: 'More dishes coming soon',
                    message: 'Try another menu category.',
                  )
                else
                  for (final item in _items) ...[
                    _MenuItemCard(
                      item: item,
                      quantity: _quantities[item.id] ?? 1,
                      onDecrease: () => setState(() {
                        final current = _quantities[item.id] ?? 1;
                        _quantities[item.id] = math.max(1, current - 1);
                      }),
                      onIncrease: () => setState(() => _quantities[item.id] = (_quantities[item.id] ?? 1) + 1),
                      onAdd: () => widget.onAddToCart(restaurant, item, _quantities[item.id] ?? 1),
                    ),
                    const SizedBox(height: 14),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RestaurantStats extends StatelessWidget {
  const _RestaurantStats({required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final delivery = restaurant.deliveryFee == 0 ? 'Free' : '\$${restaurant.deliveryFee.toStringAsFixed(2)}';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          _StatItem(value: restaurant.deliveryTime.replaceAll('–', '–'), label: 'Delivery'),
          const _ThinDivider(),
          const _StatItem(value: '1.4 mi', label: 'Distance'),
          const _ThinDivider(),
          _StatItem(value: delivery, label: 'Delivery fee', valueColor: const Color(0xFF3D8B69)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label, this.valueColor = _ink});

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.w800, color: valueColor, fontSize: 14)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: _muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) => const SizedBox(height: 35, child: VerticalDivider(width: 1, color: _line));
}

class _MenuTabHeader extends SliverPersistentHeaderDelegate {
  const _MenuTabHeader({required this.categories, required this.selected, required this.onSelected});

  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  double get minExtent => 54;

  @override
  double get maxExtent => 54;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: _paper,
        border: Border(bottom: BorderSide(color: _line)),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 22),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selected;
          return InkWell(
            onTap: () => onSelected(category),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: Text(category, style: TextStyle(color: isSelected ? _coral : _muted, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500)),
                ),
                Container(height: 2, width: 54, color: isSelected ? _coral : Colors.transparent),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _MenuTabHeader oldDelegate) =>
      oldDelegate.selected != selected || oldDelegate.categories != categories;
}

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({
    required this.item,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.onAdd,
  });

  final MenuItem item;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 190, width: double.infinity, child: _FoodImage(url: item.imageUrl)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(item.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
                    if (item.badge != null) _OfferTag(label: item.badge!),
                  ],
                ),
                const SizedBox(height: 5),
                Text(item.description, style: const TextStyle(color: _muted, fontSize: 12, height: 1.4)),
                const SizedBox(height: 9),
                Text(_money(item.price), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 13),
                Row(
                  children: [
                    _QuantityControl(quantity: quantity, onDecrease: onDecrease, onIncrease: onIncrease),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton(
                        onPressed: onAdd,
                        style: FilledButton.styleFrom(
                          backgroundColor: _coral,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 46),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text('Add · ${_money(item.price * quantity)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartPage extends StatefulWidget {
  const _CartPage({required this.lines, required this.onQuantityChanged, required this.onCheckout});

  final List<CartLine> lines;
  final void Function(String, int) onQuantityChanged;
  final VoidCallback onCheckout;

  @override
  State<_CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<_CartPage> {
  bool _promoApplied = false;

  double get _subtotal => widget.lines.fold<double>(
        0,
        (total, line) => total + line.item.price * line.quantity,
      );

  double get _delivery => widget.lines.isEmpty ? 0 : widget.lines.first.restaurant.deliveryFee;
  double get _tax => _subtotal * 0.112;
  double get _total => _subtotal + _delivery + _tax - (_promoApplied ? 3 : 0);

  Future<void> _enterPromo() async {
    final controller = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a promo code'),
        content: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(hintText: 'Try TASTY3'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text.trim().isNotEmpty), child: const Text('Apply')),
        ],
      ),
    );
    controller.dispose();
    if (accepted == true) setState(() => _promoApplied = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(tooltip: 'Go back', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your cart', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            if (widget.lines.isNotEmpty)
              Text(widget.lines.first.restaurant.name, style: const TextStyle(color: _muted, fontSize: 12)),
          ],
        ),
        backgroundColor: _paper,
      ),
      bottomNavigationBar: widget.lines.isEmpty
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: FilledButton(
                  onPressed: widget.onCheckout,
                  style: FilledButton.styleFrom(
                    backgroundColor: _coral,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: Text('Go to checkout', style: TextStyle(fontWeight: FontWeight.w700))),
                      Text(_money(_total), style: const TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
            ),
      body: widget.lines.isEmpty
          ? const _EmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'Your cart is empty',
              message: 'Add a delicious dish to get started.',
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                  decoration: BoxDecoration(color: const Color(0xFFE8F5ED), borderRadius: BorderRadius.circular(14)),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Color(0xFF3E8B67), size: 19),
                      SizedBox(width: 8),
                      Text('You unlocked free delivery', style: TextStyle(color: Color(0xFF3E8B67), fontWeight: FontWeight.w700, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (final line in widget.lines) ...[
                  _CartItemCard(
                    line: line,
                    onEdit: () => _showOptions(context),
                    onDecrease: () {
                      widget.onQuantityChanged(line.item.id, -1);
                      setState(() {});
                    },
                    onIncrease: () {
                      widget.onQuantityChanged(line.item.id, 1);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                _OrderSummary(
                  subtotal: _subtotal,
                  delivery: _delivery,
                  tax: _tax,
                  total: _total,
                  discount: _promoApplied ? 3 : 0,
                ),
                const SizedBox(height: 13),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: _enterPromo,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3EF),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFF0A294), style: BorderStyle.solid),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_promoApplied ? 'TASTY3 applied' : 'Add a promo code', style: const TextStyle(color: _coral, fontWeight: FontWeight.w800, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text(_promoApplied ? 'You saved ${_money(3)}' : 'Save on this order', style: const TextStyle(color: _muted, fontSize: 11)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _showOptions(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(22, 4, 22, 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit options', style: _sectionTitle),
              SizedBox(height: 14),
              Text('Crust', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Text('Regular · Thin crust', style: TextStyle(color: _muted)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.line, required this.onEdit, required this.onDecrease, required this.onIncrease});

  final CartLine line;
  final VoidCallback onEdit;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(width: 76, height: 76, child: _FoodImage(url: line.item.imageUrl)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(line.item.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    const Text('Regular · Thin crust', style: TextStyle(color: _muted, fontSize: 11)),
                    const SizedBox(height: 5),
                    Text(_money(line.item.price * line.quantity), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1, color: _line)),
          Row(
            children: [
              TextButton(onPressed: onEdit, style: TextButton.styleFrom(foregroundColor: _muted, padding: EdgeInsets.zero), child: const Text('Edit options')),
              const Spacer(),
              _QuantityControl(quantity: line.quantity, onDecrease: onDecrease, onIncrease: onIncrease),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.subtotal, required this.delivery, required this.tax, required this.total, required this.discount});

  final double subtotal;
  final double delivery;
  final double tax;
  final double total;
  final double discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Order summary', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15))),
          const SizedBox(height: 15),
          _SummaryRow(label: 'Subtotal', value: _money(subtotal)),
          const SizedBox(height: 10),
          _SummaryRow(label: 'Delivery fee', value: delivery == 0 ? 'Free' : _money(delivery), valueColor: const Color(0xFF3E8B67)),
          const SizedBox(height: 10),
          _SummaryRow(label: 'Taxes & service', value: _money(tax)),
          if (discount > 0) ...[
            const SizedBox(height: 10),
            _SummaryRow(label: 'Promo discount', value: '-${_money(discount)}', valueColor: _coral),
          ],
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1, color: _line)),
          _SummaryRow(label: 'Total', value: _money(total), emphasize: true),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.valueColor = _ink, this.emphasize = false});

  final String label;
  final String value;
  final Color valueColor;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: TextStyle(color: emphasize ? _ink : _muted, fontWeight: emphasize ? FontWeight.w800 : FontWeight.w400, fontSize: emphasize ? 15 : 12))),
        Text(value, style: TextStyle(color: valueColor, fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600, fontSize: emphasize ? 17 : 12)),
      ],
    );
  }
}

class _CheckoutPage extends StatefulWidget {
  const _CheckoutPage({required this.total, required this.address, required this.onPlaceOrder});

  final double total;
  final String address;
  final VoidCallback onPlaceOrder;

  @override
  State<_CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<_CheckoutPage> {
  String _payment = 'Card ending in 4242';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.w800))),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 12),
          child: FilledButton(
            onPressed: widget.onPlaceOrder,
            style: FilledButton.styleFrom(backgroundColor: _coral, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            child: Text('Place order · ${_money(widget.total)}', style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text('Delivery details', style: _sectionTitle),
          const SizedBox(height: 10),
          _CheckoutTile(icon: Icons.location_on_outlined, title: 'Deliver to', subtitle: widget.address),
          const SizedBox(height: 18),
          const Text('Payment', style: _sectionTitle),
          const SizedBox(height: 10),
          RadioGroup<String>(
            groupValue: _payment,
            onChanged: (value) {
              if (value != null) setState(() => _payment = value);
            },
            child: Column(
              children: [
                for (final payment in ['Card ending in 4242', 'Cash on delivery'])
                  RadioListTile<String>(
                    value: payment,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    title: Text(payment, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    secondary: Icon(payment.startsWith('Card') ? Icons.credit_card_rounded : Icons.payments_outlined, color: _muted),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Your total', style: _sectionTitle),
          const SizedBox(height: 10),
          _CheckoutTile(icon: Icons.receipt_long_outlined, title: 'Order total', subtitle: _money(widget.total)),
        ],
      ),
    );
  }
}

class _CheckoutTile extends StatelessWidget {
  const _CheckoutTile({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: _coral),
          const SizedBox(width: 11),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: _muted, fontSize: 12))])),
          const Icon(Icons.chevron_right_rounded, color: _muted),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.selectedIndex, required this.cartCount, required this.onSelected});

  final int selectedIndex;
  final int cartCount;
  final ValueChanged<int> onSelected;

  static const _items = [
    (Icons.home_filled, 'Home'),
    (Icons.search_rounded, 'Search'),
    (Icons.receipt_long_outlined, 'Orders'),
    (Icons.favorite_border_rounded, 'Favorites'),
    (Icons.person_outline_rounded, 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: _line))),
      child: Row(
        children: [
          for (var index = 0; index < _items.length; index++)
            Expanded(
              child: InkWell(
                onTap: () => onSelected(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(_items[index].$1, size: 21, color: selectedIndex == index ? _coral : _muted),
                        if (index == 2 && cartCount > 0)
                          Positioned(
                            right: -8,
                            top: -6,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(color: _coral, shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: Text('$cartCount', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(_items[index].$2, style: TextStyle(fontSize: 10, color: selectedIndex == index ? _coral : _muted, fontWeight: selectedIndex == index ? FontWeight.w700 : FontWeight.w500)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({required this.quantity, required this.onDecrease, required this.onIncrease});

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: _paper, borderRadius: BorderRadius.circular(22)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(tooltip: 'Decrease quantity', visualDensity: VisualDensity.compact, onPressed: onDecrease, icon: const Icon(Icons.remove_rounded, size: 18)),
          SizedBox(width: 20, child: Text('$quantity', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700))),
          IconButton(tooltip: 'Increase quantity', visualDensity: VisualDensity.compact, onPressed: onIncrease, icon: const Icon(Icons.add_rounded, color: _coral, size: 18)),
        ],
      ),
    );
  }
}

class _OfferTag extends StatelessWidget {
  const _OfferTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: const Color(0xFFFFF0EC), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: const TextStyle(color: _coral, fontSize: 9, fontWeight: FontWeight.w800)),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.label, required this.onTap, this.color = _ink, this.hasDot = false});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool hasDot;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: color, size: 20, semanticLabel: label),
              if (hasDot)
                const Positioned(right: 10, top: 9, child: CircleAvatar(radius: 3, backgroundColor: _coral)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({required this.icon, required this.label, required this.onTap, required this.color});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 34, height: 34, child: Icon(icon, color: color, size: 18, semanticLabel: label)),
      ),
    );
  }
}

class _FoodImage extends StatelessWidget {
  const _FoodImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: const Color(0xFFE9E3DB),
        alignment: Alignment.center,
        child: const Icon(Icons.restaurant_rounded, color: Color(0xFFB7A99A), size: 34),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 43, color: _coral),
            const SizedBox(height: 13),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: _muted, height: 1.4)),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 15),
              FilledButton(onPressed: onAction, style: FilledButton.styleFrom(backgroundColor: _coral), child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context) => const _EmptyState(
        icon: Icons.search_off_rounded,
        title: 'No matches found',
        message: 'Try another dish, restaurant, or category.',
      );
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(backgroundColor: const Color(0xFFFFE8E1), foregroundColor: _coral, child: Icon(icon, size: 19)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: _muted, fontSize: 12))])),
      ],
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.initialFilters});

  final Set<String> initialFilters;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late final Set<String> _selected = {...widget.initialFilters};
  static const _options = ['4.7+', 'Free delivery', 'Under 30 min'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filters', style: _sectionTitle),
            const SizedBox(height: 8),
            const Text('Find the right bite for right now.', style: TextStyle(color: _muted)),
            const SizedBox(height: 14),
            for (final option in _options)
              CheckboxListTile(
                value: _selected.contains(option),
                onChanged: (selected) => setState(() {
                  if (selected == true) {
                    _selected.add(option);
                  } else {
                    _selected.remove(option);
                  }
                }),
                title: Text(option),
                activeColor: _coral,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context, _selected),
                style: FilledButton.styleFrom(backgroundColor: _coral, minimumSize: const Size.fromHeight(48)),
                child: const Text('Show results'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({required this.icon, required this.title, required this.subtitle, this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(icon, color: _coral),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: _muted, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded, color: _muted),
      ),
    );
  }
}

String _money(double value) => '\$${value.toStringAsFixed(2)}';

void _showShareMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Restaurant link copied')),
  );
}