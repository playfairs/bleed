#!/bin/bash

REQUIREMENTS="requirements.txt"
LOGS="pip.log"

echo "Starting pip installation from $REQUIREMENTS..."
echo "Error logs will be saved to $LOGS"
echo "" > "$LOGS"

while IFS= read -r package || [[ -n "$package" ]]; do
    if [[ -z "$package" || "$package" =~ ^# ]]; then
        continue
    fi

        echo "Installing $package..."
        if ! pip install "$package" 2>>"$LOGS"; then
            echo "[FAILED] $package" >> "$LOGS"
            echo "Error installing $package. Check $LOGS for details."
        else
            echo "[OK] $package"
        fi
    done < "$REQUIREMENTS"

echo "Done. Check $LOGS for any errors."