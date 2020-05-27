#!/usr/bin/env sh
PWD=$(pwd)
cd "${ROS_WORKSPACE}"
cat ./build/**/compile_commands.json > compile_commands.json && sed -i -e ':a;N;$!ba;s/\]\n*\[/,/g' compile_commands.json
compdb -p . list > compile_commands.json.headers
ln -sf "${PWD}/compile_commands.json.headers" compile_commands.json
ccls -index=.
cd "${PWD}"
