<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="list-burndown-data.xsl"/>
    <xsl:import href="fetch-thisrelease.xsl"/>
    <xsl:import href="fetch-thissprint.xsl"/>

	<xsl:template name="burndown-template" >
    <xsl:param name="teamname" />
    <xsl:param name="sprintfolder" />
    <xsl:variable name="releasedoc" select="document('../release-burndown.xml')"/>
    <xsl:variable name="thisreleasename" >
        <xsl:call-template name="fetchthisrelease">
            <xsl:with-param name="sprintfolder" select="$sprintfolder" />
            <xsl:with-param name="releasedoc" select="$releasedoc" />
        </xsl:call-template>
    </xsl:variable>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript">
                    $(function() {
                        $('#container').highcharts(
                                {
                                    title : {
                                        text : 'Release Burn down *<xsl:value-of select="$thisreleasename" />*',
                                        x : -20
                                    //center
                                    },
                                    subtitle : {
                                        text : 'Cumulative Committed vs. Velocity',
                                        x : -20
                                    },
                                    xAxis : {
                                        tickmarkPlacement: 'on',
                                        categories : [ <xsl:call-template name="listsprints">
                                                          <xsl:with-param name="release" select="$thisreleasename"/>
                                                          <xsl:with-param name="releasedoc" select="$releasedoc"/>
                                                       </xsl:call-template> ]
                                    },
                                    yAxis : {
                                        title : {
                                            text : 'Total to burn (points)'
                                        },
                                        plotLines : [ {
                                            value : 0,
                                            width : 100
                                        }],
                                        max : <xsl:call-template name="totalpoints">
                                                 <xsl:with-param name="release" select="$thisreleasename"/>
                                                 <xsl:with-param name="releasedoc" select="$releasedoc"/>                                                 
                                              </xsl:call-template>,
                                        min : 0
                                    },
                                    tooltip : {
                                        valueSuffix : 'Pts.'
                                    },
                                    legend : {
                                        layout : 'vertical',
                                        align : 'right',
                                        verticalAlign : 'middle',
                                        borderWidth : 0
                                    },
                                    series : [
                                            {
                                                name : 'Cumulatieve Velocity',
                                                data : [ <xsl:call-template name="listburnedvelocities">
                                                            <xsl:with-param name="releasedoc" select="$releasedoc"/>
                                                            <xsl:with-param name="thissprintfolder" select="$sprintfolder" />
                                                         </xsl:call-template> ],
                                                color: '#FF0000'
                                            },
                                            {
                                                name : 'Cumulative Commitments',
                                                data : [ <xsl:call-template name="listburnedcommitments">
                                                            <xsl:with-param name="releasedoc" select="$releasedoc"/>
                                                            <xsl:with-param name="thissprintfolder" select="$sprintfolder" />
                                                         </xsl:call-template> ],
                                                dashStyle: 'ShortDash', 
                                                color : '#104E8B'
                                            } ]
                                });
                    });
                </script>
    <script src="../style/highcharts/js/highcharts.js"></script>
    <script src="../style/highcharts/js/modules/exporting.js"></script>
    <div id="container" style="min-width: 900px; height: 500px; margin: 0 auto"></div>
    


	</xsl:template>
</xsl:stylesheet>