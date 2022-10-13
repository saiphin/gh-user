ios:
	open -a Simulator
build-apk:
	flutter build apk --split-per-abi
clean:
	cd android && ./gradlew clean && cd ..
release-android:
	flutter run --release
build-release:
	flutter build appbundle --release
run-web:
	flutter run -d chrome --web-renderer html