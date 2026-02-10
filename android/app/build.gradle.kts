import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "pt.pedroafmonteiro.in_porto"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "pt.pedroafmonteiro.in_porto"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        val localProperties = Properties().apply {
            load(project.rootProject.file("local.properties").inputStream())
        }
    }

    signingConfigs {
        create("release") {
            val sFile = keystoreProperties["storeFile"] as String?
                ?: System.getenv("SIGNING_KEYSTORE_PATH")

            val sPassword = keystoreProperties["storePassword"] as String?
                ?: System.getenv("SIGNING_STORE_PASSWORD")

            val kAlias = keystoreProperties["keyAlias"] as String?
                ?: System.getenv("SIGNING_KEY_ALIAS")

            val kPassword = keystoreProperties["keyPassword"] as String?
                ?: System.getenv("SIGNING_KEY_PASSWORD")

            if (sFile != null) {
                val resolvedFile = file(sFile)
                
                if (resolvedFile.exists()) {
                    storeFile = resolvedFile
                    storePassword = sPassword
                    keyAlias = kAlias
                    keyPassword = kPassword
                } else {
                    println("ERROR: Keystore file does not exist!")
                }
            } else {
                println("ERROR: sFile variable is null!")
            }
        }
    }

    buildTypes {
        getByName("release") {
            resValue("string", "app_name", "In Porto")

            val releaseSigning = signingConfigs.getByName("release")
            if (releaseSigning.storeFile != null) {
                signingConfig = releaseSigning
            } else {
                println("Release keystore not found. Build will not be signed.")
            }

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        getByName("debug") {
            resValue("string", "app_name", "In Porto (dev)")
            applicationIdSuffix = ".dev"
            signingConfig = signingConfigs.getByName("debug")
        }

        getByName("profile") {
            resValue("string", "app_name", "In Porto (profile)")
            applicationIdSuffix = ".profile"
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
