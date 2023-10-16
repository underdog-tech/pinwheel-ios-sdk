VERSION=$(grep -E 's.version[[:space:]]*=' PinwheelSDK.podspec | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")

echo $VERSION

# Tag the commit
git tag "$VERSION"

# Push the changes to the remote
git push origin "$VERSION"
