FROM continuumio/anaconda3:latest

# Install dependencies missing from the image above
RUN apt-get update && \
    apt-get -y install zip unzip libgl1-mesa-glx

# Get the project and demo project data
RUN git clone https://github.com/microsoft/landcover.git

# Install the conda environment
RUN cd landcover && \
    conda env create --file environment_precise.yml && \
    cd ..
