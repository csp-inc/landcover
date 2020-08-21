#!/usr/bin/env bash

FILE=data/models/naip_demo_model.h5
if [ -f "$FILE" ]; then
    echo "$FILE exists. No need to reaquire project assets."
else
    wget -O landcover.zip "https://mslandcoverstorageeast.blob.core.windows.net/web-tool-data/landcover.zip"
    unzip -q landcover.zip
    rm landcover.zip

    # unzip the tileset that comes with the demo data
    cd landcover/data/basemaps/
    unzip -q hcmc_sentinel_tiles.zip
    unzip -q m_3807537_ne_18_1_20170611_tiles.zip
    rm *.zip
    cd ../../../
fi

# Configure the backend server with the demo models/data
for f in endpoints datasets models
do
 echo "Processing $f"
 cp web_tool/$f.js web_tool/$f.mine.js
done

# ACCESS_POINT=http://localhost:$PORT/
# echo "$ACCESS_POINT (with usr and pwd '$CRED')"
