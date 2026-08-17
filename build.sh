cmake -S . -B build -G Ninja -DCMAKE_PREFIX_PATH="dependencies/qt/6.11.1"
ninja -C build -j 8
