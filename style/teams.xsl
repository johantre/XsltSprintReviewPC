<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="scrum-tools/capacity-template.xsl" />
<xsl:import href="scrum-tools/credibility-template.xsl" />
<xsl:import href="scrum-tools/burndown-template.xsl" />

    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/" >

        <html>
            <head>
                <title>Team overviews metrics</title>
                <meta charset="utf-8" />
                <meta name="apple-mobile-web-app-capable" content="yes" />
                <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes" />

                <link rel="stylesheet" href="../style/prodata/prodata.core.css" />
                <link rel="stylesheet" href="../style/prodata/prodata.css" />
                <link rel="stylesheet" href="../style/prodata/table/table.statistics.css" />
                <link rel="stylesheet" href="../style/reveal/css/reveal.min.css" />
                
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
                        <xsl:for-each select="teamfolders/teamfolder">
                            <xsl:variable name="teamfolder" select="." />
                            <xsl:variable name="teamfolderreleasedoc" select="document(concat('../', $teamfolder, '//style/release-burndown.xml'))" />
                            <xsl:variable name="lastsprint" select="($teamfolderreleasedoc//releasedata/sprints/sprint)[last()]" />
                
                            <section align="left"> 
                                <section class="slide" align="left"><!-- Team credibility. -->
                                    <div class="info">
                                        <table align="center">
                                            <tr><td><a target="_blank" href="../{$teamfolder}"><h4 class="center">Credibility Trend for <xsl:value-of select="$teamfolder" /></h4></a> <!-- teamname = teamfolder for now -->
                                                    <xsl:call-template name="credibility-template">
                                                        <xsl:with-param name="teamname" select="$teamfolder" /> <!-- teamname = teamfolder for now -->
                                                        <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                        <xsl:with-param name="releasedoc" select="$teamfolderreleasedoc" />
                                                        <xsl:with-param name="teamcount" select="position()"/>
                                                        <xsl:with-param name="thissprintfolder" select="$lastsprint" />
                                                    </xsl:call-template></td></tr>                                
                                        </table>
                                    </div>
                                </section>
                                <section class="slide" style="text-align: left;"><!-- show its burn down, with their respective sums -->
                                    <table align="center">
                                        <tr><td align="right"><a target="_blank" href="../{$teamfolder}"><h4 class="center">Capacity trend for <xsl:value-of select="$teamfolder" /></h4></a></td></tr>
                                        <tr><td align="right">
                                                <xsl:call-template name="capacity-template">
                                                    <xsl:with-param name="teamname" select="$teamfolder" /> <!-- teamname = teamfolder for now -->
                                                    <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                    <xsl:with-param name="releasedoc" select="$teamfolderreleasedoc" />
                                                    <xsl:with-param name="thissprintfolder" select="$lastsprint" />
                                                </xsl:call-template></td></tr>
                                        <tr><td align="left"></td></tr>
                                    </table>
                                </section>
                                
                                <xsl:for-each select="$teamfolderreleasedoc//releases/release/sprintfolders/sprintfolder"><!-- cycle through ALL sprints... -->
                                    <xsl:variable name="releaseid" select="../../@id"/>
                                    <xsl:variable name="releasename" select="../../@name"/>
                                    <xsl:variable name="releasecount" select="position()"/>
                                    <xsl:variable name="fetchedfolder" select="."/>
                
                                    <xsl:choose>
                                        <xsl:when test="contains($fetchedfolder, $lastsprint)"><!-- till we find the sprintfolder we're looking for... -->
                                            <xsl:variable name="sprintname" select="@name"/>
                                            
                                            <section class="slide" style="text-align: left;"><!-- show its burn down, with their respective sums -->
                                                <table align="center">
                                                    <tr><td align="left"><a target="_blank" href="../{$teamfolder}"><h4 class="center">Release Facts of <xsl:value-of select="$releasename" /> from <xsl:value-of select="$teamfolder" /> </h4></a></td></tr>
                                                    <tr><td><xsl:call-template name="burndown-template">
                                                                <xsl:with-param name="teamname" select="$teamfolder" /> <!-- teamname = teamfolder for now -->
                                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                                <xsl:with-param name="sprintfolder" select="$lastsprint" />
                                                                <xsl:with-param name="releaseid" select="$releaseid" />
                                                                <xsl:with-param name="releasename" select="$releasename" />
                                                                <xsl:with-param name="releasecount" select="$releasecount" />
                                                            </xsl:call-template></td></tr>                                
                                                    <tr><td align="left"></td></tr>
                                                </table>
                                            </section>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </section>
                        </xsl:for-each>
                    </div>
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
