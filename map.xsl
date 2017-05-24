<?xml version="1.0" encoding="UTF-8"?>
<!--<!DOCTYPE html>  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">

    <xsl:param name="M" select="//Formel/Menge"/>
    <!-- try template for filtering by value out of variable -->
    <xsl:template name="filterregionP">
        <xsl:param name="filterValue" />
        <xsl:variable name="regions" select="//Formel/Region[@name=$filterValue]/P" />
        <xsl:for-each select="$regions">
            <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="filterregionF">
        <xsl:param name="filterValue" />
        <xsl:variable name="regions" select="//Formel/Region[@name=$filterValue]/F" />
        <xsl:for-each select="$regions">
            <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:template>
<xsl:output method="html" encoding="UTF-8" />
<xsl:template match="/resultset">
<html lang="de">
  <head>
	  <title>product name</title>
    <link rel="stylesheet" href="http://openlayers.org/en/v3.18.2/css/ol.css" type="text/css"/>
    <script src="http://openlayers.org/en/v3.18.2/build/ol.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
    <link href="http://fonts.googleapis.com/css?family=Overlock:regular,italic,700,700italic,900,900italic&amp;subset=latin,latin-ext" rel="stylesheet" type="text/css" />
    <link href="//fonts.googleapis.com/css?family=Hind:300,regular,500,600,700" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="oxtab.css" /> 
   
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <style>
      #map {
        position: relative;
      }
      #info {
        position: absolute;
        height: 1px;
        width: 1px;
        z-index: 100;
      }
      .tooltip.in {
        opacity: 1;
      }
      .tooltip.top .tooltip-arrow {
        border-top-color:  #516296;
      }
      .tooltip-inner {
        border: 2px solid white;
	background-color: #516296;
      }
    </style>
  </head>
  <body>
<p id="demo"/>
      <div class="row">
	<div class="col-sm-6"><h1>Hotellings' Market Place </h1></div>
	<div class="col-sm-6"><h1><xsl:value-of select="./Product"/> Version <xsl:value-of select="./Version"/></h1></div>
      </div>
      <hr/>
<form action="make.php" method="post">
      <div class="row">
	<div class="col-sm-6">
		<br/>
         <div class="rcorners">
	 <h2>formula calculator*</h2>
	   <p>trade size M : <input type="text" name="M" value="{//Formel/Menge}" min="0" id="menge"/> </p>
	   <div class="table-responsive">
	    <table class="table">
	    <thead>
	      <tr>
		<th>region</th>
		<th>P</th>
		<th>F</th>
	      </tr>
      		</thead>
      
	    <tbody>
		<xsl:for-each select="//Formel/Region">
		<tr>
		<td><xsl:value-of select="./@name"/> </td>
		<td><span style="width: 5em;"><input type="number" name="P{./@name}" id="P{./@name}" value="{./P}" step="0.01"/></span></td>
		<td><input type="number" name="F{./@name}" id="F{./@name}" value="{./F}" step="1"/></td>
		</tr>
		</xsl:for-each>
	    </tbody>
           </table>
   </div> <!-- end table respsonsive -->
   <p>
  *  E = P x M + F x ( 1 + f<sub>i</sub> ) <br/>
  </p>
        </div><!--  Ende rcorners-->
	</div>
       <div class="col-sm-6"><br/>
        <div class="rcorners">
         <h2>explanation</h2>
	 <p>calculation results are shown for each area</p>
	</div>
	<br/>
	<div> <!--  class="rcorners"> -->
	 <div  class="rcorners">
		<h2>shown in the map</h2>
		<xsl:choose>
		<xsl:when test="Kreisanzeige='id'">	
		  <input type="radio" name="kreisanzeige" value="id" checked="checked"/> area ID<br/>
		  <input type="radio" name="kreisanzeige" value="fi"/> freight correction fi<br/>
		  <input type="radio" name="kreisanzeige" value="E"/> formula price E<br/><br/>
		</xsl:when>
		<xsl:when test="Kreisanzeige='fi'"> 
		  <input type="radio" name="kreisanzeige" value="id" /> area ID<br/>
		  <input type="radio" name="kreisanzeige" value="fi" checked="checked"/> freight correction fi<br/>
		  <input type="radio" name="kreisanzeige" value="E"/> formula price E<br/><br/>
		</xsl:when>
		<xsl:when test="Kreisanzeige='E'"> 
		  <input type="radio" name="kreisanzeige" value="id"/> area ID<br/>
		  <input type="radio" name="kreisanzeige" value="fi"/> freight correction fi<br/>
		  <input type="radio" name="kreisanzeige" value="E" checked="checked"/> formula price E<br/><br/>
		</xsl:when>	
		<xsl:otherwise>
		  <input type="radio" name="kreisanzeige" value="id"/> area ID<br/>
		  <input type="radio" name="kreisanzeige" value="fi"/> freight correction fi<br/>
		  <input type="radio" name="kreisanzeige" value="E"/> formula price E<br/><br/>
	  	</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
	  	<xsl:when test="typesize='1'"> 
		   <input type="checkbox" name="typesize" value="extragross" checked="checked"/> large font</xsl:when>		
		<xsl:otherwise>
		   <input type="checkbox" name="typesize" value="extragross"/>large font
	   	</xsl:otherwise>
		</xsl:choose>
	  </div>
	</div>
	</div> <!-- ende  col -->

 </div> <!-- ende row -->
 <br/>
	<div class="row">

		<div class="col-sm-12">
		<div class="rcorners">
			<button type="submit" class="btn btn-default">refresh map</button><br/>
			<h3>show in areas: 
			<xsl:choose>
				<xsl:when test="Kreisanzeige='E'">
				formula price E	
			   	</xsl:when>
				<xsl:when test="Kreisanzeige='id'">
				area ID
				</xsl:when>
				<xsl:when test="Kreisanzeige='fi'">
				freight correction f<sub>i</sub>
				</xsl:when>
				<xsl:otherwise>
				-
				</xsl:otherwise>
			</xsl:choose>
			</h3> 
			<div id="map" class="map" style="width:100%"><div id="info"></div></div>
		</div>
		</div>
	</div>  <!-- ende row -->
</form>	
	<!-- BEGINN JAVACRIPT  BIG BLOCK -->	
<script>
	var schriftgr=1.0;
	<xsl:if test="typesize='1'">
	  schriftgr=1.8;
  	</xsl:if>

	var zwert=1.4;
	var zoomvalue=5;
	var styleCache = {};
        var styleFunction = function(feature) {
        var radius = 5 + 20;
        var style = styleCache[radius];
        if (!style) {
          style = new ol.style.Style({
            image: new ol.style.Circle({
              radius: radius,
              fill: new ol.style.Fill({
                color: 'rgba(0, 153, 0, 0.4)'
              }),
              stroke: new ol.style.Stroke({
                color: 'rgba(255, 204, 0, 0.2)',
                width: 1
              })
            })
          });
          styleCache[radius] = style;
        }
        return style;
      };


<!--Layer for CIRCLES -->
        var vector1 = new ol.layer.Vector({
        source: new ol.source.Vector(),
        style: styleFunction,
	minResolution : 0.001,
	maxResolution : 12500,
	visible : true
      });
<xsl:for-each select="row">

	<!-- loop through templates to precreate formula -->
 	<xsl:variable name="currentP">
        <xsl:call-template name="filterregionP"> 
            <xsl:with-param name="filterValue" select="field[@name='Region']" /> 
        </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="currentF">
        <xsl:call-template name="filterregionF"> 
            <xsl:with-param name="filterValue" select="field[@name='Region']" />
        </xsl:call-template>
	</xsl:variable>

	var radius=<xsl:value-of select="field[@name='radius']"/>;
        var wgs84Sphere = new ol.Sphere(6378137);
	var circle4326 = ol.geom.Polygon.circular(wgs84Sphere, [<xsl:value-of select="field[@name='O']"/>,<xsl:value-of select="field[@name='N']"/> ],radius,64);
    	var circle3857 = circle4326.clone().transform('EPSG:4326', 'EPSG:3857');
    	featureA = new ol.Feature(circle3857);
	var fAstyle = new ol.style.Style({
		stroke: new ol.style.Stroke({
		width: 1 
 		 	}),
		fill: new ol.style.Fill({
		color: '<xsl:value-of select="field[@name='farbe']"/>'
			}),
		text: new ol.style.Text({
			text:'',
			scale: 0.8
		})
		});
	featureA.setStyle(fAstyle);
	featureA.set('name','<p>Area ID:<xsl:value-of select="field[@name='punkt']"/><br/>center: <xsl:value-of select="field[@name='N']"/>°N/ <xsl:value-of select="field[@name='O']"/>°O<br/>radius: <xsl:value-of select="field[@name='radius']"/> m<br/>freight correction f : <xsl:value-of select="field[@name='fi']"/><br/>E=<xsl:value-of select=" format-number(( $currentP * $M) + ( $currentF * ( 1 + field[@name='fi'])),0) " /> US Dollar </p>');
	vector1.getSource().addFeature(featureA);
</xsl:for-each>
       var raster = new ol.layer.Tile({
source: new ol.source.OSM()	
});

<!--ENDE ... Layer for CIRCLES -->
<!--Layer for CIRCLES Numbers ... Ids, Fi s, or E s-->
        var vector2 = new ol.layer.Vector({
        source: new ol.source.Vector(),
        style: styleFunction,
	minResolution : 0.001,
	maxResolution : 1000,
	visible : true
      });
     
 <xsl:for-each select="row">	

	<!-- loop through templates to precreate formula -->
 	<xsl:variable name="currentP">
        <xsl:call-template name="filterregionP"> 
            <xsl:with-param name="filterValue" select="field[@name='Region']" /> 
        </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="currentF">
        <xsl:call-template name="filterregionF"> 
            <xsl:with-param name="filterValue" select="field[@name='Region']" />
        </xsl:call-template>
	</xsl:variable>

	var radius=<xsl:value-of select="field[@name='radius']"/>;
        var wgs84Sphere = new ol.Sphere(6378137);
	var circle4326 = ol.geom.Polygon.circular(wgs84Sphere, [<xsl:value-of select="field[@name='O']"/>,<xsl:value-of select="field[@name='N']"/> ],radius,64);
    	var circle3857 = circle4326.clone().transform('EPSG:4326', 'EPSG:3857');
	featureA = new ol.Feature(circle3857);

	var fAstyle = new ol.style.Style({
		text: new ol.style.Text({
		<xsl:choose>
			<xsl:when test="../Kreisanzeige='E'">
			   <!--  -->
			   text: '<xsl:value-of select=" format-number(( $currentP * $M) + ( $currentF * ( 1 + field[@name='fi'])),0) " />' ,
			   scale: schriftgr
		   	</xsl:when>
			<xsl:when test="../Kreisanzeige='id'">
			   text:'<xsl:value-of select="field[@name='punkt']"/>',
			   scale: schriftgr
		   	</xsl:when>
			<xsl:when test="../Kreisanzeige='fi'">
			   text:'<xsl:value-of select="field[@name='fi']"/>',
			   scale:  schriftgr
		   	</xsl:when>
		</xsl:choose>
		})
		});
	featureA.setStyle(fAstyle);
	vector2.getSource().addFeature(featureA);
</xsl:for-each>
       var raster = new ol.layer.Tile({
	source: new ol.source.OSM() 
	});

<!--ENDE ... Layer for CIRCLE IDs -->

<!-- Layer for ICONS -->
<!--ENDE ... Layer for ICONS -->
      var map = new ol.Map({
      interactions: ol.interaction.defaults({mouseWheelZoom:false}),
        layers: [raster,vector1, vector2],
        target: 'map',
        view: new ol.View({
          center: [-11250000,4800000],
          zoom: zoomvalue 
        })
      });

      var info = $('#info');
      info.tooltip({
        animation: false,
        trigger: 'manual',
	html: true
      });

      var displayFeatureInfo = function(pixel) {
        info.css({
          left: pixel[0] + 'px',
          top: (pixel[1]-15) + 'px'
        });
        var feature = map.forEachFeatureAtPixel(pixel, function(feature) {
          return feature;
        });
        if (feature) {
          info.tooltip('hide')
              .attr('data-original-title', feature.get('name'))
              .tooltip('fixTitle')
              .tooltip('show')
	      .tooltip('html',true);
	      ;
        } else {
          info.tooltip('hide');
        }
      };

      map.on('pointermove', function(evt) {
        if (evt.dragging) {
          info.tooltip('hide');
          return;
        }
        displayFeatureInfo(map.getEventPixel(evt.originalEvent));
      });
      
    
    </script>
  </body>
</html>
</xsl:template>
</xsl:stylesheet>
