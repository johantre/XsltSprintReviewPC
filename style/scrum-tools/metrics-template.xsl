<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="list-metrics-data.xsl"/>

	<xsl:template name="code-metrics-template">
    <xsl:param name="teamname" />
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    <xsl:param name="projectname" />
    <xsl:variable name="teamfolderescaped" select="translate($teamfolder, '-', '')" />
    <xsl:variable name="projectnameescaped" select="translate($projectname, ' .-', '')" />
    
    <script type="text/javascript">
        $(function() {
        
                  var chartMetricsOptions = {
                        chart: {
                          renderTo: 'containerChartMetrics<xsl:value-of select="$teamfolderescaped" /><xsl:value-of select="$projectnameescaped" />',
                          zoomType: 'xy'
                        },
                        title : {
                            text : 'Quality trend for <xsl:value-of select="$teamname" />',
                        },
                        subtitle : {
                            text : '(Code Quality)',
                            x : -20
                        },
                        xAxis : {
                            range: 8,
                            categories : [ <xsl:call-template name="listsprintnames">
									                             <xsl:with-param name="teamfolder" select="$teamfolder" />
                                               <xsl:with-param name="releasedoc" select="$releasedoc" />
									                             <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                           </xsl:call-template> ]
                        },
                        scrollbar: {
                            enabled: true
                        },
                        yAxis : [{
                            title : {
                                text : 'Lines of Code'
                            },
                            opposite: false,
                            showEmpty: false,
                            id : 'linesAxis',
                            min : 0,
                            max : <xsl:call-template name="listmaxlinesofcode">
                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template>                            
                        },
                        {
                            title : {
                                text : 'Tests'
                            },
                            opposite: true,
                            showEmpty: false,
                            id : 'testsAxis',
                            min : 0,
                            max : <xsl:call-template name="listmaxunittests">
                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template>
                        },
                                                {
                            title : {
                                text : 'Complexity'
                            },
                            opposite: true,
                            showEmpty: false,
                            id : 'complexityAxis',
                            min : 0,
                            max : 20,
                        }
                        ],
                        series : [
                                {
                                    name : 'Lines of Code (lower is better)',
                                    data : [ <xsl:call-template name="listqualitylinesofcode">
                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                                <xsl:with-param name="projectname" select="$projectname" />
                                             </xsl:call-template> ],
                                    lineWidth: 2,
                                    shadow: true,
                                    color: '#F79646',
                                    yAxis : 'linesAxis'
                                },
                                {
                                    name : 'Complexity (lower is better)',
                                    data : [ <xsl:call-template name="listqualitycomplexity">
                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                                <xsl:with-param name="projectname" select="$projectname" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    lineWidth: 2,
                                    color : '#C0504D',
                                    shadow: true,
                                    yAxis : 'complexityAxis'
                                },                                
                                {
                                    name : 'Unit Tests (higher is better)',
                                    data : [ <xsl:call-template name="listqualityunittests">
                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                                <xsl:with-param name="projectname" select="$projectname" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    lineWidth: 2,
                                    color : '#00B050',
                                    shadow: true,
                                    yAxis : 'testsAxis'
                                },
                                {
                                    name : 'Step Files (higher is better)',
                                    data : [ <xsl:call-template name="listqualitystepfiles">
                                                <xsl:with-param name="teamfolder" select="$teamfolder" />
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                                <xsl:with-param name="projectname" select="$projectname" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    lineWidth: 2,
                                    color : '#9BBB59',
                                    shadow: true,
                                    yAxis : 'testsAxis'
                                }                                
                                ],
                         exporting: {
                            sourceWidth: 700,
                            sourceHeight: 550,
                        }
                    };
                    new Highcharts.Chart(jQuery.extend(true, {}, chartMetricsOptions));
        });
        
    </script>
    <div id="containerChartMetrics{$teamfolderescaped}{$projectnameescaped}" style="width: 950px; min-width: 700px; height: 550px; margin: 0 0"></div>
	</xsl:template>
</xsl:stylesheet>