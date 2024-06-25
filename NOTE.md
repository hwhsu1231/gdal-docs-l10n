

```bash
sudo apt install libproj-dev swig
python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r doc/requirements.txt
pip install numpy
cmake -S . -B out/build -DCMAKE_BUILD_TYPE=Release -DBUILD_APPS=OFF -DGDAL_BUILD_OPTIONAL_DRIVERS=OFF -DOGR_BUILD_OPTIONAL_DRIVERS=OFF -DCMAKE_INSTALL_PREFIX=$(pwd)/out/install
cmake --build out/build
cmake --install out/build
make -C doc clean
# 方法 1：
export PYTHONPATH=$(pwd)/out/install/lib/python3.10/site-packages:$PYTHONPATH
export LD_LIBRARY_PATH=$(pwd)/out/install/lib:$LD_LIBRARY_PATH
mkdir -p doc/build; make -C doc html O="-D enable_redirects=1 -v"
# 方法 2：
mkdir -p doc/build; PYTHONPATH=$(pwd)/out/install/lib/python3.10/site-packages LD_LIBRARY_PATH=$(pwd)/out/install/lib make -C doc html O="-D enable_redirects=1 -v" 2>&1
# 方法 3：(x)
mkdir -p doc/build; PYTHONPATH=$(pwd)/out/install/lib/python3.10/site-packages:$(pwd)/out/install/lib/libgdal.so make -C doc html O="-D enable_redirects=1 -v"
```



### 安裝 python3.9-dev 軟體包

在 Kubuntu 上嘗試使用 python 3.9 3.8 等 3.10 之前的版本。結果卻遇到錯誤：

```
[build] extensions/gdal_wrap.cpp:180:11: fatal error: Python.h: No such file or directory
[build]   180 | # include <Python.h>
[build]       |           ^~~~~~~~~~
[build] compilation terminated.
[build] extensions/gdalconst_wrap.c:156:11: fatal error: Python.h: No such file or directory
[build]   156 | # include <Python.h>
[build]       |           ^~~~~~~~~~
[build] compilation terminated.
[build] extensions/osr_wrap.cpp:180:11: fatal error: Python.h: No such file or directory
[build]   180 | # include <Python.h>
[build]       |           ^~~~~~~~~~
[build] compilation terminated.
[build] extensions/gnm_wrap.cpp:180:11: fatal error: Python.h: No such file or directory
[build]   180 | # include <Python.h>
[build]       |           ^~~~~~~~~~
[build] compilation terminated.
[build] extensions/ogr_wrap.cpp:180:11: fatal error: Python.h: No such file or directory
[build]   180 | # include <Python.h>
[build]       |           ^~~~~~~~~~
[build] compilation terminated.
[build] extensions/gdal_array_wrap.cpp:180:11: fatal error: Python.h: No such file or directory
[build]   180 | # include <Python.h>
[build]       |           ^~~~~~~~~~
```

原因似乎是因為沒有安裝 `python3.9-dev` 軟體包（根據：`https://stackoverflow.com/questions/21530577/fatal-error-python-h-no-such-file-or-directory`）



