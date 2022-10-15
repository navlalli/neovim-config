# Create a directory for each plugin with an empty config file
PLUGIN=$1
SHORT=$2

cd lua
mkdir ${PLUGIN}
cd ${PLUGIN}
touch ${SHORT}config.lua
