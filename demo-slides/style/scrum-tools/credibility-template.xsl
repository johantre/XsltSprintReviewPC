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
                        column: {
                            stacking: 'normal'
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
                                text : 'Predictability (%)'
                            },
                            opposite: true
                        },{
                            title : {
                                text : 'Credibility (trend in %)'
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
                                    data : [ <xsl:call-template name="listcredibilityvelocities">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    lineWidth: 1,
                                    color: '#FF0000',
                                    visible: false
                                },
                                {
                                    name : 'Commitment (Pts)',
                                    index : 4,
                                    data : [ <xsl:call-template name="listcredibilitycommitments">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    lineWidth: 1,
                                    color : '#104E8B',
                                    visible: false
                                },
                                {
                                    type : 'column',
                                    name : 'Predictability (Vel/Comm %)',
                                    index : 0,
                                    data : [ <xsl:call-template name="listpredictibilities">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'yellowgreen',
                                    stack: 1,
                                    yAxis: 2
                                },
                                {
                                    type : 'column',
                                    name : 'Hands-on Capacity (MD)',
                                    index : 5,
                                    data : [ <xsl:call-template name="listhandsoncapacity">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'blue',
                                    stack: 0,
                                    yAxis: 2,
                                    visible: false
                                },
                                {
                                    type : 'column',
                                    name : 'Tester Capacity (MD)',
                                    index : 6,
                                    data : [ <xsl:call-template name="listtestercapacity">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'blue',
                                    stack: 0,
                                    yAxis: 2,
                                    visible: false
                                },
                                {
                                    type : 'column',
                                    name : 'Modeler Capacity (MD)',
                                    index : 7,
                                    data : [ <xsl:call-template name="listmodelercapacity">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'pink',
                                    stack: 0,
                                    yAxis: 2,
                                    visible: false
                                },{
                                    name : 'Credibility (Vel/Comm trend %)',
                                    index : 2,
                                    data : [ <xsl:call-template name="listcredibilities">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : 'green',
                                    yAxis: 2
                                } ]
                    };
                    var chartchartCredibility = new Highcharts.Chart(jQuery.extend(true, {}, chartCredibilityOptions));
        });
    </script>
    <div id="containerchartCredibility" style="min-width: 900px; height: 500px; margin: 0 auto"></div>
    


	</xsl:template>
</xsl:stylesheet>