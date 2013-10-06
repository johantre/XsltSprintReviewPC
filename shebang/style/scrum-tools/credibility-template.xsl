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
                            text : '(Velocity/Commitment trend)',
                            x : -20
                        },
                        xAxis : {
                            categories : [ <xsl:call-template name="listcredibilitysprints">
									           <xsl:with-param name="releasedoc" select="$releasedoc" />
									           <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                           </xsl:call-template> ]
                        },
                        plotOptions: {
                            column: {
                                stacking: 'normal'
                            }
                        },
                        yAxis : [{
                            title : {
                                text : 'Velocity (Pts)  Commitment (Pts)'
                            },
                            opposite: false
                        },{
                            title : {
                                text : 'Predictability (%)    Credibility (trend in %)'
                            },
                            opposite: true
                        }],
                        tooltip : {
                            valueSuffix : ''
                        },
                        series : [
                                {
                                    name : 'Velocity (Pts)',
                                    index : 3,
                                    legendIndex : 2,
                                    data : [ <xsl:call-template name="listcredibilityvelocities">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    lineWidth: 1,
                                    color: '#FF0000',
                                    visible: false,
                                    yAxis: 0
                                },
                                {
                                    name : 'Commitment (Pts)',
                                    index : 4,
                                    legendIndex : 3,
                                    data : [ <xsl:call-template name="listcredibilitycommitments">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    lineWidth: 1,
                                    color : '#104E8B',
                                    visible: false,
                                    yAxis: 0
                                },
                                {
                                    type : 'column',
                                    name : 'Predictability (Vel/Comm %)',
                                    index : 0,
                                    legendIndex : 0,
                                    data : [ <xsl:call-template name="listpredictibilities">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'yellowgreen',
                                    stack: 1,
                                    yAxis: 1
                                },
                                {
                                    name : 'Credibility (Vel/Comm trend %)',
                                    index : 2,
                                    legendIndex : 1,
                                    data : [ <xsl:call-template name="listcredibilities">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'green',
                                    yAxis: 1
                                } ]
                    };
                    var chartchartCredibility = new Highcharts.Chart(jQuery.extend(true, {}, chartCredibilityOptions));
        });
    </script>
    <div id="containerchartCredibility" style="min-width: 900px; height: 500px; margin: 0 auto"></div>
    


	</xsl:template>
</xsl:stylesheet>