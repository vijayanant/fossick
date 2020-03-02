#!/bin/bash

echo -e "Building your site..."

# Build the project.
#hugo --theme=hyde-hyde-vj
hugo 

echo -e "Pushing site code to remote repo..."
# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

echo -e "Deploying your updates..."

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..

echo -e "\n All done."
