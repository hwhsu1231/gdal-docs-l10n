
```
[build]   C:\Users\hwhsu1231\Repo\gdal-docs-l10n\.venv\lib\site-packages\setuptools\config\_apply_pyprojecttoml.py:103: _WouldIgnoreField: 'entry-points' defined outside of `pyproject.toml` would be ignored.
[build]       !!
[build]   
[build]   
[build]       ##########################################################################
[build]       # configuration would be ignored/result in error due to `pyproject.toml` #
[build]       ##########################################################################
[build]   
[build]       The following seems to be defined outside of `pyproject.toml`:
[build]   
[build]       `entry-points = {'console_scripts': [['rgb2pct = osgeo_utils.rgb2pct:main'], ['pct2rgb = osgeo_utils.pct2rgb:main'], ['ogrmerge = osgeo_utils.ogrmerge:main'], ['ogr_layer_algebra = osgeo_utils.ogr_layer_algebra:main'], ['gdalmove = osgeo_utils.gdalmove:main'], ['gdalcompare = osgeo_utils.gdalcompare:main'], ['gdalattachpct = osgeo_utils.gdalattachpct:main'], ['gdal_sieve = osgeo_utils.gdal_sieve:main'], ['gdal_retile = osgeo_utils.gdal_retile:main'], ['gdal_proximity = osgeo_utils.gdal_proximity:main'], ['gdal_polygonize = osgeo_utils.gdal_polygonize:main'], ['gdal_pansharpen = osgeo_utils.gdal_pansharpen:main'], ['gdal_merge = osgeo_utils.gdal_merge:main'], ['gdal_fillnodata = osgeo_utils.gdal_fillnodata:main'], ['gdal_edit = osgeo_utils.gdal_edit:main'], ['gdal_calc = osgeo_utils.gdal_calc:main'], ['gdal2xyz = osgeo_utils.gdal2xyz:main'], ['gdal2tiles = osgeo_utils.gdal2tiles:main']]}`
[build]   
[build]       According to the spec (see the link below), however, setuptools CANNOT
[build]       consider this value unless 'entry-points' is listed as `dynamic`.
[build]   
[build]       https://packaging.python.org/en/latest/specifications/declaring-project-metadata/
[build]   
[build]       For the time being, `setuptools` will still consider the given value (as a
[build]       **transitional** measure), but please note that future releases of setuptools will
[build]       follow strictly the standard.
[build]   
[build]       To prevent this warning, you can list 'entry-points' under `dynamic` or alternatively
[build]       remove the `[project]` table from your file and rely entirely on other means of
[build]       configuration.
[build]       
[build]   
[build]   !!
[build]       
[build]     warnings.warn(msg, _WouldIgnoreField)
```
