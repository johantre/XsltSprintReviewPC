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
	<link rel="stylesheet" href="../deck1/core/deck.core.css" />
	
	<!-- Extension CSS files go here. Remove or add as needed. -->
	<link rel="stylesheet" href="../deck1/extensions/goto/deck.goto.css" />
	<link rel="stylesheet" href="../deck1/extensions/menu/deck.menu.css" />
	<link rel="stylesheet" href="../deck1/extensions/navigation/deck.navigation.css" />
	<link rel="stylesheet" href="../deck1/extensions/status/deck.status.css" />
	<link rel="stylesheet" href="../deck1/extensions/hash/deck.hash.css" />
	<link rel="stylesheet" href="../deck1/extensions/scale/deck.scale.css" />

	<!-- Style theme. More available in /themes/style/ or create your own. -->
	<link rel="stylesheet" href="../deck1/themes/style/tomtom.css" />
	
	<!-- Transition theme. More available in /themes/transition/ or create your own. -->
	<link rel="stylesheet" href="../deck1/themes/transition/horizontal-slide.css" />
	
	<link href='http://fonts.googleapis.com/css?family=Finger+Paint' rel='stylesheet' type='text/css' />

	<!-- Required Modernizr file -->
	<script src="../deck1/lib/modernizr.custom.js"></script>

	<xsl:copy-of select="slides/dependencies/*"/>

</head>
<body class="deck-container">

<!-- Begin slides. Just make elements with a class of slide. -->
<section class="slide" id="intro" style="background-image: url('../deck1/slides/photo.jpg')">
	<h1 class="center"><xsl:value-of select="slides/title"/></h1>
</section>

<section class="slide" id="goal">
    <header>
        <h3>Sprint goals</h3>
    </header>
    <blockquote style="font-size:38px">
	    <xsl:copy-of select="slides/sprint/goal/*"/>
    </blockquote>
</section>

<section class="slide" id="stories">
    <header>
        <h3>Sprint overview - User stories</h3>
    </header>
    <p>The sprint started on the <strong><xsl:value-of select="slides/sprint/started"/></strong> and ended on the <strong><xsl:value-of select="slides/sprint/ended"/></strong>.</p>

    <div class="stories">
        <table>
            <tr>
                <th>Epic</th><th>Story</th><th>SP</th>
            </tr>
<xsl:for-each select="slides/story">
            <tr class="epic">
                <td><xsl:value-of select="@epic"/></td>
                <td class="{@status}"><xsl:value-of select="@title"/></td>
                <td><xsl:value-of select="@sp"/></td>
            </tr>
</xsl:for-each>
        </table>
    </div>

    <div class="info">
        <p class="scrum-master"><span class="caption">Product owner: </span><span class="content"><xsl:value-of select="slides/sprint/productowner"/></span></p>
        <p class="scrum-master"><span class="caption">Scrum master: </span><span class="content"><xsl:value-of select="slides/sprint/scrummaster"/></span></p>
        <p class="team"><span class="caption">Team: </span><span class="content"><xsl:value-of select="slides/sprint/teammembers"/></span></p>
    </div>
</section>

<xsl:for-each select="slides/story/slide">
<section class="slide {@class}" id="{@id}" style="{@style}">
    <header>
        <h3 class="{../@status}"><xsl:value-of select="../@epic"/></h3>
        <h4><xsl:value-of select="../@title"/></h4>
    </header>
	<xsl:copy-of select="./*"/>
</section>
</xsl:for-each>

<section class="slide" style="background-image: url('../deck1/slides/confused-chan.jpg')">
	<h1 class="center">Any Questions?</h1>
</section>

<section class="slide" style="background-image: url('../deck1/slides/thank-you.jpg')">
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
<script src="../deck1/lib/jquery-1.7.2.min.js"></script>
<script src="../deck1/lib/jquery-fullscreen.js"></script>
<script src="../deck1/core/deck.core.js"></script>

<!-- Extension JS files. Add or remove as needed. -->
<script src="../deck1/core/deck.core.js"></script>
<script src="../deck1/extensions/hash/deck.hash.js"></script>
<script src="../deck1/extensions/menu/deck.menu.js"></script>
<script src="../deck1/extensions/goto/deck.goto.js"></script>
<script src="../deck1/extensions/status/deck.status.js"></script>
<script src="../deck1/extensions/navigation/deck.navigation.js"></script>
<script src="../deck1/extensions/scale/deck.scale.js"></script>

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
