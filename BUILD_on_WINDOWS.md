
### Title

Failed to install GDAL python bindings from source on Windows

### What is the bug?

Hello, GDAL Team.

Recently, I tried to install GDAL from source for building GDAL Documentation. In order to successfully install GDAL on both Kubuntu and Windows, I decided to install `proj` and `swig` by Conda.

However, I found that GDAL python bindings (`osgeo.gdal` packages):

- **CAN** be installed to the destination on Kubuntu
- **CANNOT** be installed to the destination on Windows

And it seems that the cause is due to the following error/warning messages on Windows:

<details><summary>Click to expand the messages</summary>

```cmd
  C:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\setuptools\config\_apply_pyprojecttoml.py:103: _WouldIgnoreField: 'entry-points' defined out
  side of `pyproject.toml` would be ignored.
      !!


      ##########################################################################
      # configuration would be ignored/result in error due to `pyproject.toml` #
      ##########################################################################

      The following seems to be defined outside of `pyproject.toml`:

      `entry-points = {'console_scripts': [['rgb2pct = osgeo_utils.rgb2pct:main'], ['pct2rgb = osgeo_utils.pct2rgb:main'], ['ogrmerge = osgeo_utils.ogrmerge:main'], ['ogr_layer_algebra = osgeo_utils.ogr_layer_algebra:main'], ['gdalmove = osgeo_utils.gdalmove:main'], ['gdalcompare = osgeo_utils.gdalcompare:main'], ['gdalattachpct = osgeo_utils.gdalattachpct:main'], ['gdal_sieve = osgeo_utils.gdal_sieve:main'], ['gdal_retile = osgeo_utils.gdal_retile:main'], ['gdal_proximity = osgeo_utils.gdal_proximity:main'], ['gdal_polygonize = osgeo_utils.gdal_polygonize:main'], ['gdal_pansharpen = osgeo_utils.gdal_pansharpen:main'], ['gdal_merge = osgeo_utils.gdal_merge:main'], ['gdal_fillnodata = osgeo_utils.gdal_fillnodata:main'], ['gdal_edit = osgeo_utils.gdal_edit:main'], ['gdal_calc = osgeo_utils.gdal_calc:main'], ['gdal2xyz = osgeo_utils.gdal2xyz:main'], ['gdal2tiles = osgeo_utils.gdal2tiles:main']]}`

      According to the spec (see the link below), however, setuptools CANNOT
      consider this value unless 'entry-points' is listed as `dynamic`.

      https://packaging.python.org/en/latest/specifications/declaring-project-metadata/

      For the time being, `setuptools` will still consider the given value (as a
      **transitional** measure), but please note that future releases of setuptools will
      follow strictly the standard.

      To prevent this warning, you can list 'entry-points' under `dynamic` or alternatively
      remove the `[project]` table from your file and rely entirely on other means of
      configuration.


  !!

    warnings.warn(msg, _WouldIgnoreField)
```

</details>

And the above messages didn't show up when building on Kubuntu.

What did I miss? Is this a bug?

### Steps to reproduce the issue

On Kubuntu 22.04, run the following commands in order:

```
```

On Windows 11, run the following commands in order:

```bat
:: Prepare Git Repository
git clone --depth=1 --branch=v3.9.1 https://github.com/OSGeo/gdal.git
cd gdal

:: Install 'proj' and 'swig' in Conda Environment
conda create --prefix %CD%\.conda -y
conda activate %CD%\.conda
conda install conda-forge::proj conda-forge::swig -y

:: Install 'numpy' in Python Virtual Environment
python -m venv %CD%\.venv
%CD%\.venv\Scripts\activate.bat
python -m pip install pip --upgrade
python -m pip install numpy --upgrade

:: Configure/Build/Install the GDAL project (which will be install to %CD%\.venv)
cmake -S . -B build -D Python_ROOT_DIR=%CD%\.venv -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_APPS=OFF -D GDAL_BUILD_OPTIONAL_DRIVERS=OFF -D OGR_BUILD_OPTIONAL_DRIVERS=OFF -D CMAKE_INSTALL_PREFIX=%CD%\.venv -D CMAKE_PREFIX_PATH=%CD%\.conda\Library
cmake --build build --config Release
cmake --install build --config Release
```

### Versions and provenance

- GDAL: `v3.9.1`

- On Kubuntu 22.04

  - Anaconda:
  - Python:

- On Windows 11

  - Anaconda: `24.1.2`
  - Python: `3.10.7`

### Additional context



```bat
:: Prepare Git Repository
git clone --depth=1 --branch=v3.9.1 https://github.com/OSGeo/gdal.git
cd gdal

:: Install 'proj' and 'swig' in Conda Environment
conda create --prefix %CD%\.conda -y
conda activate %CD%\.conda
conda install conda-forge::proj conda-forge::swig -y

:: Install 'numpy' in Python Virtual Environment
python -m venv %CD%\.venv
%CD%\.venv\Scripts\activate.bat
python -m pip install pip --upgrade
python -m pip install numpy --upgrade

:: Configure/Build/Install the GDAL project (which will be install to %CD%\.venv)
cmake -S . -B build -D Python_ROOT_DIR=%CD%\.venv -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_APPS=OFF -D GDAL_BUILD_OPTIONAL_DRIVERS=OFF -D OGR_BUILD_OPTIONAL_DRIVERS=OFF -D CMAKE_INSTALL_PREFIX=%CD%\.venv -D CMAKE_PREFIX_PATH=%CD%\.conda\Library
cmake --build build --config Release
cmake --install build --config Release
```




```
C:\Users\hwhsu1231\Repo\testing>git clone --depth=1 --branch=v3.9.1 https://github.com/OSGeo/gdal.git
Cloning into 'gdal'...
remote: Enumerating objects: 9658, done.
remote: Counting objects: 100% (9658/9658), done.
remote: Compressing objects: 100% (7066/7066), done.
remote: Total 9658 (delta 3032), reused 5828 (delta 2337), pack-reused 0
Receiving objects: 100% (9658/9658), 35.89 MiB | 1.92 MiB/s, done.
Resolving deltas: 100% (3032/3032), done.
Note: switching to '01ac70772b997ab87d2312e2036eb66faf6b0508'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false


(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>where python
C:\Users\hwhsu1231\Repo\testing\gdal\.venv\Scripts\python.exe
C:\Python\Python310\python.exe
C:\ProgramData\chocolatey\bin\python.exe

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>where pip
C:\Users\hwhsu1231\Repo\testing\gdal\.venv\Scripts\pip.exe
C:\Python\Python310\Scripts\pip.exe

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>python -m pip install pip --upgrade
Requirement already satisfied: pip in c:\users\hwhsu1231\repo\testing\gdal\.venv\lib\site-packages (22.2.2)
Collecting pip
  Using cached pip-24.1.1-py3-none-any.whl (1.8 MB)
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 22.2.2
    Uninstalling pip-22.2.2:
      Successfully uninstalled pip-22.2.2
Successfully installed pip-24.1.1

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>python -m pip uninstall numpy --upgrade -r doc/requirements.txt

Usage:
  C:\Users\hwhsu1231\Repo\testing\gdal\.venv\Scripts\python.exe -m pip uninstall [options] <package> ...
  C:\Users\hwhsu1231\Repo\testing\gdal\.venv\Scripts\python.exe -m pip uninstall [options] -r <requirements file> ...

no such option: --upgrade

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>python -m pip install numpy --upgrade -r doc/requirements.txt
Collecting numpy
  Using cached numpy-2.0.0-cp310-cp310-win_amd64.whl.metadata (60 kB)
Collecting sphinx (from -r doc/requirements.txt (line 3))
  Using cached sphinx-7.3.7-py3-none-any.whl.metadata (6.0 kB)
Collecting breathe (from -r doc/requirements.txt (line 4))
  Using cached breathe-4.35.0-py3-none-any.whl.metadata (1.0 kB)
Collecting sphinx_bootstrap_theme (from -r doc/requirements.txt (line 5))
  Using cached sphinx_bootstrap_theme-0.8.1-py2.py3-none-any.whl.metadata (15 kB)
Collecting sphinxcontrib-bibtex (from -r doc/requirements.txt (line 6))
  Using cached sphinxcontrib_bibtex-2.6.2-py3-none-any.whl.metadata (6.1 kB)
Collecting sphinx_rtd_theme (from -r doc/requirements.txt (line 7))
  Using cached sphinx_rtd_theme-2.0.0-py2.py3-none-any.whl.metadata (4.4 kB)
Collecting recommonmark (from -r doc/requirements.txt (line 8))
  Using cached recommonmark-0.7.1-py2.py3-none-any.whl.metadata (463 bytes)
Collecting sphinx-markdown-tables (from -r doc/requirements.txt (line 9))
  Using cached sphinx_markdown_tables-0.0.17-py3-none-any.whl.metadata (2.2 kB)
Collecting sphinxcontrib-spelling (from -r doc/requirements.txt (line 10))
  Using cached sphinxcontrib_spelling-8.0.0-py3-none-any.whl.metadata (2.9 kB)
Collecting sphinxcontrib-jquery (from -r doc/requirements.txt (line 11))
  Using cached sphinxcontrib_jquery-4.1-py2.py3-none-any.whl.metadata (2.6 kB)
Collecting sphinxcontrib-applehelp (from sphinx->-r doc/requirements.txt (line 3))
  Using cached sphinxcontrib_applehelp-1.0.8-py3-none-any.whl.metadata (2.3 kB)
Collecting sphinxcontrib-devhelp (from sphinx->-r doc/requirements.txt (line 3))
  Using cached sphinxcontrib_devhelp-1.0.6-py3-none-any.whl.metadata (2.3 kB)
Collecting sphinxcontrib-jsmath (from sphinx->-r doc/requirements.txt (line 3))
  Using cached sphinxcontrib_jsmath-1.0.1-py2.py3-none-any.whl.metadata (1.4 kB)
Collecting sphinxcontrib-htmlhelp>=2.0.0 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached sphinxcontrib_htmlhelp-2.0.5-py3-none-any.whl.metadata (2.3 kB)
Collecting sphinxcontrib-serializinghtml>=1.1.9 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached sphinxcontrib_serializinghtml-1.1.10-py3-none-any.whl.metadata (2.4 kB)
Collecting sphinxcontrib-qthelp (from sphinx->-r doc/requirements.txt (line 3))
  Using cached sphinxcontrib_qthelp-1.0.7-py3-none-any.whl.metadata (2.2 kB)
Collecting Jinja2>=3.0 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached jinja2-3.1.4-py3-none-any.whl.metadata (2.6 kB)
Collecting Pygments>=2.14 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached pygments-2.18.0-py3-none-any.whl.metadata (2.5 kB)
Collecting docutils<0.22,>=0.18.1 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached docutils-0.21.2-py3-none-any.whl.metadata (2.8 kB)
Collecting snowballstemmer>=2.0 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached snowballstemmer-2.2.0-py2.py3-none-any.whl.metadata (6.5 kB)
Collecting babel>=2.9 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached Babel-2.15.0-py3-none-any.whl.metadata (1.5 kB)
Collecting alabaster~=0.7.14 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached alabaster-0.7.16-py3-none-any.whl.metadata (2.9 kB)
Collecting imagesize>=1.3 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached imagesize-1.4.1-py2.py3-none-any.whl.metadata (1.5 kB)
Collecting requests>=2.25.0 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached requests-2.32.3-py3-none-any.whl.metadata (4.6 kB)
Collecting packaging>=21.0 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached packaging-24.1-py3-none-any.whl.metadata (3.2 kB)
Collecting tomli>=2 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached tomli-2.0.1-py3-none-any.whl.metadata (8.9 kB)
Collecting colorama>=0.4.5 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached colorama-0.4.6-py2.py3-none-any.whl.metadata (17 kB)
Collecting pybtex>=0.24 (from sphinxcontrib-bibtex->-r doc/requirements.txt (line 6))
  Using cached pybtex-0.24.0-py2.py3-none-any.whl.metadata (2.0 kB)
Collecting pybtex-docutils>=1.0.0 (from sphinxcontrib-bibtex->-r doc/requirements.txt (line 6))
  Using cached pybtex_docutils-1.0.3-py3-none-any.whl.metadata (4.3 kB)
Collecting docutils<0.22,>=0.18.1 (from sphinx->-r doc/requirements.txt (line 3))
  Using cached docutils-0.20.1-py3-none-any.whl.metadata (2.8 kB)
Collecting commonmark>=0.8.1 (from recommonmark->-r doc/requirements.txt (line 8))
  Using cached commonmark-0.9.1-py2.py3-none-any.whl.metadata (5.7 kB)
Collecting markdown>=3.4 (from sphinx-markdown-tables->-r doc/requirements.txt (line 9))
  Using cached Markdown-3.6-py3-none-any.whl.metadata (7.0 kB)
Collecting PyEnchant>=3.1.1 (from sphinxcontrib-spelling->-r doc/requirements.txt (line 10))
  Using cached pyenchant-3.2.2-py3-none-win_amd64.whl.metadata (3.8 kB)
Collecting MarkupSafe>=2.0 (from Jinja2>=3.0->sphinx->-r doc/requirements.txt (line 3))
  Using cached MarkupSafe-2.1.5-cp310-cp310-win_amd64.whl.metadata (3.1 kB)
Collecting PyYAML>=3.01 (from pybtex>=0.24->sphinxcontrib-bibtex->-r doc/requirements.txt (line 6))
  Using cached PyYAML-6.0.1-cp310-cp310-win_amd64.whl.metadata (2.1 kB)
Collecting latexcodec>=1.0.4 (from pybtex>=0.24->sphinxcontrib-bibtex->-r doc/requirements.txt (line 6))
  Using cached latexcodec-3.0.0-py3-none-any.whl.metadata (4.9 kB)
Collecting six (from pybtex>=0.24->sphinxcontrib-bibtex->-r doc/requirements.txt (line 6))
  Using cached six-1.16.0-py2.py3-none-any.whl.metadata (1.8 kB)
Collecting charset-normalizer<4,>=2 (from requests>=2.25.0->sphinx->-r doc/requirements.txt (line 3))
  Using cached charset_normalizer-3.3.2-cp310-cp310-win_amd64.whl.metadata (34 kB)
Collecting idna<4,>=2.5 (from requests>=2.25.0->sphinx->-r doc/requirements.txt (line 3))
  Using cached idna-3.7-py3-none-any.whl.metadata (9.9 kB)
Collecting urllib3<3,>=1.21.1 (from requests>=2.25.0->sphinx->-r doc/requirements.txt (line 3))
  Using cached urllib3-2.2.2-py3-none-any.whl.metadata (6.4 kB)
Collecting certifi>=2017.4.17 (from requests>=2.25.0->sphinx->-r doc/requirements.txt (line 3))
  Using cached certifi-2024.6.2-py3-none-any.whl.metadata (2.2 kB)
Using cached numpy-2.0.0-cp310-cp310-win_amd64.whl (16.5 MB)
Using cached sphinx-7.3.7-py3-none-any.whl (3.3 MB)
Using cached breathe-4.35.0-py3-none-any.whl (92 kB)
Using cached sphinx_bootstrap_theme-0.8.1-py2.py3-none-any.whl (1.2 MB)
Using cached sphinxcontrib_bibtex-2.6.2-py3-none-any.whl (40 kB)
Using cached sphinx_rtd_theme-2.0.0-py2.py3-none-any.whl (2.8 MB)
Using cached recommonmark-0.7.1-py2.py3-none-any.whl (10 kB)
Using cached sphinx_markdown_tables-0.0.17-py3-none-any.whl (28 kB)
Using cached sphinxcontrib_spelling-8.0.0-py3-none-any.whl (16 kB)
Using cached sphinxcontrib_jquery-4.1-py2.py3-none-any.whl (121 kB)
Using cached alabaster-0.7.16-py3-none-any.whl (13 kB)
Using cached Babel-2.15.0-py3-none-any.whl (9.6 MB)
Using cached colorama-0.4.6-py2.py3-none-any.whl (25 kB)
Using cached commonmark-0.9.1-py2.py3-none-any.whl (51 kB)
Using cached docutils-0.20.1-py3-none-any.whl (572 kB)
Using cached imagesize-1.4.1-py2.py3-none-any.whl (8.8 kB)
Using cached jinja2-3.1.4-py3-none-any.whl (133 kB)
Using cached Markdown-3.6-py3-none-any.whl (105 kB)
Using cached packaging-24.1-py3-none-any.whl (53 kB)
Using cached pybtex-0.24.0-py2.py3-none-any.whl (561 kB)
Using cached pybtex_docutils-1.0.3-py3-none-any.whl (6.4 kB)
Using cached pyenchant-3.2.2-py3-none-win_amd64.whl (11.9 MB)
Using cached pygments-2.18.0-py3-none-any.whl (1.2 MB)
Using cached requests-2.32.3-py3-none-any.whl (64 kB)
Using cached snowballstemmer-2.2.0-py2.py3-none-any.whl (93 kB)
Using cached sphinxcontrib_htmlhelp-2.0.5-py3-none-any.whl (99 kB)
Using cached sphinxcontrib_serializinghtml-1.1.10-py3-none-any.whl (92 kB)
Using cached tomli-2.0.1-py3-none-any.whl (12 kB)
Using cached sphinxcontrib_applehelp-1.0.8-py3-none-any.whl (120 kB)
Using cached sphinxcontrib_devhelp-1.0.6-py3-none-any.whl (83 kB)
Using cached sphinxcontrib_jsmath-1.0.1-py2.py3-none-any.whl (5.1 kB)
Using cached sphinxcontrib_qthelp-1.0.7-py3-none-any.whl (89 kB)
Using cached certifi-2024.6.2-py3-none-any.whl (164 kB)
Using cached charset_normalizer-3.3.2-cp310-cp310-win_amd64.whl (100 kB)
Using cached idna-3.7-py3-none-any.whl (66 kB)
Using cached latexcodec-3.0.0-py3-none-any.whl (18 kB)
Using cached MarkupSafe-2.1.5-cp310-cp310-win_amd64.whl (17 kB)
Using cached PyYAML-6.0.1-cp310-cp310-win_amd64.whl (145 kB)
Using cached urllib3-2.2.2-py3-none-any.whl (121 kB)
Using cached six-1.16.0-py2.py3-none-any.whl (11 kB)
Installing collected packages: sphinx_bootstrap_theme, snowballstemmer, commonmark, urllib3, tomli, sphinxcontrib-serializinghtml, sphinxcontrib-qthelp, sphinxcontrib-jsmath, sphinxcontrib-htmlhelp, sphinxcontrib-devhelp, sphinxcontrib-applehelp, six, PyYAML, Pygments, PyEnchant, packaging, numpy, MarkupSafe, markdown, latexcodec, imagesize, idna, docutils, colorama, charset-normalizer, certifi, babel, alabaster, sphinx-markdown-tables, requests, pybtex, Jinja2, sphinx, pybtex-docutils, sphinxcontrib-spelling, sphinxcontrib-jquery, sphinxcontrib-bibtex, recommonmark, breathe, sphinx_rtd_theme
Successfully installed Jinja2-3.1.4 MarkupSafe-2.1.5 PyEnchant-3.2.2 PyYAML-6.0.1 Pygments-2.18.0 alabaster-0.7.16 babel-2.15.0 breathe-4.35.0 certifi-2024.6.2 charset-normalizer-3.3.2 colorama-0.4.6 commonmark-0.9.1 docutils-0.20.1 idna-3.7 imagesize-1.4.1 latexcodec-3.0.0 markdown-3.6 numpy-2.0.0 packaging-24.1 pybtex-0.24.0 pybtex-docutils-1.0.3 recommonmark-0.7.1 requests-2.32.3 six-1.16.0 snowballstemmer-2.2.0 sphinx-7.3.7 sphinx-markdown-tables-0.0.17 sphinx_bootstrap_theme-0.8.1 sphinx_rtd_theme-2.0.0 sphinxcontrib-applehelp-1.0.8 sphinxcontrib-bibtex-2.6.2 sphinxcontrib-devhelp-1.0.6 sphinxcontrib-htmlhelp-2.0.5 sphinxcontrib-jquery-4.1 sphinxcontrib-jsmath-1.0.1 sphinxcontrib-qthelp-1.0.7 sphinxcontrib-serializinghtml-1.1.10 sphinxcontrib-spelling-8.0.0 tomli-2.0.1 urllib3-2.2.2

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>where conda
C:\Users\hwhsu1231\anaconda3\condabin\conda.bat

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>echo %CONDA_PREFIX%
C:\Users\hwhsu1231\Repo\testing\gdal\.conda

(.venv) (C:\Users\hwhsu1231\Repo\testing\gdal\.conda) C:\Users\hwhsu1231\Repo\testing\gdal>conda install conda-forge::proj conda-forge::swig
Channels:
 - defaults
 - conda-forge
Platform: win-64
Collecting package metadata (repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\hwhsu1231\Repo\testing\gdal\.conda

  added / updated specs:
    - conda-forge::proj
    - conda-forge::swig


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    bzip2-1.0.8                |       h2bbff1b_6          90 KB
    ca-certificates-2024.3.11  |       haa95532_0         128 KB
    krb5-1.21.3                |       hdf4eb48_0         695 KB  conda-forge
    sqlite-3.45.3              |       h2bbff1b_0         973 KB
    ucrt-10.0.20348.0          |       haa95532_0         531 KB
    vc-14.2                    |       h2eaa2aa_1          10 KB
    xz-5.4.6                   |       h8cc25b3_1         609 KB
    ------------------------------------------------------------
                                           Total:         3.0 MB

The following NEW packages will be INSTALLED:

  bzip2              pkgs/main/win-64::bzip2-1.0.8-h2bbff1b_6
  ca-certificates    pkgs/main/win-64::ca-certificates-2024.3.11-haa95532_0
  krb5               conda-forge/win-64::krb5-1.21.3-hdf4eb48_0
  lerc               conda-forge/win-64::lerc-4.0.0-h63175ca_0
  libcurl            conda-forge/win-64::libcurl-8.8.0-hd5e4a3a_0
  libdeflate         conda-forge/win-64::libdeflate-1.20-hcfcfb64_0
  libjpeg-turbo      conda-forge/win-64::libjpeg-turbo-3.0.0-hcfcfb64_1
  libsqlite          conda-forge/win-64::libsqlite-3.46.0-h2466b09_0
  libssh2            conda-forge/win-64::libssh2-1.11.0-h7dfc565_0
  libtiff            conda-forge/win-64::libtiff-4.6.0-hddb2be6_3
  libzlib            conda-forge/win-64::libzlib-1.3.1-h2466b09_1
  openssl            conda-forge/win-64::openssl-3.3.1-h2466b09_1
  pcre2              conda-forge/win-64::pcre2-10.44-h3d7b363_0
  proj               conda-forge/win-64::proj-9.4.1-hd9569ee_0
  sqlite             pkgs/main/win-64::sqlite-3.45.3-h2bbff1b_0
  swig               conda-forge/win-64::swig-4.2.1-h51fbe9b_1
  ucrt               pkgs/main/win-64::ucrt-10.0.20348.0-haa95532_0
  vc                 pkgs/main/win-64::vc-14.2-h2eaa2aa_1
  vc14_runtime       conda-forge/win-64::vc14_runtime-14.40.33810-ha82c5b3_20
  vs2015_runtime     conda-forge/win-64::vs2015_runtime-14.40.33810-h3bf8584_20
  xz                 pkgs/main/win-64::xz-5.4.6-h8cc25b3_1
  zstd               conda-forge/win-64::zstd-1.5.6-h0ea2cb4_0


Proceed ([y]/n)? y


Downloading and Extracting Packages:

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>echo %PATH%
C:\Users\hwhsu1231\Repo\testing\gdal\.venv\Scripts;C:\Users\hwhsu1231\Repo\testing\gdal\.conda;C:\Users\hwhsu1231\Repo\testing\gdal\.conda\Library\mingw-w64\bin;C:\Users\hwhsu1231\Repo\testing\gdal\.conda\Library\usr\bin;C:\Users\hwhsu1231\Repo\testing\gdal\.conda\Library\bin;C:\Users\hwhsu1231\Repo\testing\gdal\.conda\Scripts;C:\Users\hwhsu1231\Repo\testing\gdal\.conda\bin;C:\Program Files\Microsoft\jdk-11.0.16.101-hotspot\bin;C:\Python\Python310\Scripts;C:\Python\Python310;C:\Windows;C:\Windows\System32;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Windows\System32\OpenSSH;C:\Program Files (x86)\GnuWin32\bin;C:\Program Files (x86)\Dia\bin;C:\Program Files (x86)\Mscgen;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build;C:\Program Files\Intel\WiFi\bin;C:\Program Files\Common Files\Oracle\Java\javapath;C:\Program Files\MySQL\MySQL Shell 8.0\bin;C:\Program Files\MySQL\MySQL Server 8.0\bin;C:\Program Files\Tcl86\bin;C:\Program Files\Meson;C:\Users\hwhsu1231\AppData\Roaming\npm;C:\Program Files\Common Files\Intel\WirelessCommon;C:\Program Files\NASM;C:\Program Files\Typora;C:\Program Files\SlikSvn\bin;C:\Program Files\OpenSSL-Win64\bin;C:\Program Files\Pandoc;C:\Program Files\gsudo\Current;C:\Program Files\Java\jdk1.8.0_211\bin;C:\Program Files\Microsoft VS Code\bin;C:\Program Files\Git\cmd;C:\Program Files\WinGet\Links;C:\Program Files\CMake\bin;C:\Program Files\gettext-iconv\bin;C:\Program Files\GitHub CLI;C:\Program Files\nodejs;C:\Program Files\Conan\conan;C:\Program Files\doxygen\bin;C:\Program Files\Graphviz\bin;C:\Program Files\SDCC\bin;C:\Strawberry\c\bin;C:\Strawberry\perl\site\bin;C:\Strawberry\perl\bin;C:\ProgramData\chocolatey\bin;C:\Ruby32-x64\bin;C:\Users\hwhsu1231\AppData\Local\Microsoft\WindowsApps;C:\Users\hwhsu1231\.dotnet\tools;C:\Users\hwhsu1231\AppData\Local\JetBrains\Toolbox\scripts;C:\Users\hwhsu1231\.dotnet\tools;C:\Program Files\dotnet;C:\ProgramData\chocolatey\lib\mingw\tools\install\mingw64\bin;C:\Users\hwhsu1231\go\bin;C:\Users\hwhsu1231\AppData\Roaming\Pub\Cache\bin;C:\Users\hwhsu1231\AppData\Roaming\npm;C:\Users\hwhsu1231\anaconda3\condabin;C:\Test;.

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>cmake -S . -B ./build -D Python_ROOT_DIR=%CD%\.venv -D CMAKE_BUIL
D_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_APPS=OFF -D GDAL_BUILD_OPTIONAL_DRIVERS=OFF -D OGR_BUILD_OPTIONAL_DRIVERS=OFF -D CMAKE_INSTALL_PREFIX=%CD%\.
venv
-- Building for: Visual Studio 17 2022
-- Selecting Windows SDK version 10.0.22000.0 to target Windows 10.0.22631.
-- The C compiler identification is MSVC 19.35.32215.0
-- The CXX compiler identification is MSVC 19.35.32215.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Performing Test test_AVX
-- Performing Test test_AVX - Success
-- Performing Test test_AVX2
-- Performing Test test_AVX2 - Success
-- Found SWIG: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/bin/swig.exe (found version "4.2.1")
-- Found Python: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/Scripts/python.exe (found suitable version "3.10.7", minimum required is "3.8") found components: Interpreter Development NumPy Development.Module Development.Embed
-- Looking for vsnprintf
-- Looking for vsnprintf - not found
-- Looking for getcwd
-- Looking for getcwd - found
-- Looking for fcntl.h
-- Looking for fcntl.h - found
-- Looking for unistd.h
-- Looking for unistd.h - not found
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for locale.h
-- Looking for locale.h - found
-- Looking for xlocale.h
-- Looking for xlocale.h - not found
-- Looking for direct.h
-- Looking for direct.h - found
-- Looking for dlfcn.h
-- Looking for dlfcn.h - not found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of int
-- Check size of int - done
-- Check size of unsigned long
-- Check size of unsigned long - done
-- Check size of long int
-- Check size of long int - done
-- Check size of void*
-- Check size of void* - done
-- Check size of size_t
-- Check size of size_t - done
-- Looking for ctime_r
-- Looking for ctime_r - not found
-- Looking for gmtime_r
-- Looking for gmtime_r - not found
-- Looking for localtime_r
-- Looking for localtime_r - not found
-- Looking for C++ include atlbase.h
-- Looking for C++ include atlbase.h - found
-- GDAL_VERSION          = 3.9.1dev
-- GDAL_ABI_FULL_VERSION = 39
-- GDAL_SOVERSION        =
-- Found ODBC: odbc32.lib
-- Could NOT find ODBCCPP (missing: ODBCCPP_LIBRARY ODBCCPP_INCLUDE_DIR)
-- Could NOT find MSSQL_NCLI (missing: MSSQL_NCLI_LIBRARY MSSQL_NCLI_INCLUDE_DIR MSSQL_NCLI_VERSION)
-- Could NOT find MSSQL_ODBC (missing: MSSQL_ODBC_LIBRARY MSSQL_ODBC_INCLUDE_DIR MSSQL_ODBC_VERSION)
-- Could NOT find MySQL (missing: MYSQL_LIBRARY MYSQL_INCLUDE_DIR)
-- Could NOT find CURL (missing: CURL_LIBRARY CURL_INCLUDE_DIR) (Required is at least version "7.68")
-- Could NOT find Iconv (missing: Iconv_LIBRARY Iconv_CHARSET_LIBRARY Iconv_INCLUDE_DIR)
-- Could NOT find LibXml2 (missing: LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR)
-- Could NOT find EXPAT (missing: EXPAT_DIR)
-- Could NOT find EXPAT (missing: EXPAT_LIBRARY EXPAT_INCLUDE_DIR)
-- Failed to find XercesC (missing: XercesC_LIBRARY XercesC_INCLUDE_DIR XercesC_VERSION)
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Could NOT find Deflate (missing: Deflate_LIBRARY Deflate_INCLUDE_DIR)
-- Found OpenSSL: optimized;C:/Program Files/OpenSSL-Win64/lib/VC/libcrypto64MD.lib;debug;C:/Program Files/OpenSSL-Win64/lib/VC/libcrypto64MDd.lib (found version "3.0.8") found components: SSL Crypto
-- Could NOT find CryptoPP (missing: CRYPTOPP_LIBRARY CRYPTOPP_TEST_KNOWNBUG CRYPTOPP_INCLUDE_DIR)
-- Could NOT find SQLite3 (missing: SQLite3_LIBRARY SQLite3_INCLUDE_DIR)
CMake Warning at cmake/helpers/CheckDependentLibraries.cmake:390 (find_package):
  Found package configuration file:

    C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/cmake/proj/proj-config.cmake

  but it set PROJ_FOUND to FALSE so package "PROJ" is considered to be NOT
  FOUND.  Reason given by package:

  PROJ could not be found because dependency SQLite3 could not be found.

Call Stack (most recent call first):
  gdal.cmake:266 (include)
  CMakeLists.txt:240 (include)


CMake Error at C:/Program Files/CMake/share/cmake-3.29/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
  Could NOT find PROJ (missing: PROJ_LIBRARY PROJ_INCLUDE_DIR)
Call Stack (most recent call first):
  C:/Program Files/CMake/share/cmake-3.29/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
  cmake/modules/packages/FindPROJ.cmake:57 (find_package_handle_standard_args)
  cmake/helpers/CheckDependentLibraries.cmake:399 (find_package)
  gdal.cmake:266 (include)
  CMakeLists.txt:240 (include)


-- Configuring incomplete, errors occurred!

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>rmdir /s/q build

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>cmake -S . -B ./build -D Python_ROOT_DIR=%CD%\.venv -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_APPS=OFF -D GDAL_BUILD_OPTIONAL_DRIVERS=OFF -D OGR_BUILD_OPTIONAL_DRIVERS=OFF -D CMAKE_INSTALL_PREFIX=%CD%\.venv -D CMAKE_PREFIX_PATH=%CD%\.conda\Library
-- Building for: Visual Studio 17 2022
-- Selecting Windows SDK version 10.0.22000.0 to target Windows 10.0.22631.
-- The C compiler identification is MSVC 19.35.32215.0
-- The CXX compiler identification is MSVC 19.35.32215.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Performing Test test_AVX
-- Performing Test test_AVX - Success
-- Performing Test test_AVX2
-- Performing Test test_AVX2 - Success
-- Found SWIG: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/bin/swig.exe (found version "4.2.1")
-- Found Python: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/Scripts/python.exe (found suitable version "3.10.7", minimum required is "3.8") found components: Interpreter Development NumPy Development.Module Development.Embed
-- Looking for vsnprintf
-- Looking for vsnprintf - not found
-- Looking for getcwd
-- Looking for getcwd - found
-- Looking for fcntl.h
-- Looking for fcntl.h - found
-- Looking for unistd.h
-- Looking for unistd.h - not found
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for locale.h
-- Looking for locale.h - found
-- Looking for xlocale.h
-- Looking for xlocale.h - not found
-- Looking for direct.h
-- Looking for direct.h - found
-- Looking for dlfcn.h
-- Looking for dlfcn.h - not found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of int
-- Check size of int - done
-- Check size of unsigned long
-- Check size of unsigned long - done
-- Check size of long int
-- Check size of long int - done
-- Check size of void*
-- Check size of void* - done
-- Check size of size_t
-- Check size of size_t - done
-- Looking for ctime_r
-- Looking for ctime_r - not found
-- Looking for gmtime_r
-- Looking for gmtime_r - not found
-- Looking for localtime_r
-- Looking for localtime_r - not found
-- Looking for C++ include atlbase.h
-- Looking for C++ include atlbase.h - found
-- GDAL_VERSION          = 3.9.1dev
-- GDAL_ABI_FULL_VERSION = 39
-- GDAL_SOVERSION        =
-- Found ODBC: odbc32.lib
-- Could NOT find ODBCCPP (missing: ODBCCPP_LIBRARY ODBCCPP_INCLUDE_DIR)
-- Could NOT find MSSQL_NCLI (missing: MSSQL_NCLI_LIBRARY MSSQL_NCLI_INCLUDE_DIR MSSQL_NCLI_VERSION)
-- Could NOT find MSSQL_ODBC (missing: MSSQL_ODBC_LIBRARY MSSQL_ODBC_INCLUDE_DIR MSSQL_ODBC_VERSION)
-- Could NOT find MySQL (missing: MYSQL_LIBRARY MYSQL_INCLUDE_DIR)
-- Found CURL: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/libcurl.lib (found suitable version "8.8.0", minimum required is "7.68")
-- Could NOT find Iconv (missing: Iconv_LIBRARY Iconv_CHARSET_LIBRARY Iconv_INCLUDE_DIR)
-- Could NOT find LibXml2 (missing: LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR)
-- Could NOT find EXPAT (missing: EXPAT_DIR)
-- Could NOT find EXPAT (missing: EXPAT_LIBRARY EXPAT_INCLUDE_DIR)
-- Failed to find XercesC (missing: XercesC_LIBRARY XercesC_INCLUDE_DIR XercesC_VERSION)
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Found Deflate: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/deflate.lib
-- Found OpenSSL: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/libcrypto.lib (found version "3.3.1") found components: SSL Crypto
-- Could NOT find CryptoPP (missing: CRYPTOPP_LIBRARY CRYPTOPP_TEST_KNOWNBUG CRYPTOPP_INCLUDE_DIR)
-- Looking for sqlite3_mutex_alloc
-- Looking for sqlite3_mutex_alloc - found
-- Looking for sqlite3_column_table_name
-- Looking for sqlite3_column_table_name - found
-- Looking for sqlite3_rtree_query_callback
-- Looking for sqlite3_rtree_query_callback - found
-- Looking for sqlite3_load_extension
-- Looking for sqlite3_load_extension - found
-- Looking for sqlite3_progress_handler
-- Looking for sqlite3_progress_handler - found
-- Performing Test SQLite3_HAS_NON_DEPRECATED_AUTO_EXTENSION
-- Performing Test SQLite3_HAS_NON_DEPRECATED_AUTO_EXTENSION - Success
-- Found SQLite3: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/sqlite3.lib (found version "3.45.3")
-- Found TIFF: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/cmake/tiff (found version "4.6.0")
-- Found CURL: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/libcurl.lib (found version "8.8.0")
-- Could NOT find SFCGAL (missing: SFCGAL_LIBRARY SFCGAL_INCLUDE_DIR)
-- Could NOT find GeoTIFF (missing: GeoTIFF_DIR)
-- Could NOT find GeoTIFF (missing: GEOTIFF_LIBRARY GEOTIFF_INCLUDE_DIR)
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR)
-- Could NOT find PNG (missing: PNG_LIBRARY PNG_PNG_INCLUDE_DIR) (Required is at least version "1.6")
-- Found JPEG: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/jpeg.lib (found version "80")
-- Performing Test HAVE_JPEGTURBO_DUAL_MODE_8_12
-- Performing Test HAVE_JPEGTURBO_DUAL_MODE_8_12 - Success
-- Could NOT find GIF (missing: GIF_LIBRARY GIF_INCLUDE_DIR)
-- Could NOT find JSONC (missing: JSONC_DIR)
-- Could NOT find JSONC (missing: JSONC_LIBRARY JSONC_INCLUDE_DIR)
-- Could NOT find OpenCAD (missing: OPENCAD_LIBRARY OPENCAD_INCLUDE_DIR)
-- Could NOT find QHULL (missing: QHULL_LIBRARY QHULL_INCLUDE_DIR)
-- Found LERC: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/Lerc.lib
-- Could NOT find BRUNSLI (missing: BRUNSLI_ENC_LIB BRUNSLI_DEC_LIB BRUNSLI_INCLUDE_DIR)
-- Could NOT find libQB3 (missing: libQB3_DIR)
-- Could NOT find Shapelib (missing: Shapelib_INCLUDE_DIR Shapelib_LIBRARY)
-- Found PCRE2: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/pcre2-8.lib
-- Could NOT find SPATIALITE (missing: SPATIALITE_LIBRARY SPATIALITE_INCLUDE_DIR) (Required is at least version "4.1.2")
-- Could NOT find RASTERLITE2 (missing: RASTERLITE2_LIBRARY RASTERLITE2_INCLUDE_DIR) (Required is at least version "1.1.0")
-- Could NOT find LibKML (missing: LIBKML_BASE_LIBRARY LIBKML_INCLUDE_DIR LIBKML_DOM_LIBRARY LIBKML_ENGINE_LIBRARY)
-- Could NOT find HDF5 (missing: HDF5_LIBRARIES HDF5_INCLUDE_DIRS C) (found version "")
-- Could NOT find WebP (missing: WEBP_LIBRARY WEBP_INCLUDE_DIR)
-- Could NOT find FreeXL (missing: FREEXL_LIBRARY FREEXL_INCLUDE_DIR)
-- Could NOT find MRSID (missing: MRSID_LIBRARY MRSID_INCLUDE_DIR)
-- Could NOT find Armadillo (missing: ARMADILLO_INCLUDE_DIR)
-- Could NOT find GEOS (missing: GEOS_DIR)
-- Could NOT find GEOS (missing: GEOS_LIBRARY GEOS_INCLUDE_DIR) (Required is at least version "3.8")
-- Could NOT find HDF4 (missing: HDF4_df_LIBRARY HDF4_mfhdf_LIBRARY HDF4_INCLUDE_DIR)
-- Could NOT find ECW (missing: ECW_LIBRARY ECWnet_LIBRARY ECWC_LIBRARY NCSUtil_LIBRARY ECW_INCLUDE_DIR)
-- Could NOT find NetCDF (missing: NetCDF_DIR)
-- Could NOT find NetCDF (missing: NETCDF_LIBRARY NETCDF_INCLUDE_DIR) (Required is at least version "4.7")
-- Could NOT find OGDI (missing: OGDI_LIBRARY OGDI_INCLUDE_DIRS)
-- Looking for CL_VERSION_3_0
-- Looking for CL_VERSION_3_0 - not found
-- Looking for CL_VERSION_2_2
-- Looking for CL_VERSION_2_2 - not found
-- Looking for CL_VERSION_2_1
-- Looking for CL_VERSION_2_1 - not found
-- Looking for CL_VERSION_2_0
-- Looking for CL_VERSION_2_0 - not found
-- Looking for CL_VERSION_1_2
-- Looking for CL_VERSION_1_2 - not found
-- Looking for CL_VERSION_1_1
-- Looking for CL_VERSION_1_1 - not found
-- Looking for CL_VERSION_1_0
-- Looking for CL_VERSION_1_0 - not found
-- Could NOT find OpenCL (missing: OpenCL_LIBRARY OpenCL_INCLUDE_DIR)
-- Found PostgreSQL: C:/Program Files/PostgreSQL/14/lib/libpq.lib (found version "14.5")
-- Could NOT find FYBA (missing: FYBA_FYBA_LIBRARY FYBA_FYGM_LIBRARY FYBA_FYUT_LIBRARY FYBA_INCLUDE_DIR)
-- Found LibLZMA: C:/Users/hwhsu1231/Repo/testing/gdal/.conda/Library/lib/liblzma.lib (found version "5.4.6")
-- Could NOT find LZ4 (missing: LZ4_LIBRARY LZ4_INCLUDE_DIR LZ4_VERSION)
-- Could NOT find Blosc (missing: BLOSC_LIBRARY BLOSC_INCLUDE_DIR)
-- Could NOT find basisu (missing: basisu_DIR)
-- Could NOT find IDB (missing: IDB_INCLUDE_DIR IDB_IFCPP_LIBRARY IDB_IFDMI_LIBRARY IDB_IFSQL_LIBRARY IDB_IFCLI_LIBRARY)
-- Could NOT find rdb (missing: rdb_DIR)
-- Could NOT find TileDB (missing: TileDB_DIR)
-- Could NOT find OpenEXR (missing: OpenEXR_LIBRARY OpenEXR_UTIL_LIBRARY OpenEXR_HALF_LIBRARY OpenEXR_IEX_LIBRARY OpenEXR_INCLUDE_DIR Imath_INCLUDE_DIR)
-- Could NOT find MONGOCXX (missing: MONGOCXX_INCLUDE_DIR BSONCXX_INCLUDE_DIR MONGOCXX_LIBRARY BSONCXX_LIBRARY)
-- Could NOT find OpenJPEG (missing: OPENJPEG_LIBRARY OPENJPEG_INCLUDE_DIR) (Required is at least version "2.3.1")
-- Found JNI: C:/Program Files/Java/jdk1.8.0_211/include  found components: AWT JVM
-- Could NOT find HDFS (missing: HDFS_LIBRARY HDFS_INCLUDE_DIR)
-- Could NOT find Poppler (missing: Poppler_LIBRARY Poppler_INCLUDE_DIR) (Required is at least version "0.86")
-- Could NOT find Podofo (missing: PODOFO_LIBRARY PODOFO_INCLUDE_DIR)
-- Could NOT find Oracle (missing: Oracle_LIBRARY Oracle_INCLUDE_DIR)
-- Could NOT find FileGDB (missing: FileGDB_LIBRARY FileGDB_INCLUDE_DIR)
-- Could NOT find KDU (missing: KDU_INCLUDE_DIR KDU_LIBRARY KDU_AUX_LIBRARY) (found version "")
-- Could NOT find LURATECH (missing: LURATECH_LIBRARY LURATECH_INCLUDE_DIR)
-- Could NOT find Arrow (missing: Arrow_DIR)
-- Found Java: C:/Program Files/Java/jdk1.8.0_211/bin/java.exe (found version "1.8.0.211") found components: Runtime Development
-- Downloading nuget...
nuget.exe downloaded and saved to C:/Users/hwhsu1231/Repo/testing/gdal/build/tools/nuget.exe
-- Found .NET toolchain: C:/Program Files/dotnet/dotnet.exe (version 7.0.202)
-- Found CSharp: .NET
-- Performing Test COMPILER_SUPPORTS_CXX17
-- Performing Test COMPILER_SUPPORTS_CXX17 - Failed
-- Found BISON: C:/ProgramData/chocolatey/bin/win_bison.exe (found version "3.7.4")
-- Copying content of C:/Users/hwhsu1231/Repo/testing/gdal/swig/python/gdal-utils to C:/Users/hwhsu1231/Repo/testing/gdal/build/swig/python/gdal-utils
-- Copying content of C:/Users/hwhsu1231/Repo/testing/gdal/swig/python/gdal-utils/osgeo_utils to C:/Users/hwhsu1231/Repo/testing/gdal/build/swig/python/osgeo_utils
-- Available SDKS: 3.1;5.0;7.0
-- Requested Library DotNet SDK Level: 6.0
-- Requested Application DotNet SDK Level: 6.0
-- The Requested DotNet SDK was not found. C# Bindings will not be built
-- Found Doxygen: C:/Program Files/doxygen/bin/doxygen.exe (found version "1.9.7") found components: doxygen dot
--   Target system:             Windows
--   Installation directory:    C:/Users/hwhsu1231/Repo/testing/gdal/.venv
--   C++ Compiler type:         MSVC
--   C compile command line:     C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe
--   C++ compile command line:   C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe
--
--   CMAKE_C_FLAGS:              /DWIN32 /D_WINDOWS
--   CMAKE_CXX_FLAGS:              /DWIN32 /D_WINDOWS /EHsc
--   CMAKE_CXX11_STANDARD_COMPILE_OPTION:
--   CMAKE_CXX11_EXTENSION_COMPILE_OPTION:
--   CMAKE_EXE_LINKER_FLAGS:              /machine:x64
--   CMAKE_MODULE_LINKER_FLAGS:              /machine:x64
--   CMAKE_SHARED_LINKER_FLAGS:              /machine:x64
--   CMAKE_STATIC_LINKER_FLAGS:              /machine:x64
--   CMAKE_C_FLAGS_DEBUG:              /Ob0 /Od /RTC1
--   CMAKE_CXX_FLAGS_DEBUG:              /Ob0 /Od /RTC1
--   CMAKE_EXE_LINKER_FLAGS_DEBUG:              /debug /INCREMENTAL
--   CMAKE_MODULE_LINKER_FLAGS_DEBUG:              /debug /INCREMENTAL
--   CMAKE_SHARED_LINKER_FLAGS_DEBUG:              /debug /INCREMENTAL
--   CMAKE_STATIC_LINKER_FLAGS_DEBUG:
--   CMAKE_C_FLAGS_RELEASE:              /O2 /Ob2 /DNDEBUG
--   CMAKE_CXX_FLAGS_RELEASE:              /O2 /Ob2 /DNDEBUG
--   CMAKE_EXE_LINKER_FLAGS_RELEASE:              /INCREMENTAL:NO
--   CMAKE_MODULE_LINKER_FLAGS_RELEASE:              /INCREMENTAL:NO
--   CMAKE_SHARED_LINKER_FLAGS_RELEASE:              /INCREMENTAL:NO
--   CMAKE_STATIC_LINKER_FLAGS_RELEASE:
--   CMAKE_C_FLAGS_MINSIZEREL:              /O1 /Ob1 /DNDEBUG
--   CMAKE_CXX_FLAGS_MINSIZEREL:              /O1 /Ob1 /DNDEBUG
--   CMAKE_EXE_LINKER_FLAGS_MINSIZEREL:              /INCREMENTAL:NO
--   CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL:              /INCREMENTAL:NO
--   CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL:              /INCREMENTAL:NO
--   CMAKE_STATIC_LINKER_FLAGS_MINSIZEREL:
--   CMAKE_C_FLAGS_RELWITHDEBINFO:              /O2 /Ob1 /DNDEBUG
--   CMAKE_CXX_FLAGS_RELWITHDEBINFO:              /O2 /Ob1 /DNDEBUG
--   CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO:              /debug /INCREMENTAL
--   CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO:              /debug /INCREMENTAL
--   CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO:              /debug /INCREMENTAL
--   CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO:
--
-- Enabled drivers and features and found dependency packages
-- The following features have been enabled:

 * gdal_GTIFF, GeoTIFF image format
 * gdal_MEM, Read/write data in Memory
 * gdal_VRT, Virtual GDAL Datasets
 * gdal_HFA, Erdas Imagine .img
 * ogr_MEM, Read/write driver for MEMORY virtual files
 * ogr_GEOJSON, GeoJSON/ESRIJSON/TopoJSON driver
 * ogr_TAB, MapInfo TAB and MIF/MID
 * ogr_SHAPE, ESRI shape-file
 * ogr_KML, KML
 * ogr_VRT, VRT - Virtual Format

-- The following OPTIONAL packages have been found:

 * Python (required version >= 3.8)
   SWIG_PYTHON: Python binding
 * ODBC
   Enable DB support through ODBC
 * Deflate
   Enable libdeflate compression library (complement to ZLib)
 * OpenSSL
   Use OpenSSL library
 * PROJ
 * ZSTD
   ZSTD compression library
 * PCRE2
   Enable PCRE2 support for sqlite3
 * PostgreSQL
 * LibLZMA
   LZMA compression
 * JNI
   SWIG_JAVA: Java binding
 * Java
 * Dotnet
 * CSharp
   SWIG_CSharp: CSharp binding
 * BISON
 * Doxygen

-- The following RECOMMENDED packages have been found:

 * CURL
   Enable drivers to use web API
 * JPEG
   JPEG compression library (external)
 * LERC
   Enable LERC (external)

-- The following REQUIRED packages have been found:

 * SWIG, Software development tool that connects programs written in C and C++ with a variety of high-level programming languages., <http://swig.org/>

-- The following features have been disabled:

 * gdal_JPEG, JPEG image format
 * gdal_RAW, Raw formats:EOSAT FAST Format, FARSITE LCP and Vexcel MFF2 Image
 * gdal_SDTS, SDTS translator
 * gdal_NITF, National Imagery Transmission Format
 * gdal_GXF, GXF
 * gdal_AAIGRID, Arc/Info ASCII Grid Format.
 * gdal_CEOS, CEOS translator
 * gdal_SAR_CEOS, ASI CEOS translator
 * gdal_XPM, XPM image format
 * gdal_DTED, Military Elevation Data
 * gdal_JDEM, JDEM driver
 * gdal_ENVISAT, Envisat
 * gdal_ELAS, Earth Resources Laboratory Applications Software
 * gdal_FIT, FIT driver
 * gdal_L1B, NOAA Polar Orbiter Level 1b Data Set (AVHRR)
 * gdal_RS2, RS2 -- RadarSat 2 XML Product
 * gdal_ILWIS, Raster Map
 * gdal_RMF, RMF --- Raster Matrix Format
 * gdal_LEVELLER, Daylon Leveller heightfield
 * gdal_SGI, SGI Image driver
 * gdal_SRTMHGT, SRTM HGT File Read Support
 * gdal_IDRISI, Idrisi Raster Format
 * gdal_GSG, Implements the Golden Software Surfer 7 Binary Grid Format.
 * gdal_ERS, ERMapper .ERS
 * gdal_JAXAPALSAR, JAXA PALSAR Level 1.1 and Level 1.5 processed products support
 * gdal_DIMAP, SPOT Dimap Driver
 * gdal_GFF, Ground-based SAR Applitcations Testbed File Format driver
 * gdal_COSAR, COSAR -- TerraSAR-X Complex SAR Data Product
 * gdal_PDS, USGS Astrogeology ISIS Cube (Version 2)
 * gdal_ADRG, ADRG reader and ASRP/USRP Reader
 * gdal_COASP, DRDC Configurable Airborne SAR Processor (COASP) data reader
 * gdal_TSX, TerraSAR-X XML Product Support
 * gdal_TERRAGEN, Terragen&trade; Terrain File
 * gdal_BLX, Magellan BLX Topo File Format
 * gdal_MSGN, Meteosat Second Generation (MSG) Native Archive Format (.nat)
 * gdal_TIL, EarthWatch .TIL Driver
 * gdal_R, R Object Data Store
 * gdal_NORTHWOOD, NWT_GRD/NWT_GRC -- Northwood/Vertical Mapper File Format
 * gdal_SAGA, SAGA GIS Binary Driver
 * gdal_XYZ, ASCII Gridded XYZ
 * gdal_HEIF, HEIF
 * gdal_ESRIC, ESRI compact cache
 * gdal_HF2, HF2/HFZ heightfield raster
 * gdal_KMLSUPEROVERLAY
 * gdal_CTG, CTG driver
 * gdal_ZMAP, ZMAP
 * gdal_NGSGEOID, NOAA NGS Geoid Height Grids
 * gdal_IRIS, IRIS driver
 * gdal_MAP, OziExplorer .MAP
 * gdal_CALS, CALS type 1
 * gdal_SAFE, SAFE -- Sentinel-1 SAFE XML Product
 * gdal_SENTINEL2, Driver for Sentinel-2 Level-1B, Level-1C and Level-2A products.
 * gdal_PRF, PHOTOMOD Raster File
 * gdal_MRF, Meta raster format
 * gdal_WMTS, OGC Web Map Tile Service
 * gdal_GRIB, WMO General Regularly-distributed Information in Binary form
 * gdal_BMP, Microsoft Windows Device Independent Bitmap
 * gdal_TGA, TGA
 * gdal_STACTA, STACTA
 * gdal_BSB, Maptech/NOAA BSB Nautical Chart Format
 * gdal_AIGRID, Arc/Info Binary Grid Format
 * gdal_USGSDEM, USGS ASCII DEM (and CDED)
 * gdal_AIRSAR, AirSAR Polarimetric Format
 * gdal_OZI, OZF2/OZFX3 raster
 * gdal_PCIDSK, PCI Geomatics Database File
 * gdal_SIGDEM, Scaled Integer Gridded DEM .sigdem Driver
 * gdal_MSG, Meteosat Second Generation
 * gdal_RIK, RIK -- Swedish Grid Maps
 * gdal_STACIT, STACIT
 * gdal_PDF, Geospatial PDF
 * gdal_PNG, PNG image format
 * gdal_GIF, Graphics Interchange Format
 * gdal_WCS, OGC Web Coverage Service
 * gdal_HTTP, HTTP driver
 * gdal_NETCDF, NetCDF network Common Data Form
 * gdal_ZARR, ZARR
 * gdal_DAAS, Airbus DS Intelligence Data As A Service(DAAS)
 * gdal_EEDA, Earth Engine Data API
 * gdal_FITS, FITS Driver
 * gdal_HDF5, Hierarchical Data Format Release 5 (HDF5)
 * gdal_PLMOSAIC, PLMosaic (Planet Labs Mosaics API)
 * gdal_WMS, Web Map Services
 * gdal_OGCAPI, OGCAPI
 * gdal_GTA, Generic Tagged Arrays
 * gdal_WEBP, WebP
 * gdal_HDF4, Hierarchical Data Format Release 4 (HDF4)
 * gdal_RASTERLITE, Rasterlite - Rasters in SQLite DB
 * gdal_MBTILES, MBTile
 * gdal_POSTGISRASTER, PostGIS Raster driver
 * gdal_DDS, DirectDraw Surface
 * gdal_KEA, Kea
 * gdal_JP2OPENJPEG, JPEG2000 driver based on OpenJPEG library
 * gdal_TILEDB, TileDB tiledb.io
 * gdal_EXR, EXR support via OpenEXR library
 * gdal_PCRASTER, PCRaster CSF 2.0 raster file driver
 * gdal_RDB, RIEGL RDB Map Pixel (.mpx) driver
 * gdal_JPEGXL, JPEG-XL
 * gdal_BASISU_KTX2, Basis Universal and KTX2 texture formats
 * gdal_JP2KAK, JPEG-2000 (based on Kakadu)
 * gdal_JPIPKAK, JPIP Streaming
 * gdal_JP2LURA, JPEG-2000 (based on Luratech)
 * gdal_SDE, ESRI ArcSDE Raster
 * gdal_MRSID, Multi-resolution Seamless Image Database
 * gdal_GEOR, Oracle Spatial GeoRaster
 * gdal_ECW, ERDAS JPEG2000 (.jp2)
 * ogr_AVC, AVC
 * ogr_GML, GML
 * ogr_CSV, CSV
 * ogr_DGN, DGN
 * ogr_GMT, GMT
 * ogr_NTF, NTF
 * ogr_S57, S57
 * ogr_TIGER, U.S. Census TIGER/Line
 * ogr_GEOCONCEPT, GEOCONCEPT
 * ogr_GEORSS, GEORSS
 * ogr_DXF, DXF
 * ogr_PGDUMP, PGDump
 * ogr_GPSBABEL, GPSBABEL
 * ogr_EDIGEO, EDIGEO
 * ogr_SXF, SXF
 * ogr_OPENFILEGDB, OPENFILEGDB
 * ogr_WASP, WAsP .map format
 * ogr_SELAFIN, OSELAFIN
 * ogr_JML, JML
 * ogr_VDV, VDV-451/VDV-452/INTREST Data Format
 * ogr_FLATGEOBUF, FlatGeobuf
 * ogr_MAPML, MapML
 * ogr_JSONFG, JSONFG
 * ogr_MIRAMON, MiraMonVector
 * ogr_SDTS, SDTS
 * ogr_GPX, GPX - GPS Exchange Format
 * ogr_GMLAS, GMLAS
 * ogr_SVG, Scalable Vector Graphics
 * ogr_CSW, CSW
 * ogr_DWG, DWG
 * ogr_FILEGDB, FileGDB
 * ogr_LIBKML, LibKML
 * ogr_NAS, NAS/ALKIS
 * ogr_PLSCENES, PLSCENES
 * ogr_SOSI, SOSI:Systematic Organization of Spatial Information
 * ogr_WFS, OGC WFS service
 * ogr_NGW, NextGIS Web
 * ogr_ELASTIC, ElasticSearch
 * ogr_IDRISI, IDRISI
 * ogr_PDS, Planetary Data Systems TABLE
 * ogr_SQLITE, SQLite3 / Spatialite RDBMS
 * ogr_GPKG, GeoPackage
 * ogr_OSM, OpenStreetMap XML and PBF
 * ogr_VFK, Czech Cadastral Exchange Data Format
 * ogr_MVT, MVT
 * ogr_PMTILES, PMTiles
 * ogr_AMIGOCLOUD, AMIGOCLOUD
 * ogr_CARTO, CARTO
 * ogr_ILI, ILI
 * ogr_MYSQL, MySQL
 * ogr_PG, PostGIS
 * ogr_MSSQLSPATIAL, MSSQLSPATIAL
 * ogr_ODBC, ODBC
 * ogr_PGEO, PGEO
 * ogr_XLSX, Microsoft Office Excel(xlsx)
 * ogr_XLS, Microsoft Office Excel(xls)
 * ogr_MONGODBV3, MongoDB V3
 * ogr_CAD, OpenCAD
 * ogr_PARQUET, Parquet
 * ogr_ARROW, Arrow
 * ogr_GTFS, GTFS
 * ogr_OCI, Oracle OCI
 * ogr_IDB, IDB
 * ogr_ODS, ODS
 * ogr_OGDI, OGDI
 * ogr_LVBAG, LVBAG
 * ogr_HANA, SAP HANA

-- The following OPTIONAL packages have not been found:

 * ODBCCPP
   odbc-cpp library (external)
 * MSSQL_NCLI
   MSSQL Native Client to enable bulk copy
 * MSSQL_ODBC
   MSSQL ODBC driver to enable bulk copy
 * MySQL
   MySQL
 * Iconv
   Character set recoding (used in GDAL portability library)
 * LibXml2
   Read and write XML formats
 * XercesC
   Read and write XML formats (needed for GMLAS and ILI drivers)
 * CryptoPP
   Use crypto++ library for CPL.
 * SFCGAL
   gdal core supports ISO 19107:2013 and OGC Simple Features Access 1.2 for 3D operations
 * ZLIB
   zlib (external)
 * GIF
   GIF compression library (external)
 * JSONC
   json-c library (external)
 * OpenCAD
   libopencad (external, used by OpenCAD driver)
 * BRUNSLI
   Enable BRUNSLI for JPEG packing in MRF
 * libQB3
   Enable QB3 compression in MRF
 * SPATIALITE (required version >= 4.1.2)
   Enable spatialite support for sqlite3
 * RASTERLITE2 (required version >= 1.1.0)
   Enable RasterLite2 support for sqlite3
 * LibKML
   Use LIBKML library
 * KEA
   Enable KEA driver
 * HDF5
   Enable HDF5
 * WebP
   WebP compression
 * FreeXL
   Enable XLS driver
 * GTA
   Enable GTA driver
 * MRSID
   MrSID raster SDK
 * Armadillo
   C++ library for linear algebra (used for TPS transformation)
 * CFITSIO
   C FITS I/O library
 * HDF4
   Enable HDF4 driver
 * ECW
   Enable ECW driver
 * NetCDF (required version >= 4.7)
   Enable netCDF driver
 * OGDI
   Enable ogr_OGDI driver
 * OpenCL
   Enable OpenCL (may be used for warping)
 * FYBA
   enable ogr_SOSI driver
 * LZ4
   LZ4 compression
 * Blosc
   Blosc compression
 * ARCHIVE
   Multi-format archive and compression library library (used for /vsi7z/
 * LIBAEC
   Adaptive Entropy Coding implementing Golomb-Rice algorithm (used by GRIB)
 * JXL
   JPEG-XL compression
 * JXL_THREADS
   JPEG-XL threading
 * Crnlib
   enable gdal_DDS driver
 * basisu
   Enable BASISU driver
 * IDB
   enable ogr_IDB driver
 * rdb
   enable RIEGL RDB library
 * TileDB
   enable TileDB driver
 * OpenEXR
   OpenEXR >=2.2
 * MONGOCXX
   Enable MongoDBV3 driver
 * HEIF
   HEIF >= 1.1
 * OpenJPEG (required version >= 2.3.1)
   Enable JPEG2000 support with OpenJPEG library
 * HDFS
   Enable Hadoop File System through native library
 * Poppler (required version >= 0.86), A PDF rendering library, <http://poppler.freedesktop.org>
   Enable PDF driver with Poppler (read side)
 * PDFIUM
   Enable PDF driver with Pdfium (read side)
 * Oracle
   Enable Oracle OCI driver
 * TEIGHA
   Enable DWG and DGNv8 drivers
 * FileGDB
   Enable FileGDB (based on closed-source SDK) driver
 * KDU
   Enable KAKADU
 * LURATECH
   Enable JP2Lura driver
 * Arrow
   Apache Arrow C++ library

-- The following RECOMMENDED packages have not been found:

 * EXPAT
   Read and write XML formats
 * GeoTIFF
   libgeotiff library (external)
 * PNG (required version >= 1.6)
   PNG compression library (external)
 * QHULL
   Enable QHULL (external)
 * GEOS (required version >= 3.8)
   Geometry Engine - Open Source (GDAL core dependency)

-- Internal libraries enabled:

 * GEOTIFF internal library enabled
 * ZLIB internal library enabled
 * PNG internal library enabled
 * GIF internal library enabled
 * JSONC internal library enabled
 * OPENCAD internal library enabled
 * QHULL internal library enabled


-- Could NOT find GTest (missing: GTEST_LIBRARY GTEST_INCLUDE_DIR GTEST_MAIN_LIBRARY) (Required is at least version "1.10.0")
-- Using internal GTest
-- Selecting Windows SDK version 10.0.22000.0 to target Windows 10.0.22631.
-- Configuring done (0.8s)
-- Generating done (0.0s)
-- Build files have been written to: C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-download
MSBuild version 17.5.0+6f08c67f3 for .NET Framework

  1>Checking Build System
  Creating directories for 'googletest'
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-download/CMakeLists.txt
  Performing download step (download, verify and extract) for 'googletest'
  -- Downloading...
     dst='C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-download/googletest-prefix/src/release-1.12.1.zip'
     timeout='none'
     inactivity timeout='none'
  -- Using src='https://github.com/google/googletest/archive/release-1.12.1.zip'
  -- verifying file...
         file='C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-download/googletest-prefix/src/release-1.12.1.zip'
  -- Downloading... done
  -- extracting...
       src='C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-download/googletest-prefix/src/release-1.12.1.zip'
       dst='C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-src'
  -- extracting... [tar xfz]
  -- extracting... [analysis]
  -- extracting... [rename]
  -- extracting... [clean up]
  -- extracting... done
  No update step for 'googletest'
  No patch step for 'googletest'
  No configure step for 'googletest'
  No build step for 'googletest'
  No install step for 'googletest'
  No test step for 'googletest'
  Completed 'googletest'
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-download/CMakeLists.txt
-- Found Python: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/Scripts/python.exe (found version "3.10.7") found components: Interpreter
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD - Failed
-- Looking for pthread_create in pthreads
-- Looking for pthread_create in pthreads - not found
-- Looking for pthread_create in pthread
-- Looking for pthread_create in pthread - not found
-- Found Threads: TRUE
-- Copying C:/Users/hwhsu1231/Repo/testing/gdal/autotest/conftest.py to C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/conftest.py
-- Copying C:/Users/hwhsu1231/Repo/testing/gdal/autotest/run_slow_tests.sh to C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/run_slow_tests.sh
-- Configuring done (67.9s)
-- Generating done (2.2s)
-- Build files have been written to: C:/Users/hwhsu1231/Repo/testing/gdal/build

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>cmake --build build --config Release
MSBuild version 17.5.0+6f08c67f3 for .NET Framework

  1>Checking Build System
  1>
  -- Found Git: C:/Program Files/Git/cmd/git.exe (found version "2.45.2.windows.1")
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/CMakeLists.txt
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/alg/CMakeLists.txt
  contour.cpp
  gdal_crs.cpp
  gdal_octave.cpp
  gdal_rpc.cpp
  gdal_tps.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalapplyverticalshiftgrid.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalchecksum.cpp
  gdalcutline.cpp
  gdaldither.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalgeoloc.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalgeolocquadtree.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalgrid.cpp
  gdallinearsystem.cpp
  gdalmatching.cpp
  gdalmediancut.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalpansharpen.cpp
  gdalproximity.cpp
  gdalrasterize.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalrasterpolygonenumerator.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalsievefilter.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  Generating Code...
  Compiling...
  gdalsimplewarp.cpp
  gdaltransformer.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdaltransformgeolocs.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalwarper.cpp
  gdalwarpkernel.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  gdalwarpoperation.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  llrasterize.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\llrasterize.cpp(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  los.cpp
  polygonize.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  polygonize_polygonizer_impl.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\polygonize_polygonizer.cpp(1,1): warning C4819: The file contains a character that cannot be represented in the cu
rrent code page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.vcxproj]
  rasterfill.cpp
  thinplatespline.cpp
  gdal_simplesurf.cpp
  viewshed.cpp
  gdalgenericinverse.cpp
  gdalgridsse.cpp
  Generating Code...
  delaunay.c
  gdalgridavx.cpp
  alg.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\alg\alg.dir\Release\alg.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/apps/CMakeLists.txt
  gdalargumentparser.cpp
  gdalinfo_lib.cpp
  gdalbuildvrt_lib.cpp
  gdal_grid_lib.cpp
  gdal_translate_lib.cpp
  gdal_rasterize_lib.cpp
  gdalwarp_lib.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\apps\appslib.vcxproj]
  commonutils.cpp
  ogrinfo_lib.cpp
  ogr2ogr_lib.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\apps\appslib.vcxproj]
  gdaldem_lib.cpp
  nearblack_lib.cpp
  nearblack_lib_floodfill.cpp
  gdal_footprint_lib.cpp
  gdalmdiminfo_lib.cpp
  gdalmdimtranslate_lib.cpp
  gdaltindex_lib.cpp
  Generating Code...
  appslib.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\apps\appslib.dir\Release\appslib.lib
  1>
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/CMakeLists.txt
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/port/CMakeLists.txt
  cpl_alibaba_oss.cpp
  cpl_azure.cpp
  cpl_conv.cpp
  cpl_error.cpp
  cpl_string.cpp
  cplgetsymbol.cpp
  cplstringlist.cpp
  cpl_strtod.cpp
  cpl_path.cpp
  cpl_csv.cpp
  cpl_findfile.cpp
  cpl_minixml.cpp
  cpl_multiproc.cpp
  cpl_list.cpp
  cpl_getexecpath.cpp
  cplstring.cpp
  cpl_vsisimple.cpp
  cpl_vsil.cpp
  cpl_http.cpp
  cpl_hash_set.cpp
  Generating Code...
  Compiling...
  cplkeywordparser.cpp
  cpl_recode.cpp
  cpl_recode_stub.cpp
  cpl_quad_tree.cpp
  cpl_atomic_ops.cpp
  cpl_vsil_subfile.cpp
  cpl_time.cpp
  cpl_vsil_stdout.cpp
  cpl_vsil_sparsefile.cpp
  cpl_vsil_abstract_archive.cpp
  cpl_vsil_tar.cpp
  cpl_vsil_libarchive.cpp
  cpl_vsil_stdin.cpp
  cpl_vsil_buffered_reader.cpp
  cpl_vsil_plugin.cpp
  cpl_base64.cpp
  cpl_vsil_curl.cpp
  cpl_vsil_curl_streaming.cpp
  cpl_vsil_cache.cpp
  cpl_xml_validate.cpp
  Generating Code...
  Compiling...
  cpl_spawn.cpp
  cpl_google_oauth2.cpp
  cpl_progress.cpp
  cpl_virtualmem.cpp
  cpl_worker_thread_pool.cpp
  cpl_vsil_crypt.cpp
  cpl_sha1.cpp
  cpl_sha256.cpp
  cpl_aws.cpp
  cpl_aws_win32.cpp
  cpl_vsi_error.cpp
  cpl_cpu_features.cpp
  cpl_google_cloud.cpp
  cpl_json.cpp
  cpl_json_streaming_parser.cpp
  cpl_md5.cpp
  cpl_vsil_hdfs.cpp
  cpl_swift.cpp
  cpl_vsil_adls.cpp
  cpl_vsil_az.cpp
  Generating Code...
  Compiling...
  cpl_vsil_uploadonclose.cpp
  cpl_vsil_gs.cpp
  cpl_vsil_webhdfs.cpp
  cpl_vsil_s3.cpp
  cpl_vsil_oss.cpp
  cpl_vsil_swift.cpp
  cpl_json_streaming_writer.cpp
  cpl_userfaultfd.cpp
  cpl_vax.cpp
  cpl_compressor.cpp
  cpl_float.cpp
  cpl_vsil_win32.cpp
  cpl_vsil_gzip.cpp
  cpl_minizip_ioapi.cpp
  cpl_minizip_unzip.cpp
  cpl_minizip_zip.cpp
  cpl_odbc.cpp
  Generating Code...
  cpl.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\port\cpl.dir\Release\cpl.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/port/CMakeLists.txt
  cpl_vsi_mem.cpp
  cpl_vsi_mem.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\port\cpl_vsi_mem.dir\Release\cpl_vsi_mem.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/gcore/CMakeLists.txt
  gdalopeninfo.cpp
  gdaldriver.cpp
  gdaldataset.cpp
  gdalrasterband.cpp
  gdal_misc.cpp
  gdalrasterblock.cpp
  gdalcolortable.cpp
  gdalmajorobject.cpp
  gdaldefaultoverviews.cpp
  gdalpamdataset.cpp
  gdalpamrasterband.cpp
  gdaljp2metadata.cpp
  gdaljp2box.cpp
  gdalmultidomainmetadata.cpp
  gdal_rat.cpp
  gdalpamproxydb.cpp
  gdalallvalidmaskband.cpp
  gdalnodatamaskband.cpp
  gdalnodatavaluesmaskband.cpp
  gdalproxydataset.cpp
  Generating Code...
  Compiling...
  gdalproxypool.cpp
  gdaldefaultasync.cpp
  gdaldllmain.cpp
  gdalexif.cpp
  gdalgeorefpamdataset.cpp
  gdaljp2abstractdataset.cpp
  gdalvirtualmem.cpp
  gdaloverviewdataset.cpp
  gdalrescaledalphaband.cpp
  gdaljp2structure.cpp
  gdal_mdreader.cpp
  gdaljp2metadatagenerator.cpp
  gdalabstractbandblockcache.cpp
  gdalarraybandblockcache.cpp
  gdalhashsetbandblockcache.cpp
  gdalrelationship.cpp
  gdalsubdatasetinfo.cpp
  gdalorienteddataset.cpp
  overview.cpp
  rasterio.cpp
  Generating Code...
  Compiling...
  rawdataset.cpp
  gdalmultidim.cpp
  gdalmultidim_gridded.cpp
  gdalmultidim_gltorthorectification.cpp
  gdalmultidim_subsetdimension.cpp
  gdalmultidim_rat.cpp
  gdalpython.cpp
  gdalpythondriverloader.cpp
  tilematrixset.cpp
  gdal_thread_pool.cpp
  nasakeywordhandler.cpp
  rasterio_ssse3.cpp
  Generating Code...
  gdaldrivermanager.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\gcore\gcore.vcxproj]
  gcore.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\gcore\gcore.dir\Release\gcore.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/gcore/mdreader/CMakeLists.txt
  reader_alos.cpp
  reader_digital_globe.cpp
  reader_eros.cpp
  reader_geo_eye.cpp
  reader_kompsat.cpp
  reader_landsat.cpp
  reader_orb_view.cpp
  reader_pleiades.cpp
  reader_rapid_eye.cpp
  reader_rdk1.cpp
  reader_spot.cpp
  Generating Code...
  gcore_mdreader.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\gcore\mdreader\gcore_mdreader.dir\Release\gcore_mdreader.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/derived/CMakeLists.txt
  deriveddataset.cpp
  derivedlist.c
  gdal_Derived.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\derived\gdal_Derived.dir\Release\gdal_Derived.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/gtiff/CMakeLists.txt
  cogdriver.cpp
  gtiffbitmapband.cpp
  gtiffdataset.cpp
  gtiffdataset_read.cpp
  gtiffdataset_write.cpp
  gtiffjpegoverviewds.cpp
  gtiffoddbitsband.cpp
  gtiffrasterband.cpp
  gtiffrasterband_read.cpp
  gtiffrasterband_write.cpp
  gtiffrgbaband.cpp
  gtiffsplitband.cpp
  gtiffsplitbitmapband.cpp
  geotiff.cpp
  gt_jpeg_copy.cpp
  gt_citation.cpp
  gt_overview.cpp
  gt_wkt_srs.cpp
  tifvsi.cpp
  Generating Code...
  gdal_GTIFF.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\gtiff\gdal_GTIFF.dir\Release\gdal_GTIFF.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/hfa/CMakeLists.txt
  hfaband.cpp
  hfacompress.cpp
  hfadataset.cpp
  hfadictionary.cpp
  hfaentry.cpp
  hfafield.cpp
  hfaopen.cpp
  hfatype.cpp
  hfa_overviews.cpp
  Generating Code...
  gdal_HFA.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\hfa\gdal_HFA.dir\Release\gdal_HFA.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/mem/CMakeLists.txt
  memdataset.cpp
  gdal_MEM.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\mem\gdal_MEM.dir\Release\gdal_MEM.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/CMakeLists.txt
  gdalallregister.cpp
  gdal_frmts.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\gdal_frmts.dir\Release\gdal_frmts.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/vrt/CMakeLists.txt
  vrtderivedrasterband.cpp
  vrtdriver.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\vrt\gdal_vrt.vcxproj]
  vrtfilters.cpp
  vrtrasterband.cpp
  vrtrawrasterband.cpp
  vrtsourcedrasterband.cpp
  vrtsources.cpp
  vrtwarped.cpp
C:\Users\hwhsu1231\Repo\testing\gdal\alg\gdal_alg_priv.h(1,1): warning C4819: The file contains a character that cannot be represented in the current code
page (950). Save the file in Unicode format to prevent data loss [C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\vrt\gdal_vrt.vcxproj]
  vrtdataset.cpp
  pixelfunctions.cpp
  vrtpansharpened.cpp
  vrtprocesseddataset.cpp
  vrtprocesseddatasetfunctions.cpp
  vrtmultidim.cpp
  gdaltileindexdataset.cpp
  Generating Code...
  gdal_vrt.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\vrt\gdal_vrt.dir\Release\gdal_vrt.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/gtiff/libgeotiff/CMakeLists.txt
  geo_free.c
  geo_new.c
  geo_set.c
  geo_get.c
  geo_normalize.c
  geo_simpletags.c
  geo_trans.c
  xtiff.c
  geo_write.c
  geotiff_proj4.c
  geo_extra.c
  geo_names.c
  geo_print.c
  geo_tiffp.c
  Generating Code...
  geotiff.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\gtiff\libgeotiff\geotiff.dir\Release\geotiff.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/gnm/CMakeLists.txt
  gnmlayer.cpp
  gnmgenericnetwork.cpp
  gnmgraph.cpp
  gnmnetwork.cpp
  gnmresultlayer.cpp
  gnmrule.cpp
  Generating Code...
  gnm.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\gnm\gnm.dir\Release\gnm.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/gnm/gnm_frmts/CMakeLists.txt
  gnmregisterall.cpp
  gnm_frmts.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\gnm\gnm_frmts\gnm_frmts.dir\Release\gnm_frmts.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/gnm/gnm_frmts/db/CMakeLists.txt
  gnmdbdriver.cpp
  gnmdbnetwork.cpp
  Generating Code...
  gnm_frmts_db.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\gnm\gnm_frmts\db\gnm_frmts_db.dir\Release\gnm_frmts_db.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/gnm/gnm_frmts/file/CMakeLists.txt
  gnmfiledriver.cpp
  gnmfilenetwork.cpp
  Generating Code...
  gnm_frmts_file.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\gnm\gnm_frmts\file\gnm_frmts_file.dir\Release\gnm_frmts_file.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/zlib/contrib/infback9/CMakeLists.txt
  infback9.c
  inftree9.c
  minified_zutil.c
  Generating Code...
  infback9.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\zlib\contrib\infback9\infback9.dir\Release\infback9.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/geojson/libjson/CMakeLists.txt
  arraylist.c
  debug.c
  json_c_version.c
  json_object.c
  json_object_iterator.c
  json_tokener.c
  json_util.c
  linkhash.c
  printbuf.c
  random_seed.c
  strerror_override.c
  Generating Code...
  libjson.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\geojson\libjson\libjson.dir\Release\libjson.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/png/libpng/CMakeLists.txt
  png.c
  pngmem.c
  pngread.c
  pngrtran.c
  pngset.c
  pngwrite.c
  pngwutil.c
  pngerror.c
  pngget.c
  pngpread.c
  pngrio.c
  pngrutil.c
  pngtrans.c
  pngwio.c
  pngwtran.c
  Generating Code...
  libpng.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\png\libpng\libpng.dir\Release\libpng.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/frmts/zlib/CMakeLists.txt
  adler32.c
  compress.c
  crc32.c
  deflate.c
  infback.c
  inffast.c
  inflate.c
  inftrees.c
  trees.c
  uncompr.c
  zutil.c
  Generating Code...
  libz.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\frmts\zlib\libz.dir\Release\libz.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/CMakeLists.txt
  ogrgeometryfactory.cpp
  ogrpoint.cpp
  ogrcurve.cpp
  ogrlinestring.cpp
  ogrlinearring.cpp
  ogrpolygon.cpp
  ogrtriangle.cpp
  ogrutils.cpp
  ogrgeomcoordinateprecision.cpp
  ogrgeometry.cpp
  ogrgeometrycollection.cpp
  ogrmultipolygon.cpp
  ogrsurface.cpp
  ogrpolyhedralsurface.cpp
  ogrtriangulatedsurface.cpp
  ogrmultipoint.cpp
  ogrmultilinestring.cpp
  ogrcircularstring.cpp
  ogrcompoundcurve.cpp
  ogrcurvepolygon.cpp
  Generating Code...
  Compiling...
  ogrcurvecollection.cpp
  ogrmulticurve.cpp
  ogrmultisurface.cpp
  ogr_api.cpp
  ogrfeature.cpp
  ogrfeaturedefn.cpp
  ogrfeaturequery.cpp
  ogrfeaturestyle.cpp
  ogrfielddefn.cpp
  ogrspatialreference.cpp
  ogr_srsnode.cpp
  ogr_fromepsg.cpp
  ogrct.cpp
  ogr_srs_cf1.cpp
  ogr_srs_esri.cpp
  ogr_srs_pci.cpp
  ogr_srs_usgs.cpp
  ogr_srs_dict.cpp
  ogr_srs_panorama.cpp
  ogr_srs_ozi.cpp
  Generating Code...
  Compiling...
  ogr_srs_erm.cpp
  swq.cpp
  swq_expr_node.cpp
  swq_parser.cpp
  swq_select.cpp
  swq_op_registrar.cpp
  swq_op_general.cpp
  ogr_srs_xml.cpp
  ograssemblepolygon.cpp
  ogr2gmlgeometry.cpp
  gml2ogrgeometry.cpp
  ogr_expat.cpp
  ogrpgeogeometry.cpp
  ogr_geocoding.cpp
  ogrgeomfielddefn.cpp
  ograpispy.cpp
  ogr_xerces.cpp
  ogr_geo_utils.cpp
  ogr_proj_p.cpp
  ogr_wkb.cpp
  Generating Code...
  ogr.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogr.dir\Release\ogr.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/kml/CMakeLists.txt
  ogrkmldriver.cpp
  ogr2kmlgeometry.cpp
  ogrkmldatasource.cpp
  ogrkmllayer.cpp
  Generating Code...
  ogr_KML.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\kml\ogr_KML.dir\Release\ogr_KML.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/mem/CMakeLists.txt
  ogrmemdatasource.cpp
  ogrmemdriver.cpp
  ogrmemlayer.cpp
  Generating Code...
  ogr_MEM.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\mem\ogr_MEM.dir\Release\ogr_MEM.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/shape/CMakeLists.txt
  shape2ogr.cpp
  ogrshapedatasource.cpp
  ogrshapedriver.cpp
  ogrshapelayer.cpp
  Generating Code...
  shp_vsi.c
  ogr_Shape.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\shape\ogr_Shape.dir\Release\ogr_Shape.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/mitab/CMakeLists.txt
  mitab_rawbinblock.cpp
  mitab_mapheaderblock.cpp
  mitab_mapindexblock.cpp
  mitab_mapobjectblock.cpp
  mitab_mapcoordblock.cpp
  mitab_feature.cpp
  mitab_feature_mif.cpp
  mitab_mapfile.cpp
  mitab_idfile.cpp
  mitab_datfile.cpp
  mitab_tabfile.cpp
  mitab_miffile.cpp
  mitab_utils.cpp
  mitab_imapinfofile.cpp
  mitab_middatafile.cpp
  mitab_bounds.cpp
  mitab_maptoolblock.cpp
  mitab_tooldef.cpp
  mitab_coordsys.cpp
  mitab_spatialref.cpp
  Generating Code...
  Compiling...
  mitab_ogr_driver.cpp
  mitab_indfile.cpp
  mitab_tabview.cpp
  mitab_ogr_datasource.cpp
  mitab_geometry.cpp
  mitab_tabseamless.cpp
  Generating Code...
  ogr_TAB.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\mitab\ogr_TAB.dir\Release\ogr_TAB.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/vrt/CMakeLists.txt
  ogrvrtdatasource.cpp
  ogrvrtdriver.cpp
  ogrvrtlayer.cpp
  Generating Code...
  ogr_VRT.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\vrt\ogr_VRT.dir\Release\ogr_VRT.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/geojson/CMakeLists.txt
  ogrgeojsondatasource.cpp
  ogrgeojsonlayer.cpp
  ogrgeojsonreader.cpp
  ogrgeojsonutils.cpp
  ogrgeojsonwritelayer.cpp
  ogrgeojsonwriter.cpp
  ogrgeojsondriver.cpp
  ogrgeojsonseqdriver.cpp
  ogresrijsonreader.cpp
  ogresrijsondriver.cpp
  ogrtopojsonreader.cpp
  ogrtopojsondriver.cpp
  ogrjsoncollectionstreamingparser.cpp
  Generating Code...
  ogr_geojson.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\geojson\ogr_geojson.dir\Release\ogr_geojson.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/CMakeLists.txt
  ogrregisterall.cpp
  ogrsf_frmts.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\ogrsf_frmts.dir\Release\ogrsf_frmts.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/generic/CMakeLists.txt
  ogrsfdriverregistrar.cpp
  ogrlayer.cpp
  ogrlayerarrow.cpp
  ogrdatasource.cpp
  ogrsfdriver.cpp
  ogr_gensql.cpp
  ogr_attrind.cpp
  ogr_miattrind.cpp
  ogrwarpedlayer.cpp
  ogrunionlayer.cpp
  ogrlayerpool.cpp
  ogrlayerdecorator.cpp
  ogreditablelayer.cpp
  ogremulatedtransaction.cpp
  ogrmutexeddatasource.cpp
  ogrmutexedlayer.cpp
  ograrrowarrayhelper.cpp
  Generating Code...
  ogrsf_generic.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\generic\ogrsf_generic.dir\Release\ogrsf_generic.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/ogr/ogrsf_frmts/shape/CMakeLists.txt
  sbnsearch_wrapper.cpp
  shpopen_wrapper.cpp
  shptree_wrapper.cpp
  dbfopen_wrapper.cpp
  Generating Code...
  shapelib.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\ogr\ogrsf_frmts\shape\shapelib.dir\Release\shapelib.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/CMakeLists.txt
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/Release/gdal.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/build/Release/gdal.exp
  GDAL.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\Release\gdal.dll
  1>Generating osgeo/__init__.py
  2>Generating extensions/gdal_wrap.cpp, osgeo/gdal.py
  3>Generate _gdal_array_wrap.so and gdal_array.py by SWiG command
  5>Generating osgeo/gdalnumeric.py
  6>Generating extensions/gnm_wrap.cpp, osgeo/gnm.py
  8>Generating extensions/osr_wrap.cpp, osgeo/osr.py
  4>Generating extensions/gdalconst_wrap.c, osgeo/gdalconst.py
  7>Generating extensions/ogr_wrap.cpp, osgeo/ogr.py
  Generating osgeo/_gdal.cp310-win_amd64.pyd, osgeo/_gdalconst.cp310-win_amd64.pyd, osgeo/_gnm.cp310-win_amd64.pyd, osgeo/_ogr.cp310-win_amd64.pyd, osgeo/_
  osr.cp310-win_amd64.pyd, osgeo/_gdal_array.cp310-win_amd64.pyd
  C:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\setuptools\config\_apply_pyprojecttoml.py:103: _WouldIgnoreField: 'entry-points' defined out
  side of `pyproject.toml` would be ignored.
      !!


      ##########################################################################
      # configuration would be ignored/result in error due to `pyproject.toml` #
      ##########################################################################

      The following seems to be defined outside of `pyproject.toml`:

      `entry-points = {'console_scripts': [['rgb2pct = osgeo_utils.rgb2pct:main'], ['pct2rgb = osgeo_utils.pct2rgb:main'], ['ogrmerge = osgeo_utils.ogrmerg
  e:main'], ['ogr_layer_algebra = osgeo_utils.ogr_layer_algebra:main'], ['gdalmove = osgeo_utils.gdalmove:main'], ['gdalcompare = osgeo_utils.gdalcompare:m
  ain'], ['gdalattachpct = osgeo_utils.gdalattachpct:main'], ['gdal_sieve = osgeo_utils.gdal_sieve:main'], ['gdal_retile = osgeo_utils.gdal_retile:main'],
  ['gdal_proximity = osgeo_utils.gdal_proximity:main'], ['gdal_polygonize = osgeo_utils.gdal_polygonize:main'], ['gdal_pansharpen = osgeo_utils.gdal_pansha
  rpen:main'], ['gdal_merge = osgeo_utils.gdal_merge:main'], ['gdal_fillnodata = osgeo_utils.gdal_fillnodata:main'], ['gdal_edit = osgeo_utils.gdal_edit:ma
  in'], ['gdal_calc = osgeo_utils.gdal_calc:main'], ['gdal2xyz = osgeo_utils.gdal2xyz:main'], ['gdal2tiles = osgeo_utils.gdal2tiles:main']]}`

      According to the spec (see the link below), however, setuptools CANNOT
      consider this value unless 'entry-points' is listed as `dynamic`.

      https://packaging.python.org/en/latest/specifications/declaring-project-metadata/

      For the time being, `setuptools` will still consider the given value (as a
      **transitional** measure), but please note that future releases of setuptools will
      follow strictly the standard.

      To prevent this warning, you can list 'entry-points' under `dynamic` or alternatively
      remove the `[project]` table from your file and rely entirely on other means of
      configuration.


  !!

    warnings.warn(msg, _WouldIgnoreField)
  Using numpy 2.0.0
  running build_ext
  building 'osgeo._gdal' extension
  building 'osgeo._gdalconst' extension
  building 'osgeo._osr' extension
  building 'osgeo._gdal_array' extension
  building 'osgeo._gnm' extension
  building 'osgeo._ogr' extension
  creating build
  creating build\temp.win-amd64-cpython-310
  creating build\temp.win-amd64-cpython-310\Release
  creating build\temp.win-amd64-cpython-310\Release\extensions
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\cl.exe" /c /nologo /O2 /W3 /GL /DNDEBUG /MD -IC:/Users
  /hwhsu1231/Repo/testing/gdal/build/port -IC:/Users/hwhsu1231/Repo/testing/gdal/port -IC:/Users/hwhsu1231/Repo/testing/gdal/build/gcore -IC:/Users/hwhsu12
  31/Repo/testing/gdal/gcore -IC:/Users/hwhsu1231/Repo/testing/gdal/alg -IC:/Users/hwhsu1231/Repo/testing/gdal/ogr/ -IC:/Users/hwhsu1231/Repo/testing/gdal/
  ogr/ogrsf_frmts -IC:/Users/hwhsu1231/Repo/testing/gdal/gnm -IC:/Users/hwhsu1231/Repo/testing/gdal/apps -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\inclu
  de -IC:\Python\Python310\include -IC:\Python\Python310\Include -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include "-IC:\P
  rogram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tool
  s\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows
  Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\includ
  e\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.2
  2000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSV
  C\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows
  Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" /EHsc /Tpextensions/ogr_wrap.cpp /Fobuild\temp.win
  -amd64-cpython-310\Release\extensions/ogr_wrap.obj
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\cl.exe" /c /nologo /O2 /W3 /GL /DNDEBUG /MD -IC:/Users
  /hwhsu1231/Repo/testing/gdal/build/port -IC:/Users/hwhsu1231/Repo/testing/gdal/port -IC:/Users/hwhsu1231/Repo/testing/gdal/build/gcore -IC:/Users/hwhsu12
  31/Repo/testing/gdal/gcore -IC:/Users/hwhsu1231/Repo/testing/gdal/alg -IC:/Users/hwhsu1231/Repo/testing/gdal/ogr/ -IC:/Users/hwhsu1231/Repo/testing/gdal/
  ogr/ogrsf_frmts -IC:/Users/hwhsu1231/Repo/testing/gdal/gnm -IC:/Users/hwhsu1231/Repo/testing/gdal/apps -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\inclu
  de -IC:\Python\Python310\include -IC:\Python\Python310\Include -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include "-IC:\P
  rogram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tool
  s\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows
  Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\includ
  e\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.2
  2000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSV
  C\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows
  Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\C
  ommunity\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Pr
  ogram Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Pr
  ogram Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files
   (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)
  \Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\
  Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\sh
  ared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC
  :\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" /EHsc /Tpextensions/osr_wrap.cpp /Fobuild\temp.win-amd64-cpython-310\Release\extensions/osr_w
  rap.obj
  osr_wrap.cpp
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\cl.exe" /c /nologo /O2 /W3 /GL /DNDEBUG /MD -IC:/Users
  /hwhsu1231/Repo/testing/gdal/build/port -IC:/Users/hwhsu1231/Repo/testing/gdal/port -IC:/Users/hwhsu1231/Repo/testing/gdal/build/gcore -IC:/Users/hwhsu12
  31/Repo/testing/gdal/gcore -IC:/Users/hwhsu1231/Repo/testing/gdal/alg -IC:/Users/hwhsu1231/Repo/testing/gdal/ogr/ -IC:/Users/hwhsu1231/Repo/testing/gdal/
  ogr/ogrsf_frmts -IC:/Users/hwhsu1231/Repo/testing/gdal/gnm -IC:/Users/hwhsu1231/Repo/testing/gdal/apps -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\inclu
  de -IC:\Python\Python310\include -IC:\Python\Python310\Include -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include "-IC:\P
  rogram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tool
  s\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows
  Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\includ
  e\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.2
  2000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSV
  C\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows
  Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\C
  ommunity\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Pr
  ogram Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Pr
  ogram Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files
   (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)
  \Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\
  Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\sh
  ared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC
  :\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include"
   "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Co
  mmunity\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\
  10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.
  0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\T
  ools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windo
  ws Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kit
  s\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK
  \4.8\Include\um" /EHsc /Tpextensions/gdal_wrap.cpp /Fobuild\temp.win-amd64-cpython-310\Release\extensions/gdal_wrap.obj
  ogr_wrap.cpp
  gdal_wrap.cpp
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\cl.exe" /c /nologo /O2 /W3 /GL /DNDEBUG /MD -IC:/Users
  /hwhsu1231/Repo/testing/gdal/build/port -IC:/Users/hwhsu1231/Repo/testing/gdal/port -IC:/Users/hwhsu1231/Repo/testing/gdal/build/gcore -IC:/Users/hwhsu12
  31/Repo/testing/gdal/gcore -IC:/Users/hwhsu1231/Repo/testing/gdal/alg -IC:/Users/hwhsu1231/Repo/testing/gdal/ogr/ -IC:/Users/hwhsu1231/Repo/testing/gdal/
  ogr/ogrsf_frmts -IC:/Users/hwhsu1231/Repo/testing/gdal/gnm -IC:/Users/hwhsu1231/Repo/testing/gdal/apps -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\inclu
  de -IC:\Python\Python310\include -IC:\Python\Python310\Include -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include "-IC:\P
  rogram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tool
  s\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows
  Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\includ
  e\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.2
  2000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSV
  C\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows
  Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\C
  ommunity\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Pr
  ogram Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Pr
  ogram Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files
   (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)
  \Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\
  Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\sh
  ared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC
  :\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include"
   "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Co
  mmunity\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\
  10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.
  0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\T
  ools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windo
  ws Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kit
  s\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK
  \4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studi
  o\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Prog
  ram Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)
  \Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows
   Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um
  " "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Prog
  ram Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" /EHsc /Tpextensions/gnm_wr
  ap.cpp /Fobuild\temp.win-amd64-cpython-310\Release\extensions/gnm_wrap.obj
  gnm_wrap.cpp
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\cl.exe" /c /nologo /O2 /W3 /GL /DNDEBUG /MD -IC:/Users
  /hwhsu1231/Repo/testing/gdal/build/port -IC:/Users/hwhsu1231/Repo/testing/gdal/port -IC:/Users/hwhsu1231/Repo/testing/gdal/build/gcore -IC:/Users/hwhsu12
  31/Repo/testing/gdal/gcore -IC:/Users/hwhsu1231/Repo/testing/gdal/alg -IC:/Users/hwhsu1231/Repo/testing/gdal/ogr/ -IC:/Users/hwhsu1231/Repo/testing/gdal/
  ogr/ogrsf_frmts -IC:/Users/hwhsu1231/Repo/testing/gdal/gnm -IC:/Users/hwhsu1231/Repo/testing/gdal/apps -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\inclu
  de -IC:\Python\Python310\include -IC:\Python\Python310\Include -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include "-IC:\P
  rogram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tool
  s\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows
  Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\includ
  e\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.2
  2000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSV
  C\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows
  Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\C
  ommunity\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Pr
  ogram Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Pr
  ogram Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files
   (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)
  \Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\
  Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\sh
  ared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC
  :\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include"
   "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Co
  mmunity\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\
  10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.
  0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\T
  ools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windo
  ws Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kit
  s\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK
  \4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studi
  o\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Prog
  ram Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)
  \Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows
   Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um
  " "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Prog
  ram Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\
  ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.
  0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\sha
  red" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "
  -IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\inclu
  de" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10
  \Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.
  0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" /EHsc /Tpextensions/gdal_array_wrap.cpp /Fobuild\temp.win-amd64-cpyth
  on-310\Release\extensions/gdal_array_wrap.obj
  gdal_array_wrap.cpp
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\cl.exe" /c /nologo /O2 /W3 /GL /DNDEBUG /MD -IC:/Users
  /hwhsu1231/Repo/testing/gdal/build/port -IC:/Users/hwhsu1231/Repo/testing/gdal/port -IC:/Users/hwhsu1231/Repo/testing/gdal/build/gcore -IC:/Users/hwhsu12
  31/Repo/testing/gdal/gcore -IC:/Users/hwhsu1231/Repo/testing/gdal/alg -IC:/Users/hwhsu1231/Repo/testing/gdal/ogr/ -IC:/Users/hwhsu1231/Repo/testing/gdal/
  ogr/ogrsf_frmts -IC:/Users/hwhsu1231/Repo/testing/gdal/gnm -IC:/Users/hwhsu1231/Repo/testing/gdal/apps -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\inclu
  de -IC:\Python\Python310\include -IC:\Python\Python310\Include -IC:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include "-IC:\P
  rogram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tool
  s\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows
  Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\includ
  e\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.2
  2000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSV
  C\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft
   Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows
  Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\C
  ommunity\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Pr
  ogram Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Pr
  ogram Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files
   (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)
  \Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\
  Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\
  VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\sh
  ared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC
  :\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include"
   "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Co
  mmunity\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\
  10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.
  0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\T
  ools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windo
  ws Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x
  86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kit
  s\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK
  \4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studi
  o\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Prog
  ram Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)
  \Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows
   Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um
  " "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Prog
  ram Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\
  ATLMFC\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.
  0.22000.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\sha
  red" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "
  -IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\inclu
  de" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\include" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10
  \Include\10.0.22000.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.
  0.22000.0\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\include" "-IC:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.22000.0\ucrt" "-IC:\Program Files (x86)\W
  indows Kits\10\\include\10.0.22000.0\\um" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\shared" "-IC:\Program Files (x86)\Windows Kits
  \10\\include\10.0.22000.0\\winrt" "-IC:\Program Files (x86)\Windows Kits\10\\include\10.0.22000.0\\cppwinrt" "-IC:\Program Files (x86)\Windows Kits\NETFX
  SDK\4.8\include\um" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\include" "-IC:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\include" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include" "-IC:\P
  rogram Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt" "-IC:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include
  " "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared" "-IC:\Program
   Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt" "-IC:\Program Files (x8
  6)\Windows Kits\NETFXSDK\4.8\Include\um" /Tcextensions/gdalconst_wrap.c /Fobuild\temp.win-amd64-cpython-310\Release\extensions/gdalconst_wrap.obj
  gdalconst_wrap.c
  creating C:\Users\hwhsu1231\Repo\testing\gdal\build\swig\python\build\lib.win-amd64-cpython-310
  creating C:\Users\hwhsu1231\Repo\testing\gdal\build\swig\python\build\lib.win-amd64-cpython-310\osgeo
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\link.exe" /nologo /INCREMENTAL:NO /LTCG /DLL /MANIFEST
  :EMBED,ID=2 /MANIFESTUAC:NO /LIBPATH:C:/Users/hwhsu1231/Repo/testing/gdal/build/Release /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\libs /LIBPATH
  :C:\Python\Python310\libs /LIBPATH:C:\Python\Python310 /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\PCbuild\amd64 "/LIBPATH:C:\Program Files\Micro
  soft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MS
  VC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.
  22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Com
  munity\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/L
  IBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0
  \ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\
  10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64
  " "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LI
  BPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\1
  4.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program File
  s\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um
  \x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program
   Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files
   (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/
  LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Stu
  dio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Pro
  gram Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC
  \lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows K
  its\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10
  \\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Fil
  es\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
  Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windo
  ws Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\u
  m\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um
  \x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64"
  "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliar
  y\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\l
  ib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Pr
  ogram Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Pro
  gram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC
  \Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program F
  iles (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/L
  IBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" gdal.lib /E
  XPORT:PyInit__gdalconst build\temp.win-amd64-cpython-310\Release\extensions/gdalconst_wrap.obj /OUT:build\lib.win-amd64-cpython-310\osgeo\_gdalconst.cp31
  0-win_amd64.pyd /IMPLIB:build\temp.win-amd64-cpython-310\Release\extensions\_gdalconst.cp310-win_amd64.lib
     Creating library build\temp.win-amd64-cpython-310\Release\extensions\_gdalconst.cp310-win_amd64.lib and object build\temp.win-amd64-cpython-310\Releas
  e\extensions\_gdalconst.cp310-win_amd64.exp
  Generating code
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\link.exe" /nologo /INCREMENTAL:NO /LTCG /DLL /MANIFEST
  :EMBED,ID=2 /MANIFESTUAC:NO /LIBPATH:C:/Users/hwhsu1231/Repo/testing/gdal/build/Release /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\libs /LIBPATH
  :C:\Python\Python310\libs /LIBPATH:C:\Python\Python310 /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\PCbuild\amd64 "/LIBPATH:C:\Program Files\Micro
  soft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MS
  VC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.
  22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Com
  munity\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/L
  IBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0
  \ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\
  10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64
  " "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LI
  BPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\1
  4.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program File
  s\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um
  \x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program
   Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files
   (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/
  LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Stu
  dio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Pro
  gram Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC
  \lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows K
  its\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10
  \\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Fil
  es\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
  Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windo
  ws Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\u
  m\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um
  \x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64"
  "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliar
  y\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\l
  ib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Pr
  ogram Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Pro
  gram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC
  \Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program F
  iles (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/L
  IBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" gdal.lib /E
  XPORT:PyInit__gnm build\temp.win-amd64-cpython-310\Release\extensions/gnm_wrap.obj /OUT:build\lib.win-amd64-cpython-310\osgeo\_gnm.cp310-win_amd64.pyd /I
  MPLIB:build\temp.win-amd64-cpython-310\Release\extensions\_gnm.cp310-win_amd64.lib
C:\Users\hwhsu1231\Repo\testing\gdal\.venv\lib\site-packages\numpy\_core\include\numpy\ndarraytypes.h(1676): warning C4819: The file contains a character t
hat cannot be represented in the current code page (950). Save the file in Unicode format to prevent data loss   Creating library build\temp.win-amd64-cpyt
hon-310\Release\extensions\_gnm.cp310-win_amd64.lib and object build\temp.win-amd64-cpython-310\Release\extensions\_gnm.cp310-win_amd64.exp [C:\Users\hwhsu
1231\Repo\testing\gdal\build\swig\python\python_binding.vcxproj]

  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\link.exe" /nologo /INCREMENTAL:NO /LTCG /DLL /MANIFEST
  :EMBED,ID=2 /MANIFESTUAC:NO /LIBPATH:C:/Users/hwhsu1231/Repo/testing/gdal/build/Release /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\libs /LIBPATH
  :C:\Python\Python310\libs /LIBPATH:C:\Python\Python310 /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\PCbuild\amd64 "/LIBPATH:C:\Program Files\Micro
  soft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MS
  VC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.
  22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Com
  munity\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/L
  IBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0
  \ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\
  10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64
  " "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LI
  BPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\1
  4.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program File
  s\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um
  \x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program
   Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files
   (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/
  LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Stu
  dio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Pro
  gram Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC
  \lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows K
  its\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10
  \\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Fil
  es\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
  Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windo
  ws Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\u
  m\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um
  \x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64"
  "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliar
  y\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\l
  ib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Pr
  ogram Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Pro
  gram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC
  \Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program F
  iles (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/L
  IBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" gdal.lib /E
  XPORT:PyInit__osr build\temp.win-amd64-cpython-310\Release\extensions/osr_wrap.obj /OUT:build\lib.win-amd64-cpython-310\osgeo\_osr.cp310-win_amd64.pyd /I
  MPLIB:build\temp.win-amd64-cpython-310\Release\extensions\_osr.cp310-win_amd64.lib
  Generating code
extensions/gdal_array_wrap.cpp(6119): warning C4244: 'initializing': conversion from 'npy_intp' to 'int', possible loss of data [C:\Users\hwhsu1231\Repo\te
sting\gdal\build\swig\python\python_binding.vcxproj]
     Creating library build\temp.win-amd64-cpython-310\Release\extensions\_osr.cp310-win_amd64.lib and object build\temp.win-amd64-cpython-310\Release\exte
  nsions\_osr.cp310-win_amd64.exp
  Generating code
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\link.exe" /nologo /INCREMENTAL:NO /LTCG /DLL /MANIFEST
  :EMBED,ID=2 /MANIFESTUAC:NO /LIBPATH:C:/Users/hwhsu1231/Repo/testing/gdal/build/Release /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\libs /LIBPATH
  :C:\Python\Python310\libs /LIBPATH:C:\Python\Python310 /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\PCbuild\amd64 "/LIBPATH:C:\Program Files\Micro
  soft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MS
  VC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.
  22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Com
  munity\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/L
  IBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0
  \ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\
  10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64
  " "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LI
  BPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\1
  4.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program File
  s\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um
  \x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program
   Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files
   (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/
  LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Stu
  dio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Pro
  gram Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC
  \lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows K
  its\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10
  \\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Fil
  es\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
  Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windo
  ws Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\u
  m\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um
  \x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64"
  "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliar
  y\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\l
  ib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Pr
  ogram Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Pro
  gram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC
  \Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program F
  iles (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/L
  IBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" gdal.lib /E
  XPORT:PyInit__gdal_array build\temp.win-amd64-cpython-310\Release\extensions/gdal_array_wrap.obj /OUT:build\lib.win-amd64-cpython-310\osgeo\_gdal_array.c
  p310-win_amd64.pyd /IMPLIB:build\temp.win-amd64-cpython-310\Release\extensions\_gdal_array.cp310-win_amd64.lib
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\link.exe" /nologo /INCREMENTAL:NO /LTCG /DLL /MANIFEST
  :EMBED,ID=2 /MANIFESTUAC:NO /LIBPATH:C:/Users/hwhsu1231/Repo/testing/gdal/build/Release /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\libs /LIBPATH
  :C:\Python\Python310\libs /LIBPATH:C:\Python\Python310 /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\PCbuild\amd64 "/LIBPATH:C:\Program Files\Micro
  soft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MS
  VC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.
  22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Com
  munity\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/L
  IBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0
  \ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\
  10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64
  " "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LI
  BPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\1
  4.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program File
  s\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um
  \x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program
   Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files
   (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/
  LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Stu
  dio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Pro
  gram Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC
  \lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows K
  its\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10
  \\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Fil
  es\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
  Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windo
  ws Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\u
  m\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um
  \x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64"
  "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliar
  y\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\l
  ib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Pr
  ogram Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Pro
  gram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC
  \Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program F
  iles (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/L
  IBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" gdal.lib /E
  XPORT:PyInit__ogr build\temp.win-amd64-cpython-310\Release\extensions/ogr_wrap.obj /OUT:build\lib.win-amd64-cpython-310\osgeo\_ogr.cp310-win_amd64.pyd /I
  MPLIB:build\temp.win-amd64-cpython-310\Release\extensions\_ogr.cp310-win_amd64.lib
     Creating library build\temp.win-amd64-cpython-310\Release\extensions\_gdal_array.cp310-win_amd64.lib and object build\temp.win-amd64-cpython-310\Relea
  se\extensions\_gdal_array.cp310-win_amd64.exp
  Generating code
     Creating library build\temp.win-amd64-cpython-310\Release\extensions\_ogr.cp310-win_amd64.lib and object build\temp.win-amd64-cpython-310\Release\exte
  nsions\_ogr.cp310-win_amd64.exp
  Generating code
  Finished generating code
  Finished generating code
  "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x64\link.exe" /nologo /INCREMENTAL:NO /LTCG /DLL /MANIFEST
  :EMBED,ID=2 /MANIFESTUAC:NO /LIBPATH:C:/Users/hwhsu1231/Repo/testing/gdal/build/Release /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\libs /LIBPATH
  :C:\Python\Python310\libs /LIBPATH:C:\Python\Python310 /LIBPATH:C:\Users\hwhsu1231\Repo\testing\gdal\.venv\PCbuild\amd64 "/LIBPATH:C:\Program Files\Micro
  soft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MS
  VC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.
  22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Com
  munity\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/L
  IBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0
  \ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\
  10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\202
  2\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64
  " "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LI
  BPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\1
  4.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program File
  s\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C
  :\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um
  \x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\M
  SVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program
   Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files
   (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/
  LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Stu
  dio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Micros
  oft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Pro
  gram Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC
  \lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows K
  its\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10
  \\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Fil
  es\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
  Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022
  \Community\VC\Auxiliary\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windo
  ws Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:
  \Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\u
  m\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um
  \x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual St
  udio\2022\Community\VC\Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64"
  "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliar
  y\VS\UnitTest\lib" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\l
  ib\um\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\ATLMFC\lib\x64" "/LIBPATH:C:\Program Files\Microso
  ft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" "/LIBPATH:C:\Pr
  ogram Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22000.0\\um\x64" "/LIBPATH:C:\Pro
  gram Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC
  \Tools\MSVC\14.35.32215\atlmfc\lib\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x64" "/LIBPATH:C:\Program F
  iles (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x64" "/LIBPATH:C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib" "/L
  IBPATH:C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" "/LIBPATH:C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64" gdal.lib /E
  XPORT:PyInit__gdal build\temp.win-amd64-cpython-310\Release\extensions/gdal_wrap.obj /OUT:build\lib.win-amd64-cpython-310\osgeo\_gdal.cp310-win_amd64.pyd
   /IMPLIB:build\temp.win-amd64-cpython-310\Release\extensions\_gdal.cp310-win_amd64.lib
     Creating library build\temp.win-amd64-cpython-310\Release\extensions\_gdal.cp310-win_amd64.lib and object build\temp.win-amd64-cpython-310\Release\ext
  ensions\_gdal.cp310-win_amd64.exp
  Generating code
  Finished generating code
  Finished generating code
  Finished generating code
  Finished generating code
  copying build\lib.win-amd64-cpython-310\osgeo\_gdal.cp310-win_amd64.pyd -> osgeo
  copying build\lib.win-amd64-cpython-310\osgeo\_gdalconst.cp310-win_amd64.pyd -> osgeo
  copying build\lib.win-amd64-cpython-310\osgeo\_osr.cp310-win_amd64.pyd -> osgeo
  copying build\lib.win-amd64-cpython-310\osgeo\_ogr.cp310-win_amd64.pyd -> osgeo
  copying build\lib.win-amd64-cpython-310\osgeo\_gnm.cp310-win_amd64.pyd -> osgeo
  copying build\lib.win-amd64-cpython-310\osgeo\_gdal_array.cp310-win_amd64.pyd -> osgeo
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/swig/python/CMakeLists.txt
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/perftests/CMakeLists.txt
  bench_ogr_batch.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/perftests/Release/bench_ogr_batch.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/buil
  d/perftests/Release/bench_ogr_batch.exp
  bench_ogr_batch.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\perftests\Release\bench_ogr_batch.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/perftests/CMakeLists.txt
  bench_ogr_c_api.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/perftests/Release/bench_ogr_c_api.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/buil
  d/perftests/Release/bench_ogr_c_api.exp
  bench_ogr_c_api.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\perftests\Release\bench_ogr_c_api.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/CMakeLists.txt
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/googletest-src/googletest/CMakeLists.txt
  gtest-all.cc
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/lib/Release/gtest.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/build/lib/Release/gt
  est.exp
  gtest.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\bin\Release\gtest.dll
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  main_gtest.cpp
  main_gtest.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\main_gtest.lib
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  bug1488.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/bug1488.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/build/aut
  otest/cpp/Release/bug1488.exp
  bug1488.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\bug1488.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  gdal_unit_test.cpp
  test_alg.cpp
  test_cpl.cpp
  test_gdal.cpp
  test_gdal_aaigrid.cpp
  test_gdal_dted.cpp
  test_gdal_gtiff.cpp
  test_gdal_pixelfn.cpp
  test_ogr.cpp
  test_ogr_organize_polygons.cpp
  test_ogr_geometry_stealing.cpp
  test_ogr_lgpl.cpp
  test_ogr_geos.cpp
  test_ogr_shape.cpp
  test_ogr_swq.cpp
  test_ogr_wkb.cpp
  test_osr.cpp
  test_osr_pci.cpp
  test_osr_ct.cpp
  test_osr_proj4.cpp
  Generating Code...
  Compiling...
  test_triangulation.cpp
  test_utilities.cpp
  test_marching_squares_contour.cpp
  test_marching_squares_polygon.cpp
  test_marching_squares_square.cpp
  test_marching_squares_tile.cpp
  Generating Code...
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/gdal_unit_test.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/bu
  ild/autotest/cpp/Release/gdal_unit_test.exp
  gdal_unit_test.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\gdal_unit_test.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  gdallimits.c
  gdallimits.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\gdallimits.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  test_c_include_from_cpp_file.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/test_c_include_from_cpp_file.lib and object C:/Users/hwhsu1231/Repo/t
  esting/gdal/build/autotest/cpp/Release/test_c_include_from_cpp_file.exp
  test_c_include_from_cpp_file.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\test_c_include_from_cpp_file.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  test_deferred_plugin.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/test_deferred_plugin.lib and object C:/Users/hwhsu1231/Repo/testing/g
  dal/build/autotest/cpp/Release/test_deferred_plugin.exp
  test_deferred_plugin.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\test_deferred_plugin.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/fuzzers/tests/CMakeLists.txt
  test_gdal_fuzzer.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/fuzzers/tests/Release/test_gdal_fuzzer.lib and object C:/Users/hwhsu1231/Repo/testing/gdal
  /build/fuzzers/tests/Release/test_gdal_fuzzer.exp
  test_gdal_fuzzer.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\fuzzers\tests\Release\test_gdal_fuzzer.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  test_include_from_c_file.c
  test_include_from_c_file.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\test_include_from_c_file.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/fuzzers/tests/CMakeLists.txt
  test_ogr_fuzzer.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/fuzzers/tests/Release/test_ogr_fuzzer.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/
  build/fuzzers/tests/Release/test_ogr_fuzzer.exp
  test_ogr_fuzzer.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\fuzzers\tests\Release\test_ogr_fuzzer.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/fuzzers/tests/CMakeLists.txt
  test_osr_set_from_user_input_fuzzer.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/fuzzers/tests/Release/test_osr_set_from_user_input_fuzzer.lib and object C:/Users/hwhsu123
  1/Repo/testing/gdal/build/fuzzers/tests/Release/test_osr_set_from_user_input_fuzzer.exp
  test_osr_set_from_user_input_fuzzer.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\fuzzers\tests\Release\test_osr_set_from_user_input_fuzzer.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/fuzzers/tests/CMakeLists.txt
  test_wkb_import_fuzzer.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/fuzzers/tests/Release/test_wkb_import_fuzzer.lib and object C:/Users/hwhsu1231/Repo/testin
  g/gdal/build/fuzzers/tests/Release/test_wkb_import_fuzzer.exp
  test_wkb_import_fuzzer.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\fuzzers\tests\Release\test_wkb_import_fuzzer.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/fuzzers/tests/CMakeLists.txt
  test_wkt_import_fuzzer.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/fuzzers/tests/Release/test_wkt_import_fuzzer.lib and object C:/Users/hwhsu1231/Repo/testin
  g/gdal/build/fuzzers/tests/Release/test_wkt_import_fuzzer.exp
  test_wkt_import_fuzzer.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\fuzzers\tests\Release\test_wkt_import_fuzzer.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testsse.cpp
  testavx2.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testavx2.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testblockcache.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testblockcache.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/bu
  ild/autotest/cpp/Release/testblockcache.exp
  testblockcache.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testblockcache.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testblockcachelimits.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testblockcachelimits.lib and object C:/Users/hwhsu1231/Repo/testing/g
  dal/build/autotest/cpp/Release/testblockcachelimits.exp
  testblockcachelimits.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testblockcachelimits.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testblockcachewrite.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testblockcachewrite.lib and object C:/Users/hwhsu1231/Repo/testing/gd
  al/build/autotest/cpp/Release/testblockcachewrite.exp
  testblockcachewrite.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testblockcachewrite.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testclosedondestroydm.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testclosedondestroydm.lib and object C:/Users/hwhsu1231/Repo/testing/
  gdal/build/autotest/cpp/Release/testclosedondestroydm.exp
  testclosedondestroydm.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testclosedondestroydm.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testcopywords.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testcopywords.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/bui
  ld/autotest/cpp/Release/testcopywords.exp
  testcopywords.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testcopywords.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testdestroy.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testdestroy.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/build
  /autotest/cpp/Release/testdestroy.exp
  testdestroy.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testdestroy.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testlog.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testlog.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/build/aut
  otest/cpp/Release/testlog.exp
  testlog.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testlog.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testmultithreadedwriting.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testmultithreadedwriting.lib and object C:/Users/hwhsu1231/Repo/testi
  ng/gdal/build/autotest/cpp/Release/testmultithreadedwriting.exp
  testmultithreadedwriting.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testmultithreadedwriting.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/perftests/CMakeLists.txt
  testperfcopywords.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/perftests/Release/testperfcopywords.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/bu
  ild/perftests/Release/testperfcopywords.exp
  testperfcopywords.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\perftests\Release\testperfcopywords.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/perftests/CMakeLists.txt
  testperfdeinterleave.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/perftests/Release/testperfdeinterleave.lib and object C:/Users/hwhsu1231/Repo/testing/gdal
  /build/perftests/Release/testperfdeinterleave.exp
  testperfdeinterleave.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\perftests\Release\testperfdeinterleave.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testsse.cpp
  testsse2.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testsse2.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testsse.cpp
  testsse2_emulation.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testsse2_emulation.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testsse.cpp
  testsse4_1.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testsse4_1.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testsse.cpp
  testssse3.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testssse3.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testthreadcond.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testthreadcond.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/bu
  ild/autotest/cpp/Release/testthreadcond.exp
  testthreadcond.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testthreadcond.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/autotest/cpp/CMakeLists.txt
  testvirtualmem.cpp
     Creating library C:/Users/hwhsu1231/Repo/testing/gdal/build/autotest/cpp/Release/testvirtualmem.lib and object C:/Users/hwhsu1231/Repo/testing/gdal/bu
  ild/autotest/cpp/Release/testvirtualmem.exp
  testvirtualmem.vcxproj -> C:\Users\hwhsu1231\Repo\testing\gdal\build\autotest\cpp\Release\testvirtualmem.exe
  Building Custom Rule C:/Users/hwhsu1231/Repo/testing/gdal/CMakeLists.txt

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>cmake --install build --config Release
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalinfo
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal2tiles.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal2xyz.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdaladdo
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalbuildvrt
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_calc.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalchksum.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalcompare.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal-config
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_contour
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdaldem
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_edit.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalenhance
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_fillnodata.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_grid
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalident.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalimport.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdallocationinfo
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalmanage
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_merge.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalmove.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_polygonize.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_proximity.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_rasterize
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_retile.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_sieve.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalsrsinfo
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdaltindex
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdaltransform
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_translate
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdalwarp
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/ogr2ogr
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/ogrinfo
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/ogrlineref
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/ogrmerge.py
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/ogrtindex
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_viewshed
-- Installing C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/bash-completion/completions/gdal_create
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/gdalplugins/drivers.ini
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/gdal.lib
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/bin/gdal.dll
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_atomic_ops.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_auto_close.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_compressor.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_config_extras.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_conv.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_csv.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_error.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_hash_set.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_http.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_json.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cplkeywordparser.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_list.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_minixml.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_multiproc.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_port.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_progress.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_quad_tree.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_spawn.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_string.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_time.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_vsi.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_vsi_error.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_vsi_virtual.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_virtualmem.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_csv.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_odbc.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_alg.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_alg_priv.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalgrid.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalgrid_priv.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalwarper.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_simplesurf.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalpansharpen.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_api.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_recordbatch.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_core.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_feature.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_featurestyle.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_geocoding.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_geometry.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_geomcoordinateprecision.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_p.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_spatialref.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_swq.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogr_srs_api.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/ogrsf_frmts.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gnm.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gnm_api.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gnmgraph.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/memdataset.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/vrtdataset.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_vrt.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_version.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdaljp2metadata.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdaljp2abstractdataset.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_frmts.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_pam.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_priv.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_proxy.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_rat.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalcachedpixelaccessor.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/rawdataset.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalgeorefpamdataset.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_mdreader.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdalsubdatasetinfo.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/gdal_utils.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/include/cpl_config.h
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/LICENSE.TXT
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/cubewerx_extra.wkt
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/ecw_cs.wkt
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/epsg.wkt
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/esri_StatePlane_extra.wkt
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/ozi_datum.csv
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/ozi_ellips.csv
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/pci_datum.txt
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/pci_ellips.txt
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/stateplane.csv
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/gdalvrt.xsd
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/gdaltileindex.xsd
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/ogrvrt.xsd
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/tms_LINZAntarticaMapTileGrid.json
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/tms_MapML_APSTILE.json
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/tms_MapML_CBMTILE.json
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/tms_NZTM2000.json
-- Up-to-date: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/LICENSE.TXT
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/template_tiles.mapml
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/gdalinfo_output.schema.json
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/gdalmdiminfo_output.schema.json
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/ogrinfo_output.schema.json
-- Up-to-date: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/LICENSE.TXT
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/GDALLogoBW.svg
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/GDALLogoColor.svg
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/GDALLogoGS.svg
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/share/gdal/gdalicon.png
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/cmake/gdal/GDAL-targets.cmake
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/cmake/gdal/GDAL-targets-release.cmake
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/cmake/gdal/GDALConfigVersion.cmake
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/cmake/gdal/GDALConfig.cmake
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/bin/gdal-config
-- Installing: C:/Users/hwhsu1231/Repo/testing/gdal/.venv/lib/pkgconfig/gdal.pc

(C:\Users\hwhsu1231\Repo\testing\gdal\.conda) (.venv) C:\Users\hwhsu1231\Repo\testing\gdal>
```