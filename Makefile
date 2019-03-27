SWIFT ?= SWIFT

generate-xcodeproj:
	@echo "Generating xcode project"
	@$(SWIFT) package generate-xcodeproj