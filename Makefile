BUILD_NAME=$(shell grep '^version: ' pubspec.yaml | cut -d+ -f1 | sed 's/version: //')
BUILD_NUMBER=$(shell grep '^version: ' pubspec.yaml | cut -d+ -f2)


.PHONY: clean
clean: ## Clean the project and remove all generated files
	@rm -f coverage.*
	@rm -rf dist bin out build
	@rm -rf coverage .dart_tool .packages pubspec.lock
	@echo "Project successfully cleaned"

.PHONY: g
g: ## Get dependencies
	@fvm flutter pub get

.PHONY: build_runner
build_runner: ## Run build_runner
	@fvm dart run build_runner build -d --release

.PHONY: apk
apk: ## Release build APK with build-name and build-number
	@fvm flutter build apk --release --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER)
# 	@flutter build $@ --release --split-per-abi
	@open build/app/outputs/apk/release/

.PHONY: ipa
ipa: ## Release build IPA with build-name and build-number
	@fvm flutter build $@ --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER)
	@open build/ios/archive/Runner.xcarchive

.PHONY: apk-prod
apk-prod: ## Release build APK with build-name and build-number
	@fvm flutter build apk --release --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) --dart-define=env=prod
	@open build/app/outputs/apk/release/

.PHONY: ipa-prod
ipa-prod: ## Release build IPA with build-name and build-number
	@fvm flutter build ipa --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) --dart-define=env=prod
	@open build/ios/archive/Runner.xcarchive

.PHONY: aab
aab: ## Release build AAB with build-name and build-number
	@fvm flutter build appbundle --build-name=$(BUILD_NAME) --build-number=$(BUILD_NUMBER) --dart-define=env=prod
	@open build/app/outputs/bundle/release/