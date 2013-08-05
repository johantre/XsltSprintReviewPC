<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<!--<!DOCTYPE html>-->
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=1024, user-scalable=no" />

	<title><xsl:value-of select="slides/title"/></title>
	
	<!-- Required stylesheet -->
	<link rel="stylesheet" href="../deck/core/deck.core.css" />
	<!-- Extension CSS files go here. Remove or add as needed. -->
	<link rel="stylesheet" href="../deck/extensions/goto/deck.goto.css" />
	<link rel="stylesheet" href="../deck/extensions/menu/deck.menu.css" />
	<link rel="stylesheet" href="../deck/extensions/navigation/deck.navigation.css" />
	<link rel="stylesheet" href="../deck/extensions/status/deck.status.css" />
	<link rel="stylesheet" href="../deck/extensions/hash/deck.hash.css" />
	<link rel="stylesheet" href="../deck/extensions/scale/deck.scale.css" />
	<!-- Style theme. More available in /themes/style/ or create your own. -->
	<link rel="stylesheet" href="../deck/themes/style/tomtom.css" />
	<!-- Transition theme. More available in /themes/transition/ or create your own. -->
	<link rel="stylesheet" href="../deck/themes/transition/horizontal-slide.css" />
	<link href='http://fonts.googleapis.com/css?family=Finger+Paint' rel='stylesheet' type='text/css' />


	<!-- Required Modernizr file -->
	<script src="../deck/lib/modernizr.custom.js"></script>

	<xsl:copy-of select="slides/dependencies/*"/>

</head>
<body class="deck-container">

<!-- Begin slides. Just make elements with a class of slide. -->

<xsl:for-each select="sprintreview/team">
    <section class="slide" id="intro" >
        <table align="center">
            <tr>
                <td width="1140" height="524"  align="center" background="../deck/slides/TomTomLogo.jpg" ></td>
            </tr>
            <tr>
                <td align="right"><h4 class="center">Sprint Review</h4></td>
            </tr>
            <tr>
                <td align="right"><h5 class="center">Team <xsl:value-of select="@name"/></h5></td>
            </tr>
            <tr>
                <td align="right"><h7 class="center">Sprint <xsl:value-of select="../../*/@id"/></h7></td>
            </tr>
        </table>
    </section>
    <section class="slide" id="intro" >
        <div class="info">
        <h4 class="center">Team Composition</h4>
          <p class="team">
            <span class="caption">Scrum Team Members: </span>
            <span class="content">
                    <xsl:for-each select="member"><br/>
                      &#8226; <xsl:copy-of select="."/>
                    </xsl:for-each>
             </span>
          </p>
          <p class="scrum-master">
            <span class="caption">Product Owner: </span>
            <span class="content"><xsl:value-of select="productowner"/></span>
          </p>
          <p class="scrum-master">
            <span class="caption">Scrum Master: </span>
            <span class="content"><xsl:value-of select="scrummaster"/></span>
          </p>
        </div>
    </section>
    
</xsl:for-each>


<section class="slide" id="intro" >
    <h2>User Stories Done</h2>
    <xsl:choose>
        <xsl:when test="sprintreview/slides/slide[header/@class='story done']">
            <ul class="stories">
                <xsl:for-each select="sprintreview/slides/slide[header/@class='story done']">
                <li class="story done"><xsl:value-of select="*"/> <span class="sp">(SP: <xsl:value-of select="*/@points"/>)</span></li>
                </xsl:for-each>    
            </ul>
        </xsl:when>
        <xsl:otherwise>
            <ul class="stories">
                <li class="story not-done">NONE</li>
            </ul>
        </xsl:otherwise>
    </xsl:choose>
</section>    

<xsl:choose>
    <xsl:when test="sprintreview/slides/slide[header/@class='story not-done']">
        <section class="slide" id="intro" >
            <h2 class="story not-done">User Stories NOT Done</h2>
            <ul class="stories">
                <xsl:for-each select="sprintreview/slides/slide[header/@class='story not-done']">
                <li class="story not-done"><xsl:value-of select="*"/> <span class="sp">(SP: <xsl:value-of select="*/@points"/>)</span><span class="sp"> Done: <xsl:value-of select="*/@percentage-done"/>%</span></li>
                </xsl:for-each>
            </ul>        
        </section>    
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
</xsl:choose>    
    

<xsl:choose>
    <xsl:when test="sprintreview/slides/slide[header/@class='bug']">
        <section class="slide" id="intro" >
            <h2 class="story done">Bugs Resolved</h2>
            <ul class="stories">
                <xsl:for-each select="sprintreview/slides/slide[header/@class='bug']">
                <li class="story done"><xsl:value-of select="*"/> </li>
                </xsl:for-each>
            </ul>        
        </section>    
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
</xsl:choose>    


<xsl:for-each select="sprintreview/slides/slide">
    <section class="slide" id="{@id}" style="{@style}">
    	<xsl:copy-of select="./*"/>
    </section>
</xsl:for-each>

<section class="slide" id="intro" >
    <table align="center">
        <tr>
            <td align="left"><h4 class="center">Sprint Facts</h4></td>
        </tr>
        <tr>
            <td style="width:1000px;">
                <img src="img/burndown.jpg" style="width:100%;height:100%;" />
            </td>            
        </tr>
        <tr>
        <td align="left">
            <h6 class="center">Velocity Sprint <xsl:value-of select="sprintreview/@id"/>: <xsl:value-of select="sum(sprintreview/slides/slide/header[@class='story done']/@points)"/></h6>
            <h6 class="center">Commitment: <xsl:value-of select="sum(sprintreview/slides/slide/header/@points)"/></h6>
        </td>
        </tr>
    </table>
</section>


<section class="slide" style="background-image: url('../deck/slides/confused-chan.jpg');  background-repeat:no-repeat; background-attachment:fixed; background-position:center">
	<h1 class="center">Any Questions?</h1>
</section>

<section class="slide" style="background-image: url('../deck/slides/thank-you.jpg');  background-repeat:no-repeat; background-attachment:fixed; background-position:center">
	<h1 class="center">Thank you!</h1>
</section>

<!-- End slides. -->


<!-- Begin extension snippets. Add or remove as needed. -->

<!-- deck.navigation snippet -->
<a href="#" class="deck-prev-link" title="Previous">&#8592;</a>
<a href="#" class="deck-next-link" title="Next">&#8594;</a>

<!-- deck.status snippet -->
<p class="deck-status">
	<span class="deck-status-current"></span>
	/
	<span class="deck-status-total"></span>
</p>

<!-- deck.goto snippet -->
<form action="." method="get" class="goto-form">
	<label for="goto-slide">Go to slide:</label>
	<input type="text" name="slidenum" id="goto-slide" list="goto-datalist" />
	<datalist id="goto-datalist"></datalist>
	<input type="submit" value="Go" />
</form>

<!-- deck.hash snippet -->
<a href="." title="Permalink to this slide" class="deck-permalink">#</a>

<!-- End extension snippets. -->


<!-- Required JS files. -->
<script src="../deck/lib/jquery-1.7.2.min.js"></script>
<script src="../deck/lib/jquery-fullscreen.js"></script>
<script src="../deck/core/deck.core.js"></script>

<!-- Extension JS files. Add or remove as needed. -->
<script src="../deck/core/deck.core.js"></script>
<script src="../deck/extensions/hash/deck.hash.js"></script>
<script src="../deck/extensions/menu/deck.menu.js"></script>
<script src="../deck/extensions/goto/deck.goto.js"></script>
<script src="../deck/extensions/status/deck.status.js"></script>
<script src="../deck/extensions/navigation/deck.navigation.js"></script>
<script src="../deck/extensions/scale/deck.scale.js"></script>

<!-- Initialize the deck. You can put this in an external file if desired. -->
<script>
	$(function() {
		$.deck('.slide');
	});
</script>
<xsl:copy-of select="slides/initscript/*"/>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
