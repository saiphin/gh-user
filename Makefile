app-ios:
	open -a Simulator
app-android:
	emulator -avd phone
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

git:
	git add .
	git commit -m "$m"
	git push