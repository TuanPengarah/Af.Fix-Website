'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "splash/img/dark-2x.png": "d3e62b8d36c8ff50d72394ce8de2fd3d",
"splash/img/light-2x.png": "f96770bf7b45c106baa7803d34f1372a",
"splash/img/dark-1x.png": "ce96906ad9da658cdd828aa39c182939",
"splash/img/light-1x.png": "b00ce8a3c0377f303bc3702c9fdd75da",
"splash/img/light-3x.png": "89d523b0afc9902e934495b23a8b2030",
"splash/img/dark-3x.png": "b265afa5e82e3d5796c1e518d8a76d61",
"splash/style.css": "85b9bc5808a6c2e98251c14244b99ae7",
"favicon.png": "58af0e0bcc7c0cf3b56c6316b6c84569",
"main.dart.js": "e2ac4a694d0982cf1d5f57c3208ace52",
"index.html": "57543c4f7df6c4110c3b4ab4999f00c5",
"/": "57543c4f7df6c4110c3b4ab4999f00c5",
"manifest.json": "c1c05b36b4b98d3ee00298846bcdb93f",
"assets/i18n/my.json": "d676f2bf7d0a166e6b0e9a60b9e5af65",
"assets/i18n/en.json": "8333cbc8f8d4b5dba8ef160127536f07",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"assets/packages/slimy_card/assets/flare/bottomSlime.flr": "3a26ed39d3a9a9956105e9e6e4d5ad43",
"assets/packages/slimy_card/assets/flare/topSlime.flr": "9f381ee39c22b624c805f536b39171a6",
"assets/packages/flutter_vector_icons/fonts/Ionicons.ttf": "b3263095df30cb7db78c613e73f9499a",
"assets/packages/flutter_vector_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_vector_icons/fonts/MaterialCommunityIcons.ttf": "6a2ddad1092a0a1c326b6d0e738e682b",
"assets/packages/flutter_vector_icons/fonts/MaterialIcons.ttf": "8ef52a15e44481b41e7db3c7eaf9bb83",
"assets/packages/flutter_vector_icons/fonts/Feather.ttf": "e766963327e0a89f9ec2ba88646b6177",
"assets/packages/flutter_vector_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_vector_icons/fonts/Fontisto.ttf": "b49ae8ab2dbccb02c4d11caaacf09eab",
"assets/packages/flutter_vector_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_vector_icons/fonts/Entypo.ttf": "744ce60078c17d86006dd0edabcd59a7",
"assets/packages/flutter_vector_icons/fonts/Octicons.ttf": "8e7f807ef943bff1f6d3c2c6e0f3769e",
"assets/packages/flutter_vector_icons/fonts/Zocial.ttf": "5cdf883b18a5651a29a4d1ef276d2457",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Regular.ttf": "db78b9359171f24936b16d84f63af378",
"assets/packages/flutter_vector_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Solid.ttf": "1ab236ed440ee51810c56bd16628aef0",
"assets/packages/flutter_vector_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Brands.ttf": "13685372945d816a2b474fc082fd9aaa",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "3241d1d9c15448a4da96df05f3292ffe",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "ffed6899ceb84c60a1efa51c809a57e4",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "eaed33dc9678381a55cb5c13edaf241d",
"assets/NOTICES": "6c99d03f4395152e08a29ed3e0cc57b8",
"assets/FontManifest.json": "9b7fedf043174097da9f86fb9f658c87",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/images/logo_only_black.png": "00cf4fd5a291a69311a921b6909dbc2c",
"assets/assets/images/logo_web_dark.jpg": "dc20063d21ddf06ba118495542a2b16d",
"assets/assets/images/splash_dark.png": "39a7823193439a60121f0f94f5e38037",
"assets/assets/images/logo_only_white.png": "3caaf62450fd9702395582ab98155783",
"assets/assets/images/splash_light.png": "e641d2ab68d7772b7acfc420651f0261",
"assets/assets/fonts/MotionControlNeueLite.otf": "9ec0a2b1444d60c12f92b77032f25509",
"assets/AssetManifest.json": "1db446536a04b0553f0d939fc3a14ff9",
"version.json": "42dbcea7fb445741e49bc6c0904a3948",
"icons/android-icon-36x36.png": "f40c5b696004be265741f57a8d9835a0",
"icons/apple-icon-60x60.png": "a1417c8dc880ac8d4dbf9084a2923c29",
"icons/android-icon-72x72.png": "be28995a4d0f339c9cf9dde2e3ab3baa",
"icons/android-icon-96x96.png": "b6c9f53a97d937615dd87a95e9dd1ecd",
"icons/apple-icon-57x57.png": "4be26a9bf71aacb9864ca223695573ba",
"icons/apple-icon-180x180.png": "e3fd4f8547f6846a93996545f0c03332",
"icons/apple-icon-72x72.png": "be28995a4d0f339c9cf9dde2e3ab3baa",
"icons/favicon-16x16.png": "58af0e0bcc7c0cf3b56c6316b6c84569",
"icons/apple-icon-152x152.png": "bf5f0c61c9272d58631a63d745a5a366",
"icons/apple-icon-76x76.png": "64e25353232a34165023958f1a538f6d",
"icons/manifest.json": "a69cb23b49c992be60b7bdc2f1ec6813",
"icons/apple-icon-120x120.png": "2e8d5d7af167617a6f1c01744cd2e898",
"icons/favicon-32x32.png": "dbd15e9e08e50cf2cf5933efaff14b50",
"icons/ms-icon-310x310.png": "be2df71d23c42f75e6f10b9b5feef202",
"icons/android-icon-192x192.png": "99b0d91f59efddbb32f07db40e78c8d8",
"icons/ms-icon-70x70.png": "df41d4b05b83d189a063f4d2edbaee03",
"icons/android-icon-48x48.png": "528cf808775dd0ede93833890087df4d",
"icons/favicon-96x96.png": "b6c9f53a97d937615dd87a95e9dd1ecd",
"icons/apple-icon-precomposed.png": "ef22c5b0f7c0ed2bf196e747da6d4945",
"icons/favicon.ico": "562c0adcb9842c2f3925a6c0b36911a3",
"icons/android-icon-144x144.png": "f93c75b93d0275bfe2ac2c4809c437a3",
"icons/apple-icon.png": "ef22c5b0f7c0ed2bf196e747da6d4945",
"icons/apple-icon-144x144.png": "f93c75b93d0275bfe2ac2c4809c437a3",
"icons/ms-icon-144x144.png": "f93c75b93d0275bfe2ac2c4809c437a3",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/apple-icon-114x114.png": "23a66cd2d38a31f5f20535a7fb5ae35b",
"icons/ms-icon-150x150.png": "ad4e591ee94319bc9e542be5e05e629c",
"favicon.ico": "562c0adcb9842c2f3925a6c0b36911a3"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
