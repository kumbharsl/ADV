// main.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

// App Controller
class AppController extends GetxController {
  final _storage = GetStorage();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _storage.read('darkMode') ?? false;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write('darkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

// Home Controller
class HomeController extends GetxController {
  final currentIndex = 0.obs;

  // List with 18 items from Dnyaneshwari
  final items = [
    {
      'id': 1,
      'title': 'Dnyaneshwari Chapter 1',
      'description': 'Arjuna’s Dilemma and Vishada Yoga'
    },
    {
      'id': 2,
      'title': 'Dnyaneshwari Chapter 2',
      'description': 'Sankhya Yoga – Transcendental Knowledge'
    },
    {
      'id': 3,
      'title': 'Dnyaneshwari Chapter 3',
      'description': 'Karma Yoga – The Yoga of Action'
    },
    {
      'id': 4,
      'title': 'Dnyaneshwari Chapter 4',
      'description':
          'Jnana Karma Sanyasa Yoga – The Yoga of Knowledge and Renunciation of Action'
    },
    {
      'id': 5,
      'title': 'Dnyaneshwari Chapter 5',
      'description': 'Karma Sanyasa Yoga – The Yoga of Renunciation'
    },
    {
      'id': 6,
      'title': 'Dnyaneshwari Chapter 6',
      'description': 'Dhyana Yoga – The Yoga of Meditation'
    },
    {
      'id': 7,
      'title': 'Dnyaneshwari Chapter 7',
      'description': 'Jnana Vijnana Yoga – The Yoga of Knowledge and Wisdom'
    },
    {
      'id': 8,
      'title': 'Dnyaneshwari Chapter 8',
      'description': 'Aksara Brahma Yoga – The Yoga of the Imperishable Brahman'
    },
    {
      'id': 9,
      'title': 'Dnyaneshwari Chapter 9',
      'description':
          'Raja Vidya Raja Guhya Yoga – The Yoga of Royal Knowledge and Royal Secret'
    },
    {
      'id': 10,
      'title': 'Dnyaneshwari Chapter 10',
      'description': 'Vibhuti Yoga – The Yoga of Divine Glories'
    },
    {
      'id': 11,
      'title': 'Dnyaneshwari Chapter 11',
      'description':
          'Visvarupa Darsana Yoga – The Yoga of the Vision of the Universal Form'
    },
    {
      'id': 12,
      'title': 'Dnyaneshwari Chapter 12',
      'description': 'Bhakti Yoga – The Yoga of Devotion'
    },
    {
      'id': 13,
      'title': 'Dnyaneshwari Chapter 13',
      'description':
          'Kshetra Kshetragna Vibhaga Yoga – The Yoga of the Field and the Knower of the Field'
    },
    {
      'id': 14,
      'title': 'Dnyaneshwari Chapter 14',
      'description':
          'Gunatraya Vibhaga Yoga – The Yoga of the Division of the Three Gunas'
    },
    {
      'id': 15,
      'title': 'Dnyaneshwari Chapter 15',
      'description':
          'Purushottama Yoga – The Yoga of the Supreme Divine Personality'
    },
    {
      'id': 16,
      'title': 'Dnyaneshwari Chapter 16',
      'description':
          'Daivasura Sampad Vibhaga Yoga – The Yoga of the Division between the Divine and the Demoniacal'
    },
    {
      'id': 17,
      'title': 'Dnyaneshwari Chapter 17',
      'description': 'Sraddhatraya Vibhaga Yoga – The Yoga of Threefold Faith'
    },
    {
      'id': 18,
      'title': 'Dnyaneshwari Chapter 18',
      'description':
          'Moksha Sanyasa Yoga – The Yoga of Liberation and Renunciation'
    },
  ].obs;

  void changePage(int index) => currentIndex.value = index;
}

// Detail Controller
class DetailController extends GetxController {
  final isFavorite = false.obs;
  late final int itemId;

  @override
  void onInit() {
    super.onInit();
    itemId = Get.arguments as int;
  }

  void toggleFavorite() => isFavorite.value = !isFavorite.value;
}

// App
class MyApp extends StatelessWidget {
  final appController = Get.put(AppController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dnyaneshwari',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/detail', page: () => DetailScreen()),
      ],
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Replacing FlutterLogo with the assets image
              Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white, // White background for the image
                  borderRadius:
                      BorderRadius.circular(50), // Circle image background
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit
                        .cover, // Adjust how the image fits in the container
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final AppController appController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent, // AppBarBg color

        title: const Text(
          'Dnyaneshwari',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              // color: Colors.black,
            ),
            onPressed: () => Get.snackbar(
              'Notifications',
              'No new notifications',
              snackPosition: SnackPosition.BOTTOM,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () => Get.snackbar(
              'Language',
              'Language changed',
              snackPosition: SnackPosition.BOTTOM,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                appController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: appController.toggleTheme,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Users',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                controller.changePage(0);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Get.back();
                Get.snackbar('Settings', 'Coming soon');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              title: const Text('Ratings'),
              onTap: () {
                Get.back();
                Get.snackbar('Rating', 'Coming soon');
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Events'),
              onTap: () {
                Get.back();
                Get.snackbar('Events', 'Coming soon');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Info'),
              onTap: () {
                Get.back();
                Get.snackbar('Settings', 'Coming soon');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Obx(() => Switch(
                    value: appController.isDarkMode.value,
                    onChanged: (val) => appController.toggleTheme(),
                  )),
            ),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About Us'),
            ),
          ],
        ),
      ),
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              // Home Tab
              ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child:
                              Text('${index + 1}'), // Showing index in a circle
                        ),
                        title: Text("${item['title']}"), // Item title
                        subtitle:
                            Text("${item['description']}"), // Item description
                        onTap: () => Get.toNamed('/detail',
                            arguments: index), // Navigate to detail page
                      ),
                      const Divider(), // Divider between list items
                    ],
                  );
                },
              ),
              // Search Tab
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 100, color: Colors.grey),
                    Text('Search Feature Coming Soon'),
                  ],
                ),
              ),
              // Favorites Tab
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, size: 100, color: Colors.red),
                    Text('No Favorites Yet'),
                  ],
                ),
              ),
              // Profile Tab
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    SizedBox(height: 20),
                    Text('Profile Feature Coming Soon'),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.orangeAccent, // BottomNavigationBar color
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black54,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          )),
    );
  }
}

// Detail Screen
class DetailScreen extends StatelessWidget {
  final DetailController controller = Get.put(DetailController());

  DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.isFavorite.value ? Colors.red : null,
                ),
                onPressed: controller.toggleFavorite,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item ${controller.itemId + 1}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Detailed description for item ${controller.itemId + 1}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Additional Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Category'),
              subtitle: Text('Category ${(controller.itemId % 4) + 1}'),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Created Date'),
              subtitle: Text(
                DateTime.now()
                    .subtract(Duration(days: controller.itemId))
                    .toString()
                    .split(' ')[0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
