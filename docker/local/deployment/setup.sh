#!/bin/bash

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux OS
    echo "Detected Linux OS"

    # Install required packages (replace with actual package manager commands)
    echo "Installing packages..."
    # Example: sudo apt-get install -y <package-name>

    # Generate random JWT_SECRET if not provided
    if [[ -z "$JWT_SECRET" ]]; then
        JWT_SECRET=$(openssl rand -hex 32)
        echo "Generated JWT_SECRET: $JWT_SECRET"
        sed -i "s|your-secret|$JWT_SECRET|g" .env-example
    fi

    # Generate random STORE_ENCRYPTION_KEY if not provided
    if [[ -z "$STORE_ENCRYPTION_KEY" ]]; then
        STORE_ENCRYPTION_KEY=$(openssl rand -hex 16)
        echo "Generated STORE_ENCRYPTION_KEY: $STORE_ENCRYPTION_KEY"
        sed -i "s|<ENCRYPTION_KEY_MUST_BE_32_LONG>|$STORE_ENCRYPTION_KEY|g" .env-example
    fi

    # Add SERVER_URL to .env-example
    sed -i "1s|^|SERVER_URL=$1\n|" .env-example

    # Save a copy of .env-example as .env
    cp .env-example .env

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Detected macOS"

    # Install required packages (replace with actual package manager commands)
    echo "Installing packages..."
    # Example: brew install <package-name>

    # Generate random JWT_SECRET if not provided
    if [[ -z "$JWT_SECRET" ]]; then
        JWT_SECRET=$(openssl rand -hex 32)
        echo "Generated JWT_SECRET: $JWT_SECRET"
        sed -i '' "s|your-secret|$JWT_SECRET|g" .env-example
    fi

    # Generate random STORE_ENCRYPTION_KEY if not provided
    if [[ -z "$STORE_ENCRYPTION_KEY" ]]; then
        STORE_ENCRYPTION_KEY=$(openssl rand -hex 16)
        echo "Generated STORE_ENCRYPTION_KEY: $STORE_ENCRYPTION_KEY"
        sed -i '' "s|<ENCRYPTION_KEY_MUST_BE_32_LONG>|$STORE_ENCRYPTION_KEY|g" .env-example
    fi

    # Add SERVER_URL to .env-example
    sed -i '' "1s|^|SERVER_URL=$1\n|" .env-example

    # Save a copy of .env-example as .env
    cp .env-example .env

else
    echo "Unsupported operating system"
    exit 1
fi
