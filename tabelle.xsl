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
	  <title>Marktplatz/Tabelle</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
    <link href="http://fonts.googleapis.com/css?family=Overlock:regular,italic,700,700italic,900,900italic&amp;subset=latin,latin-ext" rel="stylesheet" type="text/css" />
    <link href="//fonts.googleapis.com/css?family=Hind:300,regular,500,600,700" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="oxtab.css"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  </head>
  <body>
     <div class="row">
	     <div class="col-sm-6"><h1>Hotellings' Market Place - Table</h1></div>
	     <div class="col-sm-6"><h1><xsl:value-of select="./Product"/> Version <xsl:value-of select="./Version"/></h1></div>
     </div>
     <hr/>
<div class="row">
	<div class="col-sm-6">
		<br/>
  <div class="rcorners">
	<h2>formula calculator*</h2>
	<form action="make_tab.php" method="post" id="FormelInput">
		<p>trade size M : <input type="text" name="M" value="{//Formel/Menge}" min="0" id="menge"/></p>
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
    </div>
	    <button type="submit" class="btn btn-default">refresh map</button>
	    <br/>
	    * E = P x M + F x ( 1 + f <sub>i</sub> )<br/>
	 </form>
        
	<!-- <button onclick="CalcFormula()">Click me</button> -->
    </div><!--  Ende rcorners-->
    </div>
    <div class="col-sm-6">
	    <br/>
    <div class="rcorners">
    <h2>explanation</h2>
    <p>the delivery prices E=PxM+Fx(1+f<sub>i</sub>) are calculated for all areas and given P, F and M. Results are shown in the table.</p>
    
    </div>
    </div>
</div>
<br/>
<div class="rcorners container">
<div class="row">
<div class="col-sm-12">
  <h2>Übersicht der Zielgebiete</h2>
  <div class="table-responsive">  
  <table class="table table-condensed table-striped" id="basetable">
    <thead>
      <tr>
	<th>ID</th>
	<th>pricing region</th>
	<th>freight correction f<sub>ID</sub></th>
	<th colspan="2">center</th>
	<th>radius</th>
	<th>opening hours</th>
	<th>formula price E</th>
      </tr>
      <tr>
        <th></th>
	<th></th>
	<th></th>
	<th>°N</th>
	<th>°O</th>
	<th>in m</th>
	<th></th>
	<th>in US Dollar</th>
      </tr>
    </thead>
    <tbody id="DataTable">
   <xsl:for-each select="row">	
      <tr>
        <td><xsl:value-of select="field[@name='punkt']"/></td>
        <td><xsl:value-of select="field[@name='Region']"/></td>
        <td><xsl:value-of select="field[@name='fi']"/></td>
        <td><xsl:value-of select="field[@name='N']"/></td>
        <td><xsl:value-of select="field[@name='O']"/></td>
	<td><xsl:value-of select="field[@name='radius']"/></td>
  	<td><xsl:value-of select="field[@name='effozeiten']"/></td>
	<td><p id="P{field[@name='punkt']}">
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
	
        <xsl:value-of select=" ( $currentP * $M) + ( $currentF * ( 1 + field[@name='fi'])) " />
        </p>
    </td>
      </tr>
 </xsl:for-each>
    </tbody>
  </table>
  </div>
  </div>
  </div>
  </div> 
  </body>
</html>
</xsl:template>
</xsl:stylesheet>
