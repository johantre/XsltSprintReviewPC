<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="scrum-tools/burndown-template.xsl"/>
<xsl:import href="slide-tools/story-slide-template.xsl"/>
    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/">
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
                                    <tr><td align="right"><h4 class="center">Sprint Review</h4></td></tr>
                                    <tr><td align="right"><h4 class="center">Team: <xsl:value-of select="@name" /></h4></td></tr>
                                    <tr><td align="right"><h4 class="center">Sprint: <xsl:value-of select="../../*/@id" /></h4></td>
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
                                    <xsl:choose>
                                        <xsl:when test="@type='sprint-intro'">
                                            <h1 class="rotated">INTRO</h1>
                                        </xsl:when>
                                        <xsl:when test="@type='sprint-goal'">
                                            <h1 class="rotated">GOAL</h1>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <h1 class="rotated">SPRINT</h1>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <header>
                                        <h3>
                                            <xsl:value-of select="../../@title" />
                                        </h3>
                                    </header>
                                    <xsl:copy-of select="./*" />
                                </section>
                        </xsl:for-each>

                        <section class="slide" data-transition="zoom" style="text-align: left;"><!-- List "Done" Stories. -->
                            <h2>User Stories Done</h2>
                            <br></br>
                            <xsl:choose>
                                <xsl:when test="sprintreview/stories/story[@state='story done']">
                                    <ul class="stories">
                                        <xsl:for-each select="sprintreview/stories/story[@state='story done']">
                                            <li class="story done"><xsl:value-of select="@title" /><span class="sp">(SP: <xsl:value-of select="@points" />)</span></li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:when>
                                <xsl:otherwise>
                                    <ul class="stories"><li class="story not-done">NONE</li></ul>
                                </xsl:otherwise>
                            </xsl:choose>
                        </section>

                        <xsl:choose>
                            <xsl:when test="sprintreview/stories/story[@state='story not-done']"><!-- List "Not Done" Stories. -->
                                <section class="slide" data-transition="zoom" style="text-align: left;">
                                    <h2 class="story not-done">User Stories NOT Done</h2>
                                    <br></br>
                                    <ul class="stories">
                                        <xsl:for-each select="sprintreview/stories/story[@state='story not-done']">
                                            <li class="story not-done">
                                                <xsl:value-of select="@title" />
                                                <span class="sp">(SP: <xsl:value-of select="@points" />)</span>
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

                        <section class="slide" style="text-align: left;"><!-- List ending slides. -->
                            <table align="center">
                                <tr><td align="left"><h4 class="center">Sprint Facts</h4></td></tr>
                                
                                <tr><td>
                                <xsl:call-template name="burndown-template">
                                    <xsl:with-param name="teamname" select="sprintreview/team/@name" />
                                    <xsl:with-param name="sprintnumber" select="sprintreview/@id" />
                                </xsl:call-template>
                                </td></tr>                                
                                
                                <tr>
                                    <td align="left">
                                        <h4 class="center">Velocity Sprint <xsl:value-of select="sprintreview/@id" />:
                                            <xsl:value-of select="sum(sprintreview/stories/story[@state='story done']/@points)" />
                                        </h4>
                                        <h4 class="center">Commitment:
                                            <xsl:value-of select="sum(sprintreview/stories/story/@points)" />
                                        </h4>
                                    </td>
                                </tr>
                            </table>
                        </section>
                        <section class="slide" style="background-image: url('../style/tomtom/img/confused-chan.jpg');  
                                                      background-repeat:no-repeat;
                                                      background-size:100% 85%">
                            <h1 class="last">Any Questions?</h1>
                        </section>
                        <section class="slide" style="background-image: url('../style/tomtom/img/thank-you.jpg');  
                                                      background-repeat:no-repeat;
                                                      background-size:100% 100%">
                            <h1 class="last">Thank you!</h1>
                        </section>
                        <!-- End slides. -->

                    </div>

                    <p class="slide-number"></p>
                </div>

                <!--a href="." title="Permalink to this slide" class="deck-permalink">#</a -->


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
