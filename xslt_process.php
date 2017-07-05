<?php
  $valid=true;
  $errormsg="";
  $dom = new DOMDocument;
  $dom->load($punktefile);
  $x=$dom->documentElement;
  $xp=new DOMXPath($dom);
  $xsl= new DOMDocument;
  $region_xml = simplexml_load_file($mapfile);
  // Initialize Formel element
  $formeldata=$dom->createElement('Formel');
  // add each regions name to that element
  foreach ($region_xml->{'row'} as $row) {
      $regionname = $row->field[1];
      $region=$dom->createElement('Region');
      //the following is necessary, because the POST variable names have underscore instead of space in region names 
      $regionname_underscore = preg_replace('/ /', '_', $regionname);
      $region->setAttribute('name',$regionname);
      $P=$dom->createElement('P',$_POST['P'.$regionname_underscore]);
      $region->appendChild($P);
      $F=$dom->createElement('F',$_POST['F'.$regionname_underscore]);
      $region->appendChild($F);
      $formeldata->appendChild($region);
  };
  // add some fixed values to that element
  $menge=$dom->createElement('Menge',$_POST['M']);
  $formeldata->appendChild($menge);
  $r=$xp->query("/resultset");
  $root=$r->item(0);
  $root->appendChild($formeldata);
  $element=$dom->createElement('Product',$region_xml->product);
  $root->appendChild($element);
  $element2=$dom->createElement('Version',$region_xml->version);
  $root->appendChild($element2);
  $element3=$dom->createElement('Kreisanzeige',$_POST['kreisanzeige']);
  $root->appendChild($element3);

  if(array_key_exists('typesize', $_POST))
  {
	  $element4=$dom->createElement('typesize','1');
	  $root->appendChild($element4);
  };

  $xsl->load($xsl_filename);
  // instantiate XSLTProcessor
  $proc=new XSLTProcessor;
  $result = $proc->importStyleSheet($xsl);
   $dom2 = new DOMDocument;
    $dom2->load($iconfile);
    $x2=$dom2->documentElement;

 $dom->documentElement->appendChild($dom->importNode($dom2->documentElement));
  echo $dom->saveXML();
 
 // echo $proc->transformToXML($dom);

?> 
