package mla303.paul_app

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin


class Application: FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    // ...
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
    }
//    override fun registerWith(registry:PluginRegistry) {
//        FlutterFirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//    }
//override fun registerWith(registry:PluginRegistry) {
//    GeneratedPluginRegistrant.registerWith(registry)
//}
override fun registerWith(registry: PluginRegistry?) {
    io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
     
}
}