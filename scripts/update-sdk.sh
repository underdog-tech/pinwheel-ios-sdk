#!/bin/bash

# Define the location of the versions.json in S3
S3_PATH="s3://ios-sdk-internal-builds/versions.json"

# Ensure AWS CLI is installed and configured with appropriate permissions
# TODO

# Fetch the JSON content from S3
aws s3 cp "$S3_PATH" - | jq . > temp_versions.json
JSON_CONTENT=$(cat temp_versions.json)

XCFRAMEWORK_DIRNAME="PinwheelSDK.xcframework"

# Default limit for the number of entries displayed
LIMIT=10

# Check for flags
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --help) HELP=true;;
        --latest) LATEST=true;;
        --limit) LIMIT="$2"; shift;;
        --version) VERSION_FILTER="$2"; shift;;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

if [ "$HELP" == "true" ]; then
    echo "Usage: ./update-sdk.sh [OPTIONS]"
    echo "Updates the Internal Pinwheel SDK"
    echo ""
    echo "Options:"
    echo "  --latest        Fetch the latest internal SDK version."
    echo "  --limit [num]   Limit the number of entries displayed. Default is 10."
    echo "  --version [ver] Filter entries by the specified version."
    echo "  --help          Display this help message."
    echo ""
    echo "Examples:"
    echo "  ./update-sdk.sh --latest"
    echo "  ./update-sdk.sh --limit 20 --version 2.4.0"
    exit 0  # Exit after displaying help
fi


# Get combined version and hash entries (limited by the LIMIT variable)
if [ -z "$VERSION_FILTER" ]; then
    # If VERSION_FILTER is not set, process without the select filter
    IFS=$'\n' ENTRIES=($(echo "$JSON_CONTENT" | jq -r '.versions[] | "\(.version) - \(.hash)"' | head -n $LIMIT))
else
    # If VERSION_FILTER is set, filter the versions accordingly
    IFS=$'\n' ENTRIES=($(echo "$JSON_CONTENT" | jq -r --arg vf "$VERSION_FILTER" '.versions[] | select(.version==$vf) | "\(.version) - \(.hash)"' | head -n $LIMIT))
fi

if [ ${#ENTRIES[@]} -eq 0 ]; then
    echo "Error: No entries found matching the criteria."
    exit 1
fi

# If --latest flag is provided, select the first entry automatically
if [ "$LATEST" == "true" ]; then
    ENTRY=${ENTRIES[0]}
else
    echo "Available versions:"
    select ENTRY in "${ENTRIES[@]}"; do
        if [[ " ${ENTRIES[@]} " =~ " ${ENTRY} " ]]; then
            break
        else
            echo "Invalid selection!"
        fi
    done
fi

# Extract version and hash from the selected entry
VERSION=$(echo $ENTRY | cut -d' ' -f1)
HASH=$(echo $ENTRY | cut -d' ' -f3)

# Extract binaryURL for the selected version and hash
BINARY_S3_URL=$(echo "$JSON_CONTENT" | jq -r --arg v "$VERSION" --arg h "$HASH" '.versions[] | select(.version==$v and .hash==$h) | .binaryURL')

# Download
aws s3 cp "$BINARY_S3_URL" temp.zip

# Check if the directory exists, and if so, remove it
if [ -d "$XCFRAMEWORK_DIRNAME" ]; then
    rm -rf "$XCFRAMEWORK_DIRNAME"
fi

# Unpack
unzip temp.zip

# Clean up
rm temp_versions.json
rm temp.zip