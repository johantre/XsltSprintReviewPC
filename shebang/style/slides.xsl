<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="scrum-tools/burndown-template.xsl" />
<xsl:import href="scrum-tools/credibility-template.xsl" />
<xsl:import href="scrum-tools/fetch-thisrelease.xsl" />
<xsl:import href="scrum-tools/fetch-thissprint.xsl" />
<xsl:import href="slide-tools/story-slide-template.xsl" />

    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/" > 
        <xsl:variable name="sprintfolder" select="/sprintreview/@folder" /><!-- sprintfolder of the current review -->
        <xsl:variable name="releasedoc" select="document('release-burndown.xml')" />
	    <xsl:variable name="thisreleasename" >
	        <xsl:call-template name="fetchthisrelease">
	            <xsl:with-param name="sprintfolder" select="$sprintfolder" />
	            <xsl:with-param name="releasedoc" select="$releasedoc" />
	        </xsl:call-template>
	    </xsl:variable>
	    <xsl:variable name="thissprintname" >
	        <xsl:call-template name="fetchthissprint">
	            <xsl:with-param name="sprintfolder" select="$sprintfolder" />
	            <xsl:with-param name="releasedoc" select="$releasedoc" />
	        </xsl:call-template>
	    </xsl:variable>
	
        <html>
            <head>
                <title>Sprint Review</title>
                <meta charset="utf-8" />
                <meta name="apple-mobile-web-app-capable" content="yes" />
                <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes" />

                <link rel="stylesheet" href="../style/tomtom/tomtom.core.css" />
                <link rel="stylesheet" href="../style/tomtom/tomtom.css" />
                <link rel="stylesheet" href="../style/tomtom/table/table.statistics.css" />
                <link rel="stylesheet" href="../style/reveal/css/reveal.min.css" />
                
                <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sunburst&amp;callback=js_ident" />
                <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js" />
                <!-- If the query includes 'print-pdf', use the PDF print sheet -->
                <script>
                    document.write('
                    <link rel="stylesheet" href="../style/reveal/css/print/'
                                                            + (window.location.search.match(/print-pdf/gi) ? 'pdf' : 'paper')
                                                            + '.css" type="text/css" media="print" />
                    ');
                </script>

                <!--[if lt IE 9]> <script src="lib/js/html5shiv.js"></script> <![endif] -->
            </head>

            <body class="tomtom-container">

                <div class="reveal">
                    <div class="slides">

                        <xsl:for-each select="sprintreview/team">
                            <section class="slide"><!-- First TomTom group slide. -->
                                <table align="center">
                                    <tr><td width="1140" height="524" 
                                            align="center" style="background-image: url('../style/tomtom/img/TomTomLogo.jpg');  
                                                                  background-repeat:no-repeat;
                                                                  background-size:100% 100%"></td>
                                    </tr>
                                    <tr><td align="right"><h4 class="center">Review Sprint: <xsl:value-of select="$thissprintname" /></h4></td></tr>
                                    <tr><td align="right"><h4 class="center">Team: <xsl:value-of select="@name" /></h4></td></tr>
                                    <tr><td align="right"><h4 class="center">Release: <xsl:value-of select="$thisreleasename" />
                                                                             
                                                          </h4></td> 
                                    <td align="left"><h4 class="center"></h4></td>
                                    </tr>
                                </table>
                            </section>
                            <section class="slide" align="left"><!-- Team slide. -->
                                <div class="info">
                                    <h3 class="center">Team Composition</h3><br />
                                    <p class="team">
                                        <span class="caption">Scrum Team Members: </span>
                                        <span class="content">
                                            <xsl:for-each select="member"><br/>&#8226;<xsl:copy-of select="." />
                                            </xsl:for-each>
                                        </span>
                                    </p>
                                    <p class="scrum-master">
                                        <span class="caption">Product Owner: </span>
                                        <span class="content"><xsl:value-of select="productowner" /></span>
                                    </p>
                                    <p class="scrum-master">
                                        <span class="caption">Scrum Master: </span>
                                        <span class="content"><xsl:value-of select="scrummaster" /></span>
                                    </p>
                                </div>
                            </section>
                        </xsl:for-each>

                        <xsl:for-each select="sprintreview/intro/slides/slide"><!-- Introduction slides. -->
                                <section class="slide" data-transition="zoom" style="{@style} text-align: left;">
                                    <xsl:call-template name="storyslide">
                                        <xsl:with-param name="state" select="'story done'" />
                                        <xsl:with-param name="mksid" select="''" />
                                        <xsl:with-param name="title" select="@title" />
                                    </xsl:call-template>
                                </section>
                        </xsl:for-each>

                        <section class="slide" data-transition="zoom" style="text-align: left;"><!-- List "story done" Stories. -->
                            <h2>User Stories Done</h2>
                            <br></br>
                            <xsl:choose>
                                <xsl:when test="sprintreview/stories/story[@state='story done']">
                                    <ul class="stories">
                                        <xsl:for-each select="sprintreview/stories/story[@state='story done']">
                                            <li class="story done"><xsl:value-of select="@title" /><span class="sp"> (SP: <xsl:value-of select="@points" />)</span></li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:when>
                                <xsl:otherwise>
                                    <ul class="stories"><li class="story not-done">NONE</li></ul>
                                </xsl:otherwise>
                            </xsl:choose>
                        </section>

                        <xsl:choose>
                            <xsl:when test="sprintreview/stories/story[@state='story uncommitted']"><!-- List "story uncommitted" Stories. -->
                                <section class="slide" data-transition="zoom" style="text-align: left;">
                                    <h2 class="story uncommitted">User Stories ADDED</h2>
                                    <br></br>
                                    <ul class="stories">
                                        <xsl:for-each select="sprintreview/stories/story[@state='story uncommitted']">
                                            <li class="story done">
                                                <xsl:value-of select="@title" />
                                                <span class="sp"> (SP: <xsl:value-of select="@points" />)</span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </section>
                            </xsl:when>
                            <xsl:otherwise>
                            </xsl:otherwise>
                        </xsl:choose>

                        <xsl:choose>
                            <xsl:when test="sprintreview/stories/story[@state='story not-done']"><!-- List "story not-done" Stories. -->
                                <section class="slide" data-transition="zoom" style="text-align: left;">
                                    <h2 class="story not-done">User Stories NOT Done</h2>
                                    <br></br>
                                    <ul class="stories">
                                        <xsl:for-each select="sprintreview/stories/story[@state='story not-done']">
                                            <li class="story not-done">
                                                <xsl:value-of select="@title" />
                                                <span class="sp"> (SP: <xsl:value-of select="@points" />)</span>
                                                <span class="sp">Done: <xsl:value-of select="@percentage-done" />%</span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </section>
                            </xsl:when>
                            <xsl:otherwise>
                            </xsl:otherwise>
                        </xsl:choose>

                        <xsl:choose>
                            <xsl:when test="sprintreview/stories/story[@state='bug']"><!-- List "Bug" Stories. -->
                                <section class="slide" style="text-align: left;">
                                    <h2 class="story done">Bugs Resolved</h2>
                                    <br></br>
                                    <ul class="stories">
                                        <xsl:for-each select="sprintreview/stories/story[@state='bug']">
                                            <li class="story done"><xsl:value-of select="*" /></li>
                                        </xsl:for-each>
                                    </ul>
                                </section>
                            </xsl:when>
                            <xsl:otherwise>
                            </xsl:otherwise>
                        </xsl:choose>

                        <!-- Show ALL XML slides; first slide of story: 'zoom', others 'cube' default -->
                        <xsl:for-each select="sprintreview/stories/story/slides">
                            <xsl:for-each select="slide[1]">
                                <section class="slide" data-transition="zoom" style="{@style} text-align: left;">
                                    <xsl:call-template name="storyslide">
                                        <xsl:with-param name="state" select="../../@state" />
                                        <xsl:with-param name="mksid" select="../../@mksid" />
                                        <xsl:with-param name="title" select="../../@title" />
                                    </xsl:call-template>
                                </section>
                            </xsl:for-each>
                            <xsl:for-each select="slide[position() &gt; 1]">
                                <section class="slide" style="{@style} text-align: left;">
                                    <xsl:call-template name="storyslide">
                                        <xsl:with-param name="state" select="../../@state" />
                                        <xsl:with-param name="mksid" select="../../@mksid" />
                                        <xsl:with-param name="title" select="../../@title" />
                                    </xsl:call-template>
                                </section>
                            </xsl:for-each>
                        </xsl:for-each>
                        
                        
                        <xsl:for-each select="sprintreview/finish/slides/slide"><!-- Introduction slides. -->
                                <section class="slide" data-transition="zoom" style="{@style} text-align: left;">
                                    <xsl:call-template name="storyslide">
                                        <xsl:with-param name="state" select="'story done'" />
                                        <xsl:with-param name="mksid" select="''" />
                                        <xsl:with-param name="title" select="@title" />
                                    </xsl:call-template>
                                </section>
                        </xsl:for-each>

                        <section class="slide" style="text-align: left;"><!-- show its burn down, with their respective sums -->
                            <table align="center">
                                <tr><td align="left"><h4 class="center">Sprint Facts for Sprint <xsl:value-of select="$thissprintname" /></h4></td></tr>
                                <tr><td align="left">
                                    <h4 class="center" style="font-size : 1em">Velocity : 
                                        <xsl:value-of select="sum(/sprintreview/stories/story[not(@state='story not-done')]/@points)" /> <!-- ALL but 'not-done', incl. stories of other releases -->
                                    <br/>Commitment :
                                        <xsl:value-of select="sum(/sprintreview/stories/story[not(@state='story uncommitted')]/@points)" /><!-- ALL but 'uncommitted', incl. stories of other release -->
                                    </h4>
                                </td></tr>
                                <tr><td><br/></td></tr>
                                <tr><td><h4 class="center">Credibility Trend for <xsl:value-of select="/sprintreview/team/@name" /></h4>
									<xsl:call-template name="credibility-template">
									    <xsl:with-param name="teamname" select="/sprintreview/team/@name" />
									    <xsl:with-param name="releasedoc" select="$releasedoc" />
									    <xsl:with-param name="thissprintfolder" select="$sprintfolder" />
									</xsl:call-template></td></tr>                                
                            </table>
                        </section>


                        <xsl:for-each select="$releasedoc//releases/release/sprintfolders/sprintfolder"><!-- cycle through ALL sprints... -->
                            <xsl:variable name="releaseid" select="../../@id"/>
                            <xsl:variable name="releasename" select="../../@name"/>
                            <xsl:variable name="releasecount" select="position()"/>
                            <xsl:variable name="fetchedfolder" select="."/>
                            <xsl:choose>
                                <xsl:when test="contains($fetchedfolder, $sprintfolder)"><!-- till we find the sprintfolder we're looking for... -->
                                    <xsl:variable name="sprintname" select="@name"/>
                                    
                                    <section class="slide" style="text-align: left;"><!-- show its burn down, with their respective sums -->
                                        <table align="center">
                                            <tr><td align="left"><h4 class="center">Release Facts of <xsl:value-of select="$releasename" /> </h4></td></tr>
                                            <tr><td>
                                                <xsl:call-template name="burndown-template">
                                                    <xsl:with-param name="teamname" select="/sprintreview/team/@name" />
                                                    <xsl:with-param name="sprintfolder" select="$sprintfolder" />
                                                    <xsl:with-param name="releaseid" select="$releaseid" />
                                                    <xsl:with-param name="releasename" select="$releasename" />
                                                    <xsl:with-param name="releasecount" select="$releasecount" />
                                                </xsl:call-template>
                                            </td></tr>                                
                                            <tr><td align="left"></td></tr>
                                        </table>
                                    </section>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                                
                        <section class="slide" style="background-image: url('../style/tomtom/img/confused-chan.jpg');  
                                                      background-repeat:no-repeat;
                                                      background-size:100%">
                            <h1 class="last">Any Questions?</h1>
                        </section>
                        <section class="slide" style="background-image: url('../style/tomtom/img/thank-you.jpg');  
                                                      background-repeat:no-repeat;
                                                      background-size:100%">
                            <h1 class="last">Thank you!</h1>
                        </section>
                        <!-- End slides. -->

                    </div>

                    <p class="slide-number"></p>
                </div>

                <script src="../style/highcharts/js/highcharts.js"></script>
                <script src="../style/highcharts/js/modules/exporting.js"></script>
                <script type="text/javascript">
                    Highcharts.setOptions({
                        chart: {
                            zoomType: 'xy'
                          },
                        title : {
                            x : -20
                        },
                        subtitle : {
                            text : 'Cumulative Committed vs. Velocity',
                            x : -20
                        },
                        xAxis : {
                            tickmarkPlacement: 'on'
                        },
                        yAxis : {
                            title : {
                                text : 'Total to burn (points)'
                            },
                            plotLines : [ {
                                value : 0,
                                width : 100
                            }],
                            min : 0
                        },
                        tooltip : {
                            valueSuffix : 'Pts.',
                            valueDecimals: 2
                        },
                        legend : {
                            layout : 'vertical',
                            align : 'right',
                            verticalAlign : 'middle',
                            borderWidth : 0
                        }    
                    });
                </script>

                <!-- End extension snippets. -->
                <script src="../style/reveal/lib/js/head.min.js"></script>
                <!-- script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script -->
                <script type="text/javascript" src="../style/reveal/js/reveal.min.js"></script>
                <script>
                    // Full list of configuration options available here:
                    // https://github.com/hakimel/reveal.js#configuration
                    Reveal.initialize({
                    controls : true,
                    progress : true,
                    history : true,
                    center : true,

                    theme : Reveal.getQueryHash().theme || 'moon', // available themes are in /css/theme
                    transition : Reveal.getQueryHash().transition, // || 'linear', // default/cube/page/concave/zoom/linear/fade/none

                    // Optional libraries used to extend on reveal.js
                    dependencies : [ {
                    src :
                    '../style/reveal/js/classList.js',
                    condition : function() {
                    return !document.body.classList;
                    }
                    }, {
                    src : '../style/reveal/plugin/markdown/marked.js',
                    condition : function() {
                    return !!document.querySelector('[data-markdown]');
                    }
                    }, {
                    src : '../style/reveal/plugin/markdown/markdown.js',
                    condition : function() {
                    return !!document.querySelector('[data-markdown]');
                    }
                    }, {
                    src : '../style/reveal/plugin/highlight/highlight.js',
                    async : true,
                    callback : function() {
                    hljs.initHighlightingOnLoad();
                    }
                    }, {
                    src : '../style/reveal/plugin/zoom-js/zoom.js',
                    async : true,
                    condition : function() {
                    return !!document.body.classList;
                    }
                    }, {
                    src : '../style/reveal/plugin/notes/notes.js',
                    async : true,
                    condition : function() {
                    return !!document.body.classList;
                    }
                    }
                    // { src: 'plugin/search/search.js', async: true, condition: function() { return !!document.body.classList; } }
                    // { src: 'plugin/remotes/remotes.js', async: true, condition: function() { return !!document.body.classList; } }
                    ]
                    });

                </script>

                <xsl:copy-of select="slides/initscript/*" />
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
