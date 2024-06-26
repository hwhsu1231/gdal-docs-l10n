<!DOCTYPE html>
<html class="writer-html5" lang="zh-TW">
<head>
  <meta charset="utf-8" /><meta name="viewport" content="width=device-width, initial-scale=1" />

  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>柵格驅動器 &mdash; GDAL  說明文件</title>
      <link rel="stylesheet" type="text/css" href="../../_static/pygments.css?v=d10597a4" />
      <link rel="stylesheet" type="text/css" href="../../_static/css/gdal.css?v=e152ac3b" />

  
    <link rel="shortcut icon" href="../../_static/favicon.png"/>
    <link rel="canonical" href="https://gdal.org/drivers/raster/index.html"/>
  <!--[if lt IE 9]>
    <script src="../../_static/js/html5shiv.min.js"></script>
  <![endif]-->
  
        <script src="../../_static/jquery.js?v=5d32c60e"></script>
        <script src="../../_static/_sphinx_javascript_frameworks_compat.js?v=2cd50e6c"></script>
        <script data-url_root="../../" id="documentation_options" src="../../_static/documentation_options.js?v=caa190f9"></script>
        <script src="../../_static/doctools.js?v=888ff710"></script>
        <script src="../../_static/sphinx_highlight.js?v=4825356b"></script>
        <script src="../../_static/translations.js?v=d9a6981e"></script>
    <script src="../../_static/js/theme.js"></script>
    <link rel="author" title="關於這些文件" href="../../about.html" />
    <link rel="index" title="索引" href="../../genindex.html" />
    <link rel="search" title="搜尋" href="../../search.html" />
    <link rel="next" title="AAIGrid -- Arc/Info ASCII Grid" href="aaigrid.html" />
    <link rel="prev" title="sozip" href="../../programs/sozip.html" /> 
</head>

<body class="wy-body-for-nav"> 
  <div class="wy-grid-for-nav">
    <nav data-toggle="wy-nav-shift" class="wy-nav-side">
      <div class="wy-side-scroll">
        <div class="wy-side-nav-search"  style="background: white" >

          
          
          <a href="../../index.html">
            
              <img src="../../_static/gdalicon.png" class="logo" alt="Logo"/>
          </a>
<div role="search">
  <form id="rtd-search-form" class="wy-form" action="../../search.html" method="get">
    <input type="text" name="q" placeholder="搜索文档" />
    <input type="hidden" name="check_keywords" value="yes" />
    <input type="hidden" name="area" value="default" />
  </form>
</div>
        </div><div class="wy-menu wy-menu-vertical" data-spy="affix" role="navigation" aria-label="导航菜单">
              <ul class="current">
<li class="toctree-l1"><a class="reference internal" href="../../download.html">下載</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../programs/index.html">程式</a></li>
<li class="toctree-l1 current"><a class="current reference internal" href="#">柵格驅動器</a><ul>
<li class="toctree-l2"><a class="reference internal" href="aaigrid.html">AAIGrid -- Arc/Info ASCII Grid</a></li>
<li class="toctree-l2"><a class="reference internal" href="ace2.html">ACE2 -- ACE2</a></li>
<li class="toctree-l2"><a class="reference internal" href="adrg.html">ADRG -- ADRG/ARC Digitized Raster Graphics (.gen/.thf)</a></li>
<li class="toctree-l2"><a class="reference internal" href="aig.html">AIG -- Arc/Info Binary Grid</a></li>
<li class="toctree-l2"><a class="reference internal" href="airsar.html">AIRSAR -- AIRSAR Polarimetric Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="bag.html">BAG -- Bathymetry Attributed Grid</a></li>
<li class="toctree-l2"><a class="reference internal" href="basisu.html">BASISU -- Basis Universal</a></li>
<li class="toctree-l2"><a class="reference internal" href="blx.html">BLX -- Magellan BLX Topo File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="bmp.html">BMP -- Microsoft Windows Device Independent Bitmap</a></li>
<li class="toctree-l2"><a class="reference internal" href="bsb.html">BSB -- Maptech/NOAA BSB Nautical Chart Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="bt.html">BT -- VTP .bt Binary Terrain Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="byn.html">BYN - Natural Resources Canada's Geoid file format (.byn)</a></li>
<li class="toctree-l2"><a class="reference internal" href="cad.html">CAD -- AutoCAD DWG raster layer</a></li>
<li class="toctree-l2"><a class="reference internal" href="cals.html">CALS -- CALS Type 1</a></li>
<li class="toctree-l2"><a class="reference internal" href="ceos.html">CEOS -- CEOS Image</a></li>
<li class="toctree-l2"><a class="reference internal" href="coasp.html">COASP --  DRDC COASP SAR Processor Raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="cog.html">COG -- Cloud Optimized GeoTIFF generator</a></li>
<li class="toctree-l2"><a class="reference internal" href="cosar.html">COSAR -- TerraSAR-X Complex SAR Data Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="cpg.html">CPG -- Convair PolGASP data</a></li>
<li class="toctree-l2"><a class="reference internal" href="ctable2.html">CTable2 -- CTable2 Datum Grid Shift</a></li>
<li class="toctree-l2"><a class="reference internal" href="ctg.html">CTG -- USGS LULC Composite Theme Grid</a></li>
<li class="toctree-l2"><a class="reference internal" href="daas.html">DAAS (Airbus DS Intelligence Data As A Service driver)</a></li>
<li class="toctree-l2"><a class="reference internal" href="dds.html">DDS -- DirectDraw Surface</a></li>
<li class="toctree-l2"><a class="reference internal" href="derived.html">DERIVED -- Derived subdatasets driver</a></li>
<li class="toctree-l2"><a class="reference internal" href="dimap.html">DIMAP -- Spot DIMAP</a></li>
<li class="toctree-l2"><a class="reference internal" href="dipex.html">DIPEx -- ELAS DIPEx</a></li>
<li class="toctree-l2"><a class="reference internal" href="doq1.html">DOQ1 -- First Generation USGS DOQ</a></li>
<li class="toctree-l2"><a class="reference internal" href="doq2.html">DOQ2 -- New Labelled USGS DOQ</a></li>
<li class="toctree-l2"><a class="reference internal" href="dted.html">DTED -- Military Elevation Data</a></li>
<li class="toctree-l2"><a class="reference internal" href="ecrgtoc.html">ECRGTOC -- ECRG Table Of Contents (TOC.xml)</a></li>
<li class="toctree-l2"><a class="reference internal" href="ecw.html">ECW -- Enhanced Compressed Wavelets (.ecw)</a></li>
<li class="toctree-l2"><a class="reference internal" href="eedai.html">EEDAI - Google Earth Engine Data API Image</a></li>
<li class="toctree-l2"><a class="reference internal" href="ehdr.html">EHdr -- ESRI .hdr Labelled</a></li>
<li class="toctree-l2"><a class="reference internal" href="eir.html">EIR -- Erdas Imagine Raw</a></li>
<li class="toctree-l2"><a class="reference internal" href="elas.html">ELAS - Earth Resources Laboratory Applications Software</a></li>
<li class="toctree-l2"><a class="reference internal" href="envi.html">ENVI -- ENVI .hdr Labelled Raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="esat.html">ESAT -- Envisat Image Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="esric.html">ESRIC -- Esri Compact Cache</a></li>
<li class="toctree-l2"><a class="reference internal" href="ers.html">ERS -- ERMapper .ERS</a></li>
<li class="toctree-l2"><a class="reference internal" href="exr.html">EXR -- Extended Dynamic Range Image File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="fast.html">FAST -- EOSAT FAST Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="fit.html">FIT -- FIT</a></li>
<li class="toctree-l2"><a class="reference internal" href="fits.html">FITS -- Flexible Image Transport System</a></li>
<li class="toctree-l2"><a class="reference internal" href="genbin.html">GenBin -- Generic Binary (.hdr labelled)</a></li>
<li class="toctree-l2"><a class="reference internal" href="georaster.html">Oracle Spatial GeoRaster</a></li>
<li class="toctree-l2"><a class="reference internal" href="gff.html">GFF -- Sandia National Laboratories GSAT File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="gif.html">GIF -- Graphics Interchange Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="gpkg.html">GPKG -- GeoPackage raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="grass.html">GRASS Raster Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="grassasciigrid.html">GRASSASCIIGrid -- GRASS ASCII Grid</a></li>
<li class="toctree-l2"><a class="reference internal" href="grib.html">GRIB -- WMO General Regularly-distributed Information in Binary form</a></li>
<li class="toctree-l2"><a class="reference internal" href="gs7bg.html">GS7BG -- Golden Software Surfer 7 Binary Grid File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="gsag.html">GSAG -- Golden Software ASCII Grid File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="gsbg.html">GSBG -- Golden Software Binary Grid File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="gsc.html">GSC -- GSC Geogrid</a></li>
<li class="toctree-l2"><a class="reference internal" href="gta.html">GTA - Generic Tagged Arrays</a></li>
<li class="toctree-l2"><a class="reference internal" href="gti.html">GTI -- GDAL Raster Tile Index</a></li>
<li class="toctree-l2"><a class="reference internal" href="gtiff.html">GTiff -- GeoTIFF File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="gxf.html">GXF -- Grid eXchange File</a></li>
<li class="toctree-l2"><a class="reference internal" href="hdf4.html">HDF4 -- Hierarchical Data Format Release 4 (HDF4)</a></li>
<li class="toctree-l2"><a class="reference internal" href="hdf5.html">HDF5 -- Hierarchical Data Format Release 5 (HDF5)</a></li>
<li class="toctree-l2"><a class="reference internal" href="heif.html">HEIF / HEIC -- ISO/IEC 23008-12:2017 High Efficiency Image File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="hf2.html">HF2 -- HF2/HFZ heightfield raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="hfa.html">HFA -- Erdas Imagine .img</a></li>
<li class="toctree-l2"><a class="reference internal" href="Idrisi.html">RST -- Idrisi Raster Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="ilwis.html">ILWIS -- Raster Map</a></li>
<li class="toctree-l2"><a class="reference internal" href="iris.html">IRIS -- Vaisala's weather radar software format</a></li>
<li class="toctree-l2"><a class="reference internal" href="isce.html">ISCE -- ISCE</a></li>
<li class="toctree-l2"><a class="reference internal" href="isg.html">ISG -- International Service for the Geoid</a></li>
<li class="toctree-l2"><a class="reference internal" href="isis2.html">ISIS2 -- USGS Astrogeology ISIS Cube (Version 2)</a></li>
<li class="toctree-l2"><a class="reference internal" href="isis3.html">ISIS3 -- USGS Astrogeology ISIS Cube (Version 3)</a></li>
<li class="toctree-l2"><a class="reference internal" href="jdem.html">JDEM -- Japanese DEM (.mem)</a></li>
<li class="toctree-l2"><a class="reference internal" href="jp2ecw.html">JP2ECW -- ERDAS JPEG2000 (.jp2)</a></li>
<li class="toctree-l2"><a class="reference internal" href="jp2kak.html">JP2KAK -- JPEG 2000 (based on Kakadu SDK)</a></li>
<li class="toctree-l2"><a class="reference internal" href="jp2lura.html">JP2Lura -- JPEG2000 driver based on Lurawave library</a></li>
<li class="toctree-l2"><a class="reference internal" href="jp2mrsid.html">JP2MrSID -- JPEG2000 via MrSID SDK</a></li>
<li class="toctree-l2"><a class="reference internal" href="jp2openjpeg.html">JP2OpenJPEG -- JPEG2000 driver based on OpenJPEG library</a></li>
<li class="toctree-l2"><a class="reference internal" href="jpeg.html">JPEG -- JPEG JFIF File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="jpegxl.html">JPEGXL -- JPEG-XL File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="jpipkak.html">JPIPKAK - JPIP Streaming</a></li>
<li class="toctree-l2"><a class="reference internal" href="kea.html">KEA</a></li>
<li class="toctree-l2"><a class="reference internal" href="kmlsuperoverlay.html">KMLSuperoverlay -- KMLSuperoverlay</a></li>
<li class="toctree-l2"><a class="reference internal" href="kro.html">KRO -- KOLOR Raw format</a></li>
<li class="toctree-l2"><a class="reference internal" href="ktx2.html">KTX2</a></li>
<li class="toctree-l2"><a class="reference internal" href="lan.html">LAN -- Erdas 7.x .LAN and .GIS</a></li>
<li class="toctree-l2"><a class="reference internal" href="l1b.html">L1B -- NOAA Polar Orbiter Level 1b Data Set (AVHRR)</a></li>
<li class="toctree-l2"><a class="reference internal" href="lcp.html">LCP -- FARSITE v.4 LCP Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="leveller.html">Leveller -- Daylon Leveller Heightfield</a></li>
<li class="toctree-l2"><a class="reference internal" href="loslas.html">LOSLAS -- NADCON .los/.las Datum Grid Shift</a></li>
<li class="toctree-l2"><a class="reference internal" href="map.html">MAP -- OziExplorer .MAP</a></li>
<li class="toctree-l2"><a class="reference internal" href="marfa.html">MRF -- Meta Raster Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="mbtiles.html">MBTiles</a></li>
<li class="toctree-l2"><a class="reference internal" href="mem.html">MEM -- In Memory Raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="mff.html">MFF -- Vexcel MFF Raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="mff2.html">MFF2 -- Vexcel MFF2 Image</a></li>
<li class="toctree-l2"><a class="reference internal" href="mrsid.html">MrSID -- Multi-resolution Seamless Image Database</a></li>
<li class="toctree-l2"><a class="reference internal" href="msg.html">MSG -- Meteosat Second Generation</a></li>
<li class="toctree-l2"><a class="reference internal" href="msgn.html">MSGN -- Meteosat Second Generation (MSG) Native Archive Format (.nat)</a></li>
<li class="toctree-l2"><a class="reference internal" href="ndf.html">NDF -- NLAPS Data Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="netcdf.html">NetCDF: Network Common Data Form</a></li>
<li class="toctree-l2"><a class="reference internal" href="ngsgeoid.html">NGSGEOID - NOAA NGS Geoid Height Grids</a></li>
<li class="toctree-l2"><a class="reference internal" href="ngw.html">NGW -- NextGIS Web</a></li>
<li class="toctree-l2"><a class="reference internal" href="nitf.html">NITF -- National Imagery Transmission Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="noaa_b.html">NOAA_B -- NOAA GEOCON/NADCON5 .b format</a></li>
<li class="toctree-l2"><a class="reference internal" href="nsidcbin.html">NSIDCbin -- National Snow and Ice Data Centre Sea Ice Concentrations</a></li>
<li class="toctree-l2"><a class="reference internal" href="ntv2.html">NTv2 -- NTv2 Datum Grid Shift</a></li>
<li class="toctree-l2"><a class="reference internal" href="nwtgrd.html">NWT_GRD/NWT_GRC -- Northwood/Vertical Mapper File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="ogcapi.html">OGCAPI -- OGC API Tiles / Maps / Coverage</a></li>
<li class="toctree-l2"><a class="reference internal" href="openfilegdb.html">ESRI File Geodatabase raster (OpenFileGDB)</a></li>
<li class="toctree-l2"><a class="reference internal" href="ozi.html">OZI -- OZF2/OZFX3 raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="palsar.html">JAXA PALSAR Processed Products</a></li>
<li class="toctree-l2"><a class="reference internal" href="paux.html">PAux -- PCI .aux Labelled Raw Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="pcidsk.html">PCIDSK -- PCI Geomatics Database File</a></li>
<li class="toctree-l2"><a class="reference internal" href="pcraster.html">PCRaster -- PCRaster raster file format</a></li>
<li class="toctree-l2"><a class="reference internal" href="pdf.html">PDF -- Geospatial PDF</a></li>
<li class="toctree-l2"><a class="reference internal" href="pds.html">PDS -- Planetary Data System v3</a></li>
<li class="toctree-l2"><a class="reference internal" href="pds4.html">PDS4 -- NASA Planetary Data System (Version 4)</a></li>
<li class="toctree-l2"><a class="reference internal" href="plmosaic.html">PLMosaic (Planet Labs Mosaics API)</a></li>
<li class="toctree-l2"><a class="reference internal" href="png.html">PNG -- Portable Network Graphics</a></li>
<li class="toctree-l2"><a class="reference internal" href="pnm.html">PNM -- Netpbm (.pgm, .ppm)</a></li>
<li class="toctree-l2"><a class="reference internal" href="postgisraster.html">PostGISRaster -- PostGIS Raster driver</a></li>
<li class="toctree-l2"><a class="reference internal" href="prf.html">PHOTOMOD Raster File</a></li>
<li class="toctree-l2"><a class="reference internal" href="rasterlite.html">Rasterlite - Rasters in SQLite DB</a></li>
<li class="toctree-l2"><a class="reference internal" href="rasterlite2.html">RasterLite2 - Rasters in SQLite DB</a></li>
<li class="toctree-l2"><a class="reference internal" href="r.html">R -- R Object Data Store</a></li>
<li class="toctree-l2"><a class="reference internal" href="rdb.html">RDB - <em>RIEGL</em> Database</a></li>
<li class="toctree-l2"><a class="reference internal" href="rik.html">RIK -- Swedish Grid Maps</a></li>
<li class="toctree-l2"><a class="reference internal" href="rmf.html">RMF -- Raster Matrix Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="roi_pac.html">ROI_PAC -- ROI_PAC</a></li>
<li class="toctree-l2"><a class="reference internal" href="rpftoc.html">RPFTOC -- Raster Product Format/RPF (a.toc)</a></li>
<li class="toctree-l2"><a class="reference internal" href="rraster.html">RRASTER -- R Raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="rs2.html">RS2 -- RadarSat 2 XML Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="s102.html">S102 -- S-102 Bathymetric Surface Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="s104.html">S104 -- S-104 Water Level Information for Surface Navigation Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="s111.html">S111 -- S-111 Surface Currents Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="safe.html">SAFE -- Sentinel-1 SAFE XML Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="sar_ceos.html">SAR_CEOS -- CEOS SAR Image</a></li>
<li class="toctree-l2"><a class="reference internal" href="sdat.html">SAGA -- SAGA GIS Binary Grid File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="sdts.html">SDTS -- USGS SDTS DEM</a></li>
<li class="toctree-l2"><a class="reference internal" href="sentinel2.html">SENTINEL2 -- Sentinel-2 Products</a></li>
<li class="toctree-l2"><a class="reference internal" href="sgi.html">SGI -- SGI Image Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="sigdem.html">SIGDEM -- Scaled Integer Gridded DEM</a></li>
<li class="toctree-l2"><a class="reference internal" href="snodas.html">SNODAS -- Snow Data Assimilation System</a></li>
<li class="toctree-l2"><a class="reference internal" href="srp.html">SRP -- Standard Product Format (ASRP/USRP) (.gen)</a></li>
<li class="toctree-l2"><a class="reference internal" href="srtmhgt.html">SRTMHGT -- SRTM HGT Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="stacit.html">STACIT - Spatio-Temporal Asset Catalog Items</a></li>
<li class="toctree-l2"><a class="reference internal" href="stacta.html">STACTA - Spatio-Temporal Asset Catalog Tiled Assets</a></li>
<li class="toctree-l2"><a class="reference internal" href="terragen.html">Terragen -- Terragen™ Terrain File</a></li>
<li class="toctree-l2"><a class="reference internal" href="tga.html">TGA -- TARGA Image File Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="til.html">TIL -- EarthWatch/DigitalGlobe .TIL</a></li>
<li class="toctree-l2"><a class="reference internal" href="tiledb.html">TileDB - TileDB raster</a></li>
<li class="toctree-l2"><a class="reference internal" href="tsx.html">TSX --  TerraSAR-X Product</a></li>
<li class="toctree-l2"><a class="reference internal" href="usgsdem.html">USGSDEM -- USGS ASCII DEM (and CDED)</a></li>
<li class="toctree-l2"><a class="reference internal" href="vicar.html">VICAR -- VICAR</a></li>
<li class="toctree-l2"><a class="reference internal" href="vrt.html">VRT -- GDAL Virtual Format</a></li>
<li class="toctree-l2"><a class="reference internal" href="wcs.html">WCS -- OGC Web Coverage Service</a></li>
<li class="toctree-l2"><a class="reference internal" href="webp.html">WEBP - WEBP</a></li>
<li class="toctree-l2"><a class="reference internal" href="wms.html">WMS -- Web Map Services</a></li>
<li class="toctree-l2"><a class="reference internal" href="wmts.html">WMTS -- OGC Web Map Tile Service</a></li>
<li class="toctree-l2"><a class="reference internal" href="xpm.html">XPM -- X11 Pixmap</a></li>
<li class="toctree-l2"><a class="reference internal" href="xyz.html">XYZ -- ASCII Gridded XYZ</a></li>
<li class="toctree-l2"><a class="reference internal" href="zarr.html">Zarr</a></li>
<li class="toctree-l2"><a class="reference internal" href="zmap.html">ZMap -- ZMap Plus Grid</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="../vector/index.html">向量驅動器</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../user/index.html">使用者</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../api/index.html">API</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../tutorials/index.html">Tutorials</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../development/index.html">Development</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../community/index.html">社群</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../sponsors/index.html">Sponsors</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../contributing/index.html">How to contribute?</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../faq.html">常見問題</a></li>
<li class="toctree-l1"><a class="reference internal" href="../../license.html">授權條款</a></li>
</ul>

        </div>
      </div>
    </nav>

    <section data-toggle="wy-nav-shift" class="wy-nav-content-wrap"><nav class="wy-nav-top" aria-label="移动版导航菜单"  style="background: white" >
          <i data-toggle="wy-nav-top" class="fa fa-bars"></i>
          <a href="../../index.html">GDAL</a>
      </nav>

      <div class="wy-nav-content">
        <div class="rst-content">
          















<div role="navigation" aria-label="breadcrumbs navigation">

  <ul class="wy-breadcrumbs">
    
      <li><a href="../../index.html"> GDAL  說明文件 </a> &raquo;</li>
      
      <li>柵格驅動器</li>
    

    
      <li class="wy-breadcrumbs-aside">
        
            
            
              <a href="https://github.com/OSGeo/gdal/edit/master/doc/source/drivers/raster/index.rst" class="fa fa-github"> 在 GitHub 上编辑</a>
            
          
        
      </li>
    
  </ul>

  
  <div class="rst-breadcrumbs-buttons" role="navigation" aria-label="breadcrumb navigation">
      
        <a href="aaigrid.html" class="btn btn-neutral float-right" title="AAIGrid -- Arc/Info ASCII Grid" accesskey="n">Next <span class="fa fa-arrow-circle-right"></span></a>
      
      
        <a href="../../programs/sozip.html" class="btn btn-neutral float-left" title="sozip" accesskey="p"><span class="fa fa-arrow-circle-left"></span> Previous</a>
      
  </div>
  
  <hr/>
</div>
          <div role="main" class="document" itemscope="itemscope" itemtype="http://schema.org/Article">
           <div itemprop="articleBody">
             
  <section id="raster-drivers">
<span id="id1"></span><h1>柵格驅動器<a class="headerlink" href="#raster-drivers" title="本標頭的永久連結"></a></h1>
<table class="docutils align-default">
<colgroup>
<col style="width: 10.0%" />
<col style="width: 35.0%" />
<col style="width: 10.0%" />
<col style="width: 10.0%" />
<col style="width: 10.0%" />
<col style="width: 25.0%" />
</colgroup>
<thead>
<tr class="row-odd"><th class="head"><p>Short name</p></th>
<th class="head"><p>Long name</p></th>
<th class="head"><p>Creation (1)</p></th>
<th class="head"><p>Copy (2)</p></th>
<th class="head"><p>Geo-referencing</p></th>
<th class="head"><p>Build requirements</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><p><a class="reference internal" href="aaigrid.html#raster-aaigrid"><span class="std std-ref">AAIGrid</span></a></p></td>
<td><p>Arc/Info ASCII Grid</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ace2.html#raster-ace2"><span class="std std-ref">ACE2</span></a></p></td>
<td><p>ACE2</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="adrg.html#raster-adrg"><span class="std std-ref">ADRG</span></a></p></td>
<td><p>ADRG/ARC Digitized Raster Graphics (.gen/.thf)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="aig.html#raster-aig"><span class="std std-ref">AIG</span></a></p></td>
<td><p>Arc/Info Binary Grid</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="airsar.html#raster-airsar"><span class="std std-ref">AIRSAR</span></a></p></td>
<td><p>AIRSAR Polarimetric Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="bag.html#raster-bag"><span class="std std-ref">BAG</span></a></p></td>
<td><p>Bathymetry Attributed Grid</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libhdf5</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="basisu.html#raster-basisu"><span class="std std-ref">BASISU</span></a></p></td>
<td><p>Basis Universal</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Basis Universal</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="blx.html#raster-blx"><span class="std std-ref">BLX</span></a></p></td>
<td><p>Magellan BLX Topo File Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="bmp.html#raster-bmp"><span class="std std-ref">BMP</span></a></p></td>
<td><p>Microsoft Windows Device Independent Bitmap</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="bsb.html#raster-bsb"><span class="std std-ref">BSB</span></a></p></td>
<td><p>Maptech/NOAA BSB Nautical Chart Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="bt.html#raster-bt"><span class="std std-ref">BT</span></a></p></td>
<td><p>VTP .bt Binary Terrain Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="byn.html#raster-byn"><span class="std std-ref">BYN</span></a></p></td>
<td><p>Natural Resources Canada's Geoid file format (.byn)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="cad.html#raster-cad"><span class="std std-ref">CAD</span></a></p></td>
<td><p>AutoCAD DWG raster layer</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>(internal libopencad provided)</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="cals.html#raster-cals"><span class="std std-ref">CALS</span></a></p></td>
<td><p>CALS Type 1</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ceos.html#raster-ceos"><span class="std std-ref">CEOS</span></a></p></td>
<td><p>CEOS Image</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="coasp.html#raster-coasp"><span class="std std-ref">COASP</span></a></p></td>
<td><p>DRDC COASP SAR Processor Raster</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="cog.html#raster-cog"><span class="std std-ref">COG</span></a></p></td>
<td><p>Cloud Optimized GeoTIFF generator</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="cosar.html#raster-cosar"><span class="std std-ref">COSAR</span></a></p></td>
<td><p>TerraSAR-X Complex SAR Data Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="cpg.html#raster-cpg"><span class="std std-ref">CPG</span></a></p></td>
<td><p>Convair PolGASP data</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ctable2.html#raster-ctable2"><span class="std std-ref">CTable2</span></a></p></td>
<td><p>CTable2 Datum Grid Shift</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ctg.html#raster-ctg"><span class="std std-ref">CTG</span></a></p></td>
<td><p>USGS LULC Composite Theme Grid</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="daas.html#raster-daas"><span class="std std-ref">DAAS</span></a></p></td>
<td><p>DAAS (Airbus DS Intelligence Data As A Service driver)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="dds.html#raster-dds"><span class="std std-ref">DDS</span></a></p></td>
<td><p>DirectDraw Surface</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Crunch Lib</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="derived.html#raster-derived"><span class="std std-ref">DERIVED</span></a></p></td>
<td><p>Derived subdatasets driver</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="dimap.html#raster-dimap"><span class="std std-ref">DIMAP</span></a></p></td>
<td><p>Spot DIMAP</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="dipex.html#raster-dipex"><span class="std std-ref">DIPEx</span></a></p></td>
<td><p>ELAS DIPEx</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="doq1.html#raster-doq1"><span class="std std-ref">DOQ1</span></a></p></td>
<td><p>First Generation USGS DOQ</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="doq2.html#raster-doq2"><span class="std std-ref">DOQ2</span></a></p></td>
<td><p>New Labelled USGS DOQ</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="dted.html#raster-dted"><span class="std std-ref">DTED</span></a></p></td>
<td><p>Military Elevation Data</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ecrgtoc.html#raster-ecrgtoc"><span class="std std-ref">ECRGTOC</span></a></p></td>
<td><p>ECRG Table Of Contents (TOC.xml)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ecw.html#raster-ecw"><span class="std std-ref">ECW</span></a></p></td>
<td><p>Enhanced Compressed Wavelets (.ecw)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>ECW SDK</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="eedai.html#raster-eedai"><span class="std std-ref">EEDAI</span></a></p></td>
<td><p>Google Earth Engine Data API Image</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ehdr.html#raster-ehdr"><span class="std std-ref">EHdr</span></a></p></td>
<td><p>ESRI .hdr Labelled</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="eir.html#raster-eir"><span class="std std-ref">EIR</span></a></p></td>
<td><p>Erdas Imagine Raw</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="elas.html#raster-elas"><span class="std std-ref">ELAS</span></a></p></td>
<td><p>Earth Resources Laboratory Applications Software</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="envi.html#raster-envi"><span class="std std-ref">ENVI</span></a></p></td>
<td><p>ENVI .hdr Labelled Raster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ers.html#raster-ers"><span class="std std-ref">ERS</span></a></p></td>
<td><p>ERMapper .ERS</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="esat.html#raster-esat"><span class="std std-ref">ESAT</span></a></p></td>
<td><p>Envisat Image Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="esric.html#raster-esric"><span class="std std-ref">ESRIC</span></a></p></td>
<td><p>Esri Compact Cache</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="exr.html#raster-exr"><span class="std std-ref">EXR</span></a></p></td>
<td><p>Extended Dynamic Range Image File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libopenexr</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="fast.html#raster-fast"><span class="std std-ref">FAST</span></a></p></td>
<td><p>EOSAT FAST Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="fit.html#raster-fit"><span class="std std-ref">FIT</span></a></p></td>
<td><p>FIT</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="fits.html#raster-fits"><span class="std std-ref">FITS</span></a></p></td>
<td><p>Flexible Image Transport System</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcfitsio</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="genbin.html#raster-genbin"><span class="std std-ref">GenBin</span></a></p></td>
<td><p>Generic Binary (.hdr labelled)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="georaster.html#raster-georaster"><span class="std std-ref">GeoRaster</span></a></p></td>
<td><p>Oracle Spatial GeoRaster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Oracle client libraries</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="gff.html#raster-gff"><span class="std std-ref">GFF</span></a></p></td>
<td><p>Sandia National Laboratories GSAT File Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="gif.html#raster-gif"><span class="std std-ref">GIF</span></a></p></td>
<td><p>Graphics Interchange Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>(internal GIF library provided)</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="gpkg.html#raster-gpkg"><span class="std std-ref">GPKG</span></a></p></td>
<td><p>GeoPackage raster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libsqlite3 (and any or all of PNG, JPEG, WEBP drivers)</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="grass.html#raster-grass"><span class="std std-ref">GRASS</span></a></p></td>
<td><p>GRASS Raster Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>gdal-grass-driver</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="grassasciigrid.html#raster-grassasciigrid"><span class="std std-ref">GRASSASCIIGrid</span></a></p></td>
<td><p>GRASS ASCII Grid</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="grib.html#raster-grib"><span class="std std-ref">GRIB</span></a></p></td>
<td><p>WMO General Regularly-distributed Information in Binary form</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="gs7bg.html#raster-gs7bg"><span class="std std-ref">GS7BG</span></a></p></td>
<td><p>Golden Software Surfer 7 Binary Grid File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="gsag.html#raster-gsag"><span class="std std-ref">GSAG</span></a></p></td>
<td><p>Golden Software ASCII Grid File Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="gsbg.html#raster-gsbg"><span class="std std-ref">GSBG</span></a></p></td>
<td><p>Golden Software Binary Grid File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="gsc.html#raster-gsc"><span class="std std-ref">GSC</span></a></p></td>
<td><p>GSC Geogrid</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="gta.html#raster-gta"><span class="std std-ref">GTA</span></a></p></td>
<td><p>Generic Tagged Arrays</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libgta</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="gti.html#raster-gti"><span class="std std-ref">GTI</span></a></p></td>
<td><p>GDAL Raster Tile Index</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="gtiff.html#raster-gtiff"><span class="std std-ref">GTiff</span></a></p></td>
<td><p>GeoTIFF File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="gxf.html#raster-gxf"><span class="std std-ref">GXF</span></a></p></td>
<td><p>Grid eXchange File</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="hdf4.html#raster-hdf4"><span class="std std-ref">HDF4</span></a></p></td>
<td><p>Hierarchical Data Format Release 4 (HDF4)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libdf</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="hdf5.html#raster-hdf5"><span class="std std-ref">HDF5</span></a></p></td>
<td><p>Hierarchical Data Format Release 5 (HDF5)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libhdf5</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="heif.html#raster-heif"><span class="std std-ref">HEIF</span></a></p></td>
<td><p>ISO/IEC 23008-12:2017 High Efficiency Image File Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>libheif (&gt;= 1.1), built against libde265</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="hf2.html#raster-hf2"><span class="std std-ref">HF2</span></a></p></td>
<td><p>HF2/HFZ heightfield raster</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="hfa.html#raster-hfa"><span class="std std-ref">HFA</span></a></p></td>
<td><p>Erdas Imagine .img</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="Idrisi.html#raster-idrisi"><span class="std std-ref">RST</span></a></p></td>
<td><p>Idrisi Raster Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ilwis.html#raster-ilwis"><span class="std std-ref">ILWIS</span></a></p></td>
<td><p>Raster Map</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="iris.html#raster-iris"><span class="std std-ref">IRIS</span></a></p></td>
<td><p>Vaisala's weather radar software format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="isce.html#raster-isce"><span class="std std-ref">ISCE</span></a></p></td>
<td><p>ISCE</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="isg.html#raster-isg"><span class="std std-ref">ISG</span></a></p></td>
<td><p>International Service for the Geoid</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="isis2.html#raster-isis2"><span class="std std-ref">ISIS2</span></a></p></td>
<td><p>USGS Astrogeology ISIS Cube (Version 2)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="isis3.html#raster-isis3"><span class="std std-ref">ISIS3</span></a></p></td>
<td><p>USGS Astrogeology ISIS Cube (Version 3)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="jdem.html#raster-jdem"><span class="std std-ref">JDEM</span></a></p></td>
<td><p>Japanese DEM (.mem)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="jp2ecw.html#raster-jp2ecw"><span class="std std-ref">JP2ECW</span></a></p></td>
<td><p>ERDAS JPEG2000 (.jp2)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>ECW SDK</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="jp2kak.html#raster-jp2kak"><span class="std std-ref">JP2KAK</span></a></p></td>
<td><p>JPEG 2000 (based on Kakadu SDK)</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Kakadu SDK</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="jp2lura.html#raster-jp2lura"><span class="std std-ref">JP2LURA</span></a></p></td>
<td><p>JPEG2000 driver based on Lurawave library</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Lurawave library</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="jp2mrsid.html#raster-jp2mrsid"><span class="std std-ref">JP2MrSID</span></a></p></td>
<td><p>JPEG2000 via MrSID SDK</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>MrSID SDK</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="jp2openjpeg.html#raster-jp2openjpeg"><span class="std std-ref">JP2OpenJPEG</span></a></p></td>
<td><p>JPEG2000 driver based on OpenJPEG library</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>openjpeg &gt;= 2.1</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="jpeg.html#raster-jpeg"><span class="std std-ref">JPEG</span></a></p></td>
<td><p>JPEG JFIF File Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>(internal libjpeg provided)</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="jpegxl.html#raster-jpegxl"><span class="std std-ref">JPEGXL</span></a></p></td>
<td><p>JPEG-XL File Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libjxl</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="jpipkak.html#raster-jpipkak"><span class="std std-ref">JPIPKAK</span></a></p></td>
<td><p>JPIP Streaming</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Kakadu library</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="kea.html#raster-kea"><span class="std std-ref">KEA</span></a></p></td>
<td><p>KEA</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libkea and libhdf5 libraries</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="kmlsuperoverlay.html#raster-kmlsuperoverlay"><span class="std std-ref">KMLSuperoverlay</span></a></p></td>
<td><p>KMLSuperoverlay</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="kro.html#raster-kro"><span class="std std-ref">KRO</span></a></p></td>
<td><p>KOLOR Raw format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ktx2.html#raster-ktx2"><span class="std std-ref">KTX2</span></a></p></td>
<td><p>KTX2</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Basis Universal</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="l1b.html#raster-l1b"><span class="std std-ref">L1B</span></a></p></td>
<td><p>NOAA Polar Orbiter Level 1b Data Set (AVHRR)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="lan.html#raster-lan"><span class="std std-ref">LAN</span></a></p></td>
<td><p>Erdas 7.x .LAN and .GIS</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="lcp.html#raster-lcp"><span class="std std-ref">LCP</span></a></p></td>
<td><p>FARSITE v.4 LCP Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="leveller.html#raster-leveller"><span class="std std-ref">Leveller</span></a></p></td>
<td><p>Daylon Leveller Heightfield</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="loslas.html#raster-loslas"><span class="std std-ref">LOSLAS</span></a></p></td>
<td><p>NADCON .los/.las Datum Grid Shift</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="map.html#raster-map"><span class="std std-ref">MAP</span></a></p></td>
<td><p>OziExplorer .MAP</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="marfa.html#raster-marfa"><span class="std std-ref">MRF</span></a></p></td>
<td><p>Meta Raster Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="mbtiles.html#raster-mbtiles"><span class="std std-ref">MBTiles</span></a></p></td>
<td><p>MBTiles</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libsqlite3</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="mem.html#raster-mem"><span class="std std-ref">MEM</span></a></p></td>
<td><p>In Memory Raster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="mff.html#raster-mff"><span class="std std-ref">MFF</span></a></p></td>
<td><p>Vexcel MFF Raster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="mff2.html#raster-mff2"><span class="std std-ref">MFF2</span></a></p></td>
<td><p>Vexcel MFF2 Image</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="mrsid.html#raster-mrsid"><span class="std std-ref">MrSID</span></a></p></td>
<td><p>Multi-resolution Seamless Image Database</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>MrSID SDK</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="msg.html#raster-msg"><span class="std std-ref">MSG</span></a></p></td>
<td><p>Meteosat Second Generation</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>msg library</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="msgn.html#raster-msgn"><span class="std std-ref">MSGN</span></a></p></td>
<td><p>Meteosat Second Generation (MSG) Native Archive Format (.nat)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ndf.html#raster-ndf"><span class="std std-ref">NDF</span></a></p></td>
<td><p>NLAPS Data Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="netcdf.html#raster-netcdf"><span class="std std-ref">netCDF</span></a></p></td>
<td><p>NetCDF: Network Common Data Form</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libnetcdf</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ngsgeoid.html#raster-ngsgeoid"><span class="std std-ref">NGSGEOID</span></a></p></td>
<td><p>NOAA NGS Geoid Height Grids</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ngw.html#raster-ngw"><span class="std std-ref">NGW</span></a></p></td>
<td><p>NextGIS Web</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="nitf.html#raster-nitf"><span class="std std-ref">NITF</span></a></p></td>
<td><p>National Imagery Transmission Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="noaa_b.html#raster-noaa-b"><span class="std std-ref">NOAA_B</span></a></p></td>
<td><p>NOAA GEOCON/NADCON5 .b format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="nsidcbin.html#raster-nsidcbin"><span class="std std-ref">NSIDCbin</span></a></p></td>
<td><p>National Snow and Ice Data Centre Sea Ice Concentrations</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="ntv2.html#raster-ntv2"><span class="std std-ref">NTv2</span></a></p></td>
<td><p>NTv2 Datum Grid Shift</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="nwtgrd.html#raster-nwtgrd"><span class="std std-ref">NWT_GRD</span></a></p></td>
<td><p>Northwood/Vertical Mapper File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="nwtgrd.html#raster-nwtgrd"><span class="std std-ref">NWT_GRC</span></a></p></td>
<td><p>Northwood/Vertical Mapper File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ogcapi.html#raster-ogcapi"><span class="std std-ref">OGCAPI</span></a></p></td>
<td><p>OGC API Tiles / Maps / Coverage</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="openfilegdb.html#raster-openfilegdb"><span class="std std-ref">OpenFileGDB</span></a></p></td>
<td><p>ESRI File Geodatabase raster (OpenFileGDB)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="ozi.html#raster-ozi"><span class="std std-ref">OZI</span></a></p></td>
<td><p>OZF2/OZFX3 raster</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="palsar.html#raster-palsar"><span class="std std-ref">JAXAPALSAR</span></a></p></td>
<td><p>JAXA PALSAR Processed Products</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="paux.html#raster-paux"><span class="std std-ref">PAux</span></a></p></td>
<td><p>PCI .aux Labelled Raw Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="pcidsk.html#raster-pcidsk"><span class="std std-ref">PCIDSK</span></a></p></td>
<td><p>PCI Geomatics Database File</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="pcraster.html#raster-pcraster"><span class="std std-ref">PCRaster</span></a></p></td>
<td><p>PCRaster raster file format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>(internal libcf provided)</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="pdf.html#raster-pdf"><span class="std std-ref">PDF</span></a></p></td>
<td><p>Geospatial PDF</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>none for write support, Poppler/PoDoFo/PDFium for read support</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="pds.html#raster-pds"><span class="std std-ref">PDS</span></a></p></td>
<td><p>Planetary Data System v3</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="pds4.html#raster-pds4"><span class="std std-ref">PDS4</span></a></p></td>
<td><p>NASA Planetary Data System (Version 4)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="plmosaic.html#raster-plmosaic"><span class="std std-ref">PLMosaic</span></a></p></td>
<td><p>PLMosaic (Planet Labs Mosaics API)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="png.html#raster-png"><span class="std std-ref">PNG</span></a></p></td>
<td><p>Portable Network Graphics</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="pnm.html#raster-pnm"><span class="std std-ref">PNM</span></a></p></td>
<td><p>Netpbm (.pgm, .ppm)</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="postgisraster.html#raster-postgisraster"><span class="std std-ref">PostGISRaster</span></a></p></td>
<td><p>PostGIS Raster driver</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>PostgreSQL library</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="prf.html#raster-prf"><span class="std std-ref">PRF</span></a></p></td>
<td><p>PHOTOMOD Raster File</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="r.html#raster-r"><span class="std std-ref">R</span></a></p></td>
<td><p>R Object Data Store</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="rasterlite.html#raster-rasterlite"><span class="std std-ref">Rasterlite</span></a></p></td>
<td><p>Rasters in SQLite DB</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libsqlite3</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="rasterlite2.html#raster-rasterlite2"><span class="std std-ref">SQLite</span></a></p></td>
<td><p>Rasters in SQLite DB</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libsqlite3, librasterlite2, libspatialite</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="rdb.html#raster-rdb"><span class="std std-ref">RDB</span></a></p></td>
<td><p><em>RIEGL</em> Database</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>rdblib &gt;= 2.2.0.</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="rik.html#raster-rik"><span class="std std-ref">RIK</span></a></p></td>
<td><p>Swedish Grid Maps</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>(internal zlib is used if necessary)</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="rmf.html#raster-rmf"><span class="std std-ref">RMF</span></a></p></td>
<td><p>Raster Matrix Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="roi_pac.html#raster-roi-pac"><span class="std std-ref">ROI_PAC</span></a></p></td>
<td><p>ROI_PAC</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="rpftoc.html#raster-rpftoc"><span class="std std-ref">RPFTOC</span></a></p></td>
<td><p>Raster Product Format/RPF (a.toc)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="rraster.html#raster-rraster"><span class="std std-ref">RRASTER</span></a></p></td>
<td><p>R Raster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="rs2.html#raster-rs2"><span class="std std-ref">RS2</span></a></p></td>
<td><p>RadarSat 2 XML Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="s102.html#raster-s102"><span class="std std-ref">S102</span></a></p></td>
<td><p>S-102 Bathymetric Surface Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libhdf5</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="s104.html#raster-s104"><span class="std std-ref">S104</span></a></p></td>
<td><p>S-104 Water Level Information for Surface Navigation Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libhdf5</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="s111.html#raster-s111"><span class="std std-ref">S111</span></a></p></td>
<td><p>S-111 Surface Currents Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libhdf5</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="safe.html#raster-safe"><span class="std std-ref">SAFE</span></a></p></td>
<td><p>Sentinel-1 SAFE XML Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="sar_ceos.html#raster-sar-ceos"><span class="std std-ref">SAR_CEOS</span></a></p></td>
<td><p>CEOS SAR Image</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="sdat.html#raster-sdat"><span class="std std-ref">SAGA</span></a></p></td>
<td><p>SAGA GIS Binary Grid File Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="sdts.html#raster-sdts"><span class="std std-ref">SDTS</span></a></p></td>
<td><p>USGS SDTS DEM</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="sentinel2.html#raster-sentinel2"><span class="std std-ref">SENTINEL2</span></a></p></td>
<td><p>Sentinel-2 Products</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="sgi.html#raster-sgi"><span class="std std-ref">SGI</span></a></p></td>
<td><p>SGI Image Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="sigdem.html#raster-sigdem"><span class="std std-ref">SIGDEM</span></a></p></td>
<td><p>Scaled Integer Gridded DEM</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="snodas.html#raster-snodas"><span class="std std-ref">SNODAS</span></a></p></td>
<td><p>Snow Data Assimilation System</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="srp.html#raster-srp"><span class="std std-ref">SRP</span></a></p></td>
<td><p>Standard Product Format (ASRP/USRP) (.gen)</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="srtmhgt.html#raster-srtmhgt"><span class="std std-ref">SRTMHGT</span></a></p></td>
<td><p>SRTM HGT Format</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="stacit.html#raster-stacit"><span class="std std-ref">STACIT</span></a></p></td>
<td><p>Spatio-Temporal Asset Catalog Items</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="stacta.html#raster-stacta"><span class="std std-ref">STACTA</span></a></p></td>
<td><p>Spatio-Temporal Asset Catalog Tiled Assets</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="terragen.html#raster-terragen"><span class="std std-ref">Terragen</span></a></p></td>
<td><p>Terragen™ Terrain File</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="tga.html#raster-tga"><span class="std std-ref">TGA</span></a></p></td>
<td><p>TARGA Image File Format</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="til.html#raster-til"><span class="std std-ref">TIL</span></a></p></td>
<td><p>EarthWatch/DigitalGlobe .TIL</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="tiledb.html#raster-tiledb"><span class="std std-ref">TileDB</span></a></p></td>
<td><p>TileDB raster</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>TileDB (&gt;= 2.7 starting with GDAL 3.7)</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="tsx.html#raster-tsx"><span class="std std-ref">TSX</span></a></p></td>
<td><p>TerraSAR-X Product</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="usgsdem.html#raster-usgsdem"><span class="std std-ref">USGSDEM</span></a></p></td>
<td><p>USGS ASCII DEM (and CDED)</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="vicar.html#raster-vicar"><span class="std std-ref">VICAR</span></a></p></td>
<td><p>VICAR</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="vrt.html#raster-vrt"><span class="std std-ref">VRT</span></a></p></td>
<td><p>GDAL Virtual Format</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="wcs.html#raster-wcs"><span class="std std-ref">WCS</span></a></p></td>
<td><p>OGC Web Coverage Service</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="webp.html#raster-webp"><span class="std std-ref">WEBP</span></a></p></td>
<td><p>WEBP</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>libwebp</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="wms.html#raster-wms"><span class="std std-ref">WMS</span></a></p></td>
<td><p>Web Map Services</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="wmts.html#raster-wmts"><span class="std std-ref">WMTS</span></a></p></td>
<td><p>OGC Web Map Tile Service</p></td>
<td><p>No</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>libcurl</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="xpm.html#raster-xpm"><span class="std std-ref">XPM</span></a></p></td>
<td><p>X11 Pixmap</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="xyz.html#raster-xyz"><span class="std std-ref">XYZ</span></a></p></td>
<td><p>ASCII Gridded XYZ</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
<tr class="row-even"><td><p><a class="reference internal" href="zarr.html#raster-zarr"><span class="std std-ref">Zarr</span></a></p></td>
<td><p>Zarr</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default, but liblz4, libxz (lzma), libzstd and libblosc</p></td>
</tr>
<tr class="row-odd"><td><p><a class="reference internal" href="zmap.html#raster-zmap"><span class="std std-ref">ZMAP</span></a></p></td>
<td><p>ZMap Plus Grid</p></td>
<td><p>No</p></td>
<td><p><strong>Yes</strong></p></td>
<td><p><strong>Yes</strong></p></td>
<td><p>Built-in by default</p></td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><p>(1): Creation refers to implementing <a class="reference internal" href="../../api/raster_c_api.html#_CPPv410GDALCreate11GDALDriverHPKciii12GDALDataType12CSLConstList" title="GDALCreate"><code class="xref cpp cpp-func docutils literal notranslate"><span class="pre">GDALCreate()</span></code></a>.</p></li>
<li><p>(2): Copy refers to implementing <a class="reference internal" href="../../api/raster_c_api.html#_CPPv414GDALCreateCopy11GDALDriverHPKc12GDALDatasetHi12CSLConstList16GDALProgressFuncPv" title="GDALCreateCopy"><code class="xref cpp cpp-func docutils literal notranslate"><span class="pre">GDALCreateCopy()</span></code></a>.</p></li>
</ul>
<div class="admonition note">
<p class="admonition-title">備註</p>
<p>The following drivers have been retired and moved to the
<a class="reference external" href="https://github.com/OSGeo/gdal-extra-drivers">https://github.com/OSGeo/gdal-extra-drivers</a> repository: BPG, E00GRID, EPSILON, IGNFHeightASCIIGrid, NTv1</p>
</div>
<div class="toctree-wrapper compound" style="display: none;">
<ul>
<li class="toctree-l1"><a class="reference internal" href="aaigrid.html">AAIGrid -- Arc/Info ASCII Grid</a></li>
<li class="toctree-l1"><a class="reference internal" href="ace2.html">ACE2 -- ACE2</a></li>
<li class="toctree-l1"><a class="reference internal" href="adrg.html">ADRG -- ADRG/ARC Digitized Raster Graphics (.gen/.thf)</a></li>
<li class="toctree-l1"><a class="reference internal" href="aig.html">AIG -- Arc/Info Binary Grid</a></li>
<li class="toctree-l1"><a class="reference internal" href="airsar.html">AIRSAR -- AIRSAR Polarimetric Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="bag.html">BAG -- Bathymetry Attributed Grid</a></li>
<li class="toctree-l1"><a class="reference internal" href="basisu.html">BASISU -- Basis Universal</a></li>
<li class="toctree-l1"><a class="reference internal" href="blx.html">BLX -- Magellan BLX Topo File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="bmp.html">BMP -- Microsoft Windows Device Independent Bitmap</a></li>
<li class="toctree-l1"><a class="reference internal" href="bsb.html">BSB -- Maptech/NOAA BSB Nautical Chart Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="bt.html">BT -- VTP .bt Binary Terrain Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="byn.html">BYN - Natural Resources Canada's Geoid file format (.byn)</a></li>
<li class="toctree-l1"><a class="reference internal" href="cad.html">CAD -- AutoCAD DWG raster layer</a></li>
<li class="toctree-l1"><a class="reference internal" href="cals.html">CALS -- CALS Type 1</a></li>
<li class="toctree-l1"><a class="reference internal" href="ceos.html">CEOS -- CEOS Image</a></li>
<li class="toctree-l1"><a class="reference internal" href="coasp.html">COASP --  DRDC COASP SAR Processor Raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="cog.html">COG -- Cloud Optimized GeoTIFF generator</a></li>
<li class="toctree-l1"><a class="reference internal" href="cosar.html">COSAR -- TerraSAR-X Complex SAR Data Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="cpg.html">CPG -- Convair PolGASP data</a></li>
<li class="toctree-l1"><a class="reference internal" href="ctable2.html">CTable2 -- CTable2 Datum Grid Shift</a></li>
<li class="toctree-l1"><a class="reference internal" href="ctg.html">CTG -- USGS LULC Composite Theme Grid</a></li>
<li class="toctree-l1"><a class="reference internal" href="daas.html">DAAS (Airbus DS Intelligence Data As A Service driver)</a></li>
<li class="toctree-l1"><a class="reference internal" href="dds.html">DDS -- DirectDraw Surface</a></li>
<li class="toctree-l1"><a class="reference internal" href="derived.html">DERIVED -- Derived subdatasets driver</a></li>
<li class="toctree-l1"><a class="reference internal" href="dimap.html">DIMAP -- Spot DIMAP</a></li>
<li class="toctree-l1"><a class="reference internal" href="dipex.html">DIPEx -- ELAS DIPEx</a></li>
<li class="toctree-l1"><a class="reference internal" href="doq1.html">DOQ1 -- First Generation USGS DOQ</a></li>
<li class="toctree-l1"><a class="reference internal" href="doq2.html">DOQ2 -- New Labelled USGS DOQ</a></li>
<li class="toctree-l1"><a class="reference internal" href="dted.html">DTED -- Military Elevation Data</a></li>
<li class="toctree-l1"><a class="reference internal" href="ecrgtoc.html">ECRGTOC -- ECRG Table Of Contents (TOC.xml)</a></li>
<li class="toctree-l1"><a class="reference internal" href="ecw.html">ECW -- Enhanced Compressed Wavelets (.ecw)</a></li>
<li class="toctree-l1"><a class="reference internal" href="eedai.html">EEDAI - Google Earth Engine Data API Image</a></li>
<li class="toctree-l1"><a class="reference internal" href="ehdr.html">EHdr -- ESRI .hdr Labelled</a></li>
<li class="toctree-l1"><a class="reference internal" href="eir.html">EIR -- Erdas Imagine Raw</a></li>
<li class="toctree-l1"><a class="reference internal" href="elas.html">ELAS - Earth Resources Laboratory Applications Software</a></li>
<li class="toctree-l1"><a class="reference internal" href="envi.html">ENVI -- ENVI .hdr Labelled Raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="esat.html">ESAT -- Envisat Image Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="esric.html">ESRIC -- Esri Compact Cache</a></li>
<li class="toctree-l1"><a class="reference internal" href="ers.html">ERS -- ERMapper .ERS</a></li>
<li class="toctree-l1"><a class="reference internal" href="exr.html">EXR -- Extended Dynamic Range Image File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="fast.html">FAST -- EOSAT FAST Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="fit.html">FIT -- FIT</a></li>
<li class="toctree-l1"><a class="reference internal" href="fits.html">FITS -- Flexible Image Transport System</a></li>
<li class="toctree-l1"><a class="reference internal" href="genbin.html">GenBin -- Generic Binary (.hdr labelled)</a></li>
<li class="toctree-l1"><a class="reference internal" href="georaster.html">Oracle Spatial GeoRaster</a></li>
<li class="toctree-l1"><a class="reference internal" href="gff.html">GFF -- Sandia National Laboratories GSAT File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="gif.html">GIF -- Graphics Interchange Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="gpkg.html">GPKG -- GeoPackage raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="grass.html">GRASS Raster Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="grassasciigrid.html">GRASSASCIIGrid -- GRASS ASCII Grid</a></li>
<li class="toctree-l1"><a class="reference internal" href="grib.html">GRIB -- WMO General Regularly-distributed Information in Binary form</a></li>
<li class="toctree-l1"><a class="reference internal" href="gs7bg.html">GS7BG -- Golden Software Surfer 7 Binary Grid File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="gsag.html">GSAG -- Golden Software ASCII Grid File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="gsbg.html">GSBG -- Golden Software Binary Grid File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="gsc.html">GSC -- GSC Geogrid</a></li>
<li class="toctree-l1"><a class="reference internal" href="gta.html">GTA - Generic Tagged Arrays</a></li>
<li class="toctree-l1"><a class="reference internal" href="gti.html">GTI -- GDAL Raster Tile Index</a></li>
<li class="toctree-l1"><a class="reference internal" href="gtiff.html">GTiff -- GeoTIFF File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="gxf.html">GXF -- Grid eXchange File</a></li>
<li class="toctree-l1"><a class="reference internal" href="hdf4.html">HDF4 -- Hierarchical Data Format Release 4 (HDF4)</a></li>
<li class="toctree-l1"><a class="reference internal" href="hdf5.html">HDF5 -- Hierarchical Data Format Release 5 (HDF5)</a></li>
<li class="toctree-l1"><a class="reference internal" href="heif.html">HEIF / HEIC -- ISO/IEC 23008-12:2017 High Efficiency Image File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="hf2.html">HF2 -- HF2/HFZ heightfield raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="hfa.html">HFA -- Erdas Imagine .img</a></li>
<li class="toctree-l1"><a class="reference internal" href="Idrisi.html">RST -- Idrisi Raster Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="ilwis.html">ILWIS -- Raster Map</a></li>
<li class="toctree-l1"><a class="reference internal" href="iris.html">IRIS -- Vaisala's weather radar software format</a></li>
<li class="toctree-l1"><a class="reference internal" href="isce.html">ISCE -- ISCE</a></li>
<li class="toctree-l1"><a class="reference internal" href="isg.html">ISG -- International Service for the Geoid</a></li>
<li class="toctree-l1"><a class="reference internal" href="isis2.html">ISIS2 -- USGS Astrogeology ISIS Cube (Version 2)</a></li>
<li class="toctree-l1"><a class="reference internal" href="isis3.html">ISIS3 -- USGS Astrogeology ISIS Cube (Version 3)</a></li>
<li class="toctree-l1"><a class="reference internal" href="jdem.html">JDEM -- Japanese DEM (.mem)</a></li>
<li class="toctree-l1"><a class="reference internal" href="jp2ecw.html">JP2ECW -- ERDAS JPEG2000 (.jp2)</a></li>
<li class="toctree-l1"><a class="reference internal" href="jp2kak.html">JP2KAK -- JPEG 2000 (based on Kakadu SDK)</a></li>
<li class="toctree-l1"><a class="reference internal" href="jp2lura.html">JP2Lura -- JPEG2000 driver based on Lurawave library</a></li>
<li class="toctree-l1"><a class="reference internal" href="jp2mrsid.html">JP2MrSID -- JPEG2000 via MrSID SDK</a></li>
<li class="toctree-l1"><a class="reference internal" href="jp2openjpeg.html">JP2OpenJPEG -- JPEG2000 driver based on OpenJPEG library</a></li>
<li class="toctree-l1"><a class="reference internal" href="jpeg.html">JPEG -- JPEG JFIF File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="jpegxl.html">JPEGXL -- JPEG-XL File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="jpipkak.html">JPIPKAK - JPIP Streaming</a></li>
<li class="toctree-l1"><a class="reference internal" href="kea.html">KEA</a></li>
<li class="toctree-l1"><a class="reference internal" href="kmlsuperoverlay.html">KMLSuperoverlay -- KMLSuperoverlay</a></li>
<li class="toctree-l1"><a class="reference internal" href="kro.html">KRO -- KOLOR Raw format</a></li>
<li class="toctree-l1"><a class="reference internal" href="ktx2.html">KTX2</a></li>
<li class="toctree-l1"><a class="reference internal" href="lan.html">LAN -- Erdas 7.x .LAN and .GIS</a></li>
<li class="toctree-l1"><a class="reference internal" href="l1b.html">L1B -- NOAA Polar Orbiter Level 1b Data Set (AVHRR)</a></li>
<li class="toctree-l1"><a class="reference internal" href="lcp.html">LCP -- FARSITE v.4 LCP Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="leveller.html">Leveller -- Daylon Leveller Heightfield</a></li>
<li class="toctree-l1"><a class="reference internal" href="loslas.html">LOSLAS -- NADCON .los/.las Datum Grid Shift</a></li>
<li class="toctree-l1"><a class="reference internal" href="map.html">MAP -- OziExplorer .MAP</a></li>
<li class="toctree-l1"><a class="reference internal" href="marfa.html">MRF -- Meta Raster Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="mbtiles.html">MBTiles</a></li>
<li class="toctree-l1"><a class="reference internal" href="mem.html">MEM -- In Memory Raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="mff.html">MFF -- Vexcel MFF Raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="mff2.html">MFF2 -- Vexcel MFF2 Image</a></li>
<li class="toctree-l1"><a class="reference internal" href="mrsid.html">MrSID -- Multi-resolution Seamless Image Database</a></li>
<li class="toctree-l1"><a class="reference internal" href="msg.html">MSG -- Meteosat Second Generation</a></li>
<li class="toctree-l1"><a class="reference internal" href="msgn.html">MSGN -- Meteosat Second Generation (MSG) Native Archive Format (.nat)</a></li>
<li class="toctree-l1"><a class="reference internal" href="ndf.html">NDF -- NLAPS Data Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="netcdf.html">NetCDF: Network Common Data Form</a></li>
<li class="toctree-l1"><a class="reference internal" href="ngsgeoid.html">NGSGEOID - NOAA NGS Geoid Height Grids</a></li>
<li class="toctree-l1"><a class="reference internal" href="ngw.html">NGW -- NextGIS Web</a></li>
<li class="toctree-l1"><a class="reference internal" href="nitf.html">NITF -- National Imagery Transmission Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="noaa_b.html">NOAA_B -- NOAA GEOCON/NADCON5 .b format</a></li>
<li class="toctree-l1"><a class="reference internal" href="nsidcbin.html">NSIDCbin -- National Snow and Ice Data Centre Sea Ice Concentrations</a></li>
<li class="toctree-l1"><a class="reference internal" href="ntv2.html">NTv2 -- NTv2 Datum Grid Shift</a></li>
<li class="toctree-l1"><a class="reference internal" href="nwtgrd.html">NWT_GRD/NWT_GRC -- Northwood/Vertical Mapper File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="ogcapi.html">OGCAPI -- OGC API Tiles / Maps / Coverage</a></li>
<li class="toctree-l1"><a class="reference internal" href="openfilegdb.html">ESRI File Geodatabase raster (OpenFileGDB)</a></li>
<li class="toctree-l1"><a class="reference internal" href="ozi.html">OZI -- OZF2/OZFX3 raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="palsar.html">JAXA PALSAR Processed Products</a></li>
<li class="toctree-l1"><a class="reference internal" href="paux.html">PAux -- PCI .aux Labelled Raw Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="pcidsk.html">PCIDSK -- PCI Geomatics Database File</a></li>
<li class="toctree-l1"><a class="reference internal" href="pcraster.html">PCRaster -- PCRaster raster file format</a></li>
<li class="toctree-l1"><a class="reference internal" href="pdf.html">PDF -- Geospatial PDF</a></li>
<li class="toctree-l1"><a class="reference internal" href="pds.html">PDS -- Planetary Data System v3</a></li>
<li class="toctree-l1"><a class="reference internal" href="pds4.html">PDS4 -- NASA Planetary Data System (Version 4)</a></li>
<li class="toctree-l1"><a class="reference internal" href="plmosaic.html">PLMosaic (Planet Labs Mosaics API)</a></li>
<li class="toctree-l1"><a class="reference internal" href="png.html">PNG -- Portable Network Graphics</a></li>
<li class="toctree-l1"><a class="reference internal" href="pnm.html">PNM -- Netpbm (.pgm, .ppm)</a></li>
<li class="toctree-l1"><a class="reference internal" href="postgisraster.html">PostGISRaster -- PostGIS Raster driver</a></li>
<li class="toctree-l1"><a class="reference internal" href="prf.html">PHOTOMOD Raster File</a></li>
<li class="toctree-l1"><a class="reference internal" href="rasterlite.html">Rasterlite - Rasters in SQLite DB</a></li>
<li class="toctree-l1"><a class="reference internal" href="rasterlite2.html">RasterLite2 - Rasters in SQLite DB</a></li>
<li class="toctree-l1"><a class="reference internal" href="r.html">R -- R Object Data Store</a></li>
<li class="toctree-l1"><a class="reference internal" href="rdb.html">RDB - <em>RIEGL</em> Database</a></li>
<li class="toctree-l1"><a class="reference internal" href="rik.html">RIK -- Swedish Grid Maps</a></li>
<li class="toctree-l1"><a class="reference internal" href="rmf.html">RMF -- Raster Matrix Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="roi_pac.html">ROI_PAC -- ROI_PAC</a></li>
<li class="toctree-l1"><a class="reference internal" href="rpftoc.html">RPFTOC -- Raster Product Format/RPF (a.toc)</a></li>
<li class="toctree-l1"><a class="reference internal" href="rraster.html">RRASTER -- R Raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="rs2.html">RS2 -- RadarSat 2 XML Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="s102.html">S102 -- S-102 Bathymetric Surface Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="s104.html">S104 -- S-104 Water Level Information for Surface Navigation Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="s111.html">S111 -- S-111 Surface Currents Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="safe.html">SAFE -- Sentinel-1 SAFE XML Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="sar_ceos.html">SAR_CEOS -- CEOS SAR Image</a></li>
<li class="toctree-l1"><a class="reference internal" href="sdat.html">SAGA -- SAGA GIS Binary Grid File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="sdts.html">SDTS -- USGS SDTS DEM</a></li>
<li class="toctree-l1"><a class="reference internal" href="sentinel2.html">SENTINEL2 -- Sentinel-2 Products</a></li>
<li class="toctree-l1"><a class="reference internal" href="sgi.html">SGI -- SGI Image Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="sigdem.html">SIGDEM -- Scaled Integer Gridded DEM</a></li>
<li class="toctree-l1"><a class="reference internal" href="snodas.html">SNODAS -- Snow Data Assimilation System</a></li>
<li class="toctree-l1"><a class="reference internal" href="srp.html">SRP -- Standard Product Format (ASRP/USRP) (.gen)</a></li>
<li class="toctree-l1"><a class="reference internal" href="srtmhgt.html">SRTMHGT -- SRTM HGT Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="stacit.html">STACIT - Spatio-Temporal Asset Catalog Items</a></li>
<li class="toctree-l1"><a class="reference internal" href="stacta.html">STACTA - Spatio-Temporal Asset Catalog Tiled Assets</a></li>
<li class="toctree-l1"><a class="reference internal" href="terragen.html">Terragen -- Terragen™ Terrain File</a></li>
<li class="toctree-l1"><a class="reference internal" href="tga.html">TGA -- TARGA Image File Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="til.html">TIL -- EarthWatch/DigitalGlobe .TIL</a></li>
<li class="toctree-l1"><a class="reference internal" href="tiledb.html">TileDB - TileDB raster</a></li>
<li class="toctree-l1"><a class="reference internal" href="tsx.html">TSX --  TerraSAR-X Product</a></li>
<li class="toctree-l1"><a class="reference internal" href="usgsdem.html">USGSDEM -- USGS ASCII DEM (and CDED)</a></li>
<li class="toctree-l1"><a class="reference internal" href="vicar.html">VICAR -- VICAR</a></li>
<li class="toctree-l1"><a class="reference internal" href="vrt.html">VRT -- GDAL Virtual Format</a></li>
<li class="toctree-l1"><a class="reference internal" href="wcs.html">WCS -- OGC Web Coverage Service</a></li>
<li class="toctree-l1"><a class="reference internal" href="webp.html">WEBP - WEBP</a></li>
<li class="toctree-l1"><a class="reference internal" href="wms.html">WMS -- Web Map Services</a></li>
<li class="toctree-l1"><a class="reference internal" href="wmts.html">WMTS -- OGC Web Map Tile Service</a></li>
<li class="toctree-l1"><a class="reference internal" href="xpm.html">XPM -- X11 Pixmap</a></li>
<li class="toctree-l1"><a class="reference internal" href="xyz.html">XYZ -- ASCII Gridded XYZ</a></li>
<li class="toctree-l1"><a class="reference internal" href="zarr.html">Zarr</a></li>
<li class="toctree-l1"><a class="reference internal" href="zmap.html">ZMap -- ZMap Plus Grid</a></li>
</ul>
</div>
</section>


           </div>
          </div>
          <footer>
  
    <div class="rst-footer-buttons" role="navigation" aria-label="footer navigation">
      
        <a href="aaigrid.html" class="btn btn-neutral float-right" title="AAIGrid -- Arc/Info ASCII Grid" accesskey="n" rel="next">下一页 <span class="fa fa-arrow-circle-right"></span></a>
      
      
        <a href="../../programs/sozip.html" class="btn btn-neutral float-left" title="sozip" accesskey="p" rel="prev"><span class="fa fa-arrow-circle-left"></span> 上一页</a>
      
    </div>
  

  <hr/>

  <div role="contentinfo">
    <div class="info">
      <a class="logo-link" href="https://osgeo.org">
        <div class="osgeo-logo"></div>
      </a>
      <div class="copyright">
      

      &copy; 1998-2024 <a href="https://github.com/warmerdam">Frank Warmerdam</a>,
      <a href="https://github.com/rouault">Even Rouault</a>, and
      <a href="https://github.com/OSGeo/gdal/graphs/contributors">others</a>


      
      </div>
    </div>
  </div>
</footer>
        </div>
      </div>
    </section>
  </div>
  
<script>
      jQuery(function () {
          SphinxRtdTheme.Navigation.enable(true);
      });
  </script> 

</body>
</html>