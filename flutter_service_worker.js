'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "42dbcea7fb445741e49bc6c0904a3948",
"splash/style.css": "85b9bc5808a6c2e98251c14244b99ae7",
"splash/img/dark-2x.png": "30de973e212cc25460a50377c5dfadd2",
"splash/img/light-1x.png": "72f828e63d515cb0653e4e22074c543e",
"splash/img/dark-1x.png": "c4eefd6d583681a1b97345bc9013fb4e",
"splash/img/dark-3x.png": "4c2fd0242ccb0b9fdd7d2bd4edaecd29",
"splash/img/light-3x.png": "694189211dcd53d85157e414c36682c0",
"splash/img/light-2x.png": "780eff04c8e2ebbfbac3e71d4ea2d81d",
"favicon.ico": "3e0659e9410a8399c4df6f577090a795",
"favicon.png": "e5074620112c0b2730420ae547f6a928",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "4ac729d8ab2dfd05e6d2e6930a997566",
"assets/assets/images/logo_web_dark.jpg": "dc20063d21ddf06ba118495542a2b16d",
"assets/assets/images/logo_only_black.png": "00cf4fd5a291a69311a921b6909dbc2c",
"assets/assets/images/splash_dark.png": "35800d06d721a3de39381f258cba1b6f",
"assets/assets/images/logo_only_white.png": "3caaf62450fd9702395582ab98155783",
"assets/assets/images/splash_light.png": "2e58f95af1fadc4f9800a0e1cbb74adc",
"assets/assets/fonts/MotionControlNeueLite.otf": "9ec0a2b1444d60c12f92b77032f25509",
"assets/FontManifest.json": "9b7fedf043174097da9f86fb9f658c87",
"assets/i18n/my.json": "06220f45556dd5ef4deb1ddb6058e92a",
"assets/i18n/en.json": "7f7cde0a1f4ed3f1733b12056cc6677a",
"assets/AssetManifest.json": "1db446536a04b0553f0d939fc3a14ff9",
"assets/packages/slimy_card/assets/flare/bottomSlime.flr": "3a26ed39d3a9a9956105e9e6e4d5ad43",
"assets/packages/slimy_card/assets/flare/topSlime.flr": "9f381ee39c22b624c805f536b39171a6",
"assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "3241d1d9c15448a4da96df05f3292ffe",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "eaed33dc9678381a55cb5c13edaf241d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "ffed6899ceb84c60a1efa51c809a57e4",
"assets/packages/flutter_vector_icons/fonts/Zocial.ttf": "5cdf883b18a5651a29a4d1ef276d2457",
"assets/packages/flutter_vector_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_vector_icons/fonts/Octicons.ttf": "8e7f807ef943bff1f6d3c2c6e0f3769e",
"assets/packages/flutter_vector_icons/fonts/Feather.ttf": "e766963327e0a89f9ec2ba88646b6177",
"assets/packages/flutter_vector_icons/fonts/MaterialCommunityIcons.ttf": "6a2ddad1092a0a1c326b6d0e738e682b",
"assets/packages/flutter_vector_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_vector_icons/fonts/MaterialIcons.ttf": "8ef52a15e44481b41e7db3c7eaf9bb83",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Solid.ttf": "1ab236ed440ee51810c56bd16628aef0",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Regular.ttf": "db78b9359171f24936b16d84f63af378",
"assets/packages/flutter_vector_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_vector_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_vector_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_vector_icons/fonts/Ionicons.ttf": "b3263095df30cb7db78c613e73f9499a",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Brands.ttf": "13685372945d816a2b474fc082fd9aaa",
"assets/packages/flutter_vector_icons/fonts/Entypo.ttf": "744ce60078c17d86006dd0edabcd59a7",
"assets/packages/flutter_vector_icons/fonts/Fontisto.ttf": "b49ae8ab2dbccb02c4d11caaacf09eab",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"icons/apple-icon-114x114.png": "22cbaae89716da7dccd2935d45434968",
"icons/apple-icon-120x120.png": "0b0812494430dcdccfe804f25d290a05",
"icons/favicon.ico": "3e0659e9410a8399c4df6f577090a795",
"icons/apple-icon-180x180.png": "dd1b96e7a1d81e57160b9e2af39ea7c2",
"icons/favicon-96x96.png": "501377f5710bfeb1b65fcbaf12faec72",
"icons/apple-icon-57x57.png": "10c5556c984a5399c73700ea06bd2635",
"icons/android-icon-192x192.png": "0f68eb070520818f6f162b5ffdb1f3ad",
"icons/ms-icon-144x144.png": "7c1c3e4039b94aaedc6b178e061632e7",
"icons/apple-icon-152x152.png": "70fe4c963478258a189053696bea46d1",
"icons/apple-icon-precomposed.png": "86103bff3f2f6ea61752f0e666f0c27a",
"icons/android-icon-48x48.png": "cb54e009e9d32d7d20bc97a7af21d83c",
"icons/android-icon-144x144.png": "7c1c3e4039b94aaedc6b178e061632e7",
"icons/android-icon-96x96.png": "501377f5710bfeb1b65fcbaf12faec72",
"icons/apple-icon.png": "86103bff3f2f6ea61752f0e666f0c27a",
"icons/apple-icon-60x60.png": "0a77e32ffd2ea94c6b361cd295408cbd",
"icons/favicon-16x16.png": "e5074620112c0b2730420ae547f6a928",
"icons/manifest.json": "4a627cbd5944024f83d69c9c6322613a",
"icons/ms-icon-150x150.png": "a8642782e026bcdd025a795dd73e9c8c",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/apple-icon-76x76.png": "084f0456621ee69e770f1fff3d8e812a",
"icons/ms-icon-310x310.png": "6cb3efe39c3e0e44a4c16cfb469c760b",
"icons/android-icon-72x72.png": "71aeb2b1e97a69a33a76f2b9b81cc0de",
"icons/apple-icon-72x72.png": "71aeb2b1e97a69a33a76f2b9b81cc0de",
"icons/favicon-32x32.png": "6c3619bb23ec9ccb0e9b69d30060d207",
"icons/ms-icon-70x70.png": "064fbafc241bef1cbc5c4601372a1021",
"icons/apple-icon-144x144.png": "7c1c3e4039b94aaedc6b178e061632e7",
"icons/android-icon-36x36.png": "4b43d845cec249f69d17e3db1f910c46",
"main.dart.js": "d197b24d5be958195f37c9456e091a21",
"manifest.json": "c7af34f78277ebe9925c500a61b7c664",
"index.html": "2a348f47bfc5e68f4b8867f7dc4641ad",
"/": "2a348f47bfc5e68f4b8867f7dc4641ad"
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
