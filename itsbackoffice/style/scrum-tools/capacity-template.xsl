<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="list-credibility-data.xsl"/>

	<xsl:template name="capacity-template" >
    <xsl:param name="teamname" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    
    <script type="text/javascript">
        $(function() {
                  var chartCapacityOptions = {
                        chart: {
                          renderTo: 'containerchartCapacity',
                          zoomType: 'xy'
                        },
                        title : {
                            text : 'Capacity trend for <xsl:value-of select="$teamname" />',
                        },
                        subtitle : {
                            text : '(Capacity vs Velocity vs Commitment trend)',
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
                                text : 'Capacity (MD)'
                            },
                            opposite: true,
                            showEmpty: false
                        },{
                            title : {
                                text : 'Velocity (Pts)  Commitment (Pts)'
                            },
                            opposite: false,
                            showEmpty: false                            
                        }],
                        tooltip : {
                            valueSuffix : ''
                        },
                        legend : {
                            layout : 'horizontal',
                            align : 'bottom',
                            verticalAlign : 'bottom',
                            borderWidth : 0
                        },
                        plotOptions: {
                            column: {
                                stacking: 'normal'
                            }                        
                        },series : [
                                {
                                    name : 'Velocity (Pts)',
                                    index : 3,
                                    legendIndex : 2,
                                    data : [ <xsl:call-template name="listcredibilityvelocities">
									         	<xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    lineWidth: 2,
                                    shadow: true,
                                    color: '#990000',
                                    yAxis: 1
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
                                    lineWidth: 2,
                                    color : '#104E8B',
                                    yAxis: 1
                                },                           
                                {
                                    type : 'column',
                                    name : 'Hands-on Capacity (MD)',
                                    index : -1,
                                    legendIndex : 4,
                                    data : [ <xsl:call-template name="listhandsoncapacity">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : '#08298A',
                                    stack: 0,
                                    yAxis: 0
                                },
                                {
                                    type : 'column',
                                    name : 'Tester Capacity (MD)',
                                    index : -1,
                                    legendIndex : 5,
                                    data : [ <xsl:call-template name="listtestercapacity">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : '#2E64FE',
                                    stack: 0,
                                    yAxis: 0
                                },
                                {
                                    type : 'column',
                                    name : 'Modeler Capacity (MD)',
                                    index : -1,
                                    legendIndex : 6,
                                    data : [ <xsl:call-template name="listmodelercapacity">
                                                <xsl:with-param name="releasedoc" select="$releasedoc" />
                                                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                                             </xsl:call-template> ],
                                    color : '#A9D0F5',
                                    stack: 0,
                                    yAxis: 0
                                } ]
                    };
                    var chartchartCapacity = new Highcharts.Chart(jQuery.extend(true, {}, chartCapacityOptions));
        });
        
    </script>
    <div id="containerchartCapacity" style="min-width: 700px; height: 550px; margin: 0 auto"></div>
    


	</xsl:template>
</xsl:stylesheet>