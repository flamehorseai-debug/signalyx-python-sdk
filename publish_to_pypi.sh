#!/bin/bash
# Script to build and publish signalyx SDK to PyPI
# Run this on the server or locally where you have PyPI credentials

set -e

echo "=== Signalyx Python SDK — PyPI Publishing ==="

# Install build tools
pip install --quiet build twine

# Clean previous builds
rm -rf dist/ build/ *.egg-info

# Build
echo "Building..."
python -m build

echo ""
echo "Built packages:"
ls -la dist/

# Publish to PyPI
echo ""
echo "Publishing to PyPI..."
echo "You will need your PyPI API token (create at https://pypi.org/manage/account/token/)"
echo ""

# Use: TWINE_PASSWORD=pypi-xxx twine upload dist/*
# Or interactively:
python -m twine upload dist/*

echo ""
echo "Done! Install with: pip install signalyx"
echo "Package URL: https://pypi.org/project/signalyx/"
