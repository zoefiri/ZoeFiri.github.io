#!/bin/bash
read -r header < "posts/1 day1/header"
read -r content < "posts/1 day1/content"
read -r title < "posts/1 day1/title"
sed -e "s/#header/$header/" -e "s/#content/$content/" -e "s/#title/$title/" templates/fuck.html > fuck.html
