<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="list-credibility-data.xsl"/>

	<xsl:template name="credibility-template" >
    <xsl:param name="teamname" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    
    <script type="text/javascript">
        $(function() {
                  var chartCredibilityOptions = {
                        chart: {
                          renderTo: 'containerchartCredibility',
                          zoomType: 'xy'
                        },
                        title : {
                            text : 'Credibility for <xsl:value-of select="$teamname" />',
                        },
                        subtitle : {
                            text : '(Velocity/Commitment)',
                            x : -20
                        },
                        xAxis : {
                            categories : [ <xsl:call-template name="listcredibilitysprints">
									           <xsl:with-param name="releasedoc" select="$releasedoc" />
									           <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                           </xsl:call-template> ]
                        },
                        yAxis : [{
                            title : {
                                text : 'Velocity (Pts)'
                            },
                            opposite: false
                        },{
                            title : {
                                text : 'Commitment (Pts)'
                            },
                            opposite: false
                        },{
                        	title : {
                                text : 'Credibility factor (%)'
                            },
                            opposite: true
                        }],
                        tooltip : {
                            valueSuffix : ''
                        },
                        series : [
                                {
                                    name : 'Velocity',
                                    index : 1,
                                    data : [ <xsl:call-template name="listcredibilityvelocities">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color: '#FF0000'
                                },
                                {
                                    name : 'Commitment',
                                    index : 2,
                                    data : [ <xsl:call-template name="listcredibilitycommitments">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    color : '#104E8B'
                                },
                                {
                                    type : 'column',
                                    name : 'Credibility',
                                    index : 0,
                                    data : [ <xsl:call-template name="listcredibilities">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'yellowgreen',
                                    yAxis: 2
                                } ]
                    };
                    var chartchartCredibility = new Highcharts.Chart(jQuery.extend(true, {}, chartCredibilityOptions));
        });
    </script>
    <div id="containerchartCredibility" style="min-width: 900px; height: 500px; margin: 0 auto"></div>
    


	</xsl:template>
</xsl:stylesheet>