allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
// Old plugins (fluttertoast, flutter_sunmi_printer_plus) compile against SDK < 34,
// which newer AndroidX dependencies reject. Force a recent compileSdk on them.
subprojects {
    if (name != "app") {
        afterEvaluate {
            extensions.findByName("android")?.let { ext ->
                ext.javaClass
                    .getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                    .invoke(ext, 36)
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
