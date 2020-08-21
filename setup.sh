#!/usr/bin/env bash

DEMO_MODEL=data/models/naip_demo_model.h5
if [ -f "$DEMO_MODEL" ]; then
    echo "$DEMO_MODEL exists. No need to reacquire project assets."
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

# configure the backend server with the demo models/data
for f in endpoints.js datasets.json models.json
do
    DEMO_FILE=web_tool/$f
    EXT="${DEMO_FILE##*.}"  # get the files extension
    PATH="${DEMO_FILE%.*}"  # get the file path
    MY_FILE="${PATH}.mine.${EXT}"
    if [ -f "$MY_FILE" ]; then
        echo "$MY_FILE exists. Leaving as-is."
    else
        cp "$DEMO_FILE" "$MY_FILE"
    fi
done

source /etc/profile.d/conda.sh
conda activate landcover

ACCESS_POINT=http://localhost:$PORT/
echo "Open your browser to $ACCESS_POINT to connect!"

python server.py
