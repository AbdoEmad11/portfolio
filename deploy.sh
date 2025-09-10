#!/bin/bash

# Build Flutter web app
echo "Building Flutter web app..."
flutter build web --release

# Copy build files to docs folder for GitHub Pages
echo "Copying build files to docs folder..."
rm -rf docs
mkdir docs
cp -r build/web/* docs/

# Add and commit changes
echo "Committing changes..."
git add docs/
git commit -m "Deploy Flutter web app to GitHub Pages"

# Push to GitHub
echo "Pushing to GitHub..."
git push origin main

echo "Deployment complete! Your app should be available at:"
echo "https://abdoemad11.github.io/portfolio/"
