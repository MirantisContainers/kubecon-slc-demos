#!/bin/bash

set -e

wget -i images.txt -P files/images
wget -i bins.txt -P files/bins
wget -i manifests.txt -P files/manifests
