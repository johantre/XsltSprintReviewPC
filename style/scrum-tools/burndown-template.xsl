<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="list-burndown-data.xsl"/>

	<xsl:template name="burndown-template" >
    <xsl:param name="teamname" />
    <xsl:param name="teamfolder" />
    <xsl:param name="sprintfolder" />
    <xsl:param name="releaseid" />
    <xsl:param name="releasename" />
    <xsl:param name="releasecount" />
    <xsl:variable name="releasedoc" select="document(concat('../../', $teamfolder, '/style' ,'/release-burndown.xml'))"/>
    <xsl:variable name="teamfolderescaped" select="translate($teamfolder, '-', '')" />    

    <script type="text/javascript">
        $(function() {
                  var chart<xsl:value-of select="$teamfolderescaped" /><xsl:value-of select="$releasecount" />options = {
                        chart: {
                          renderTo: 'container<xsl:value-of select="$teamfolderescaped" /><xsl:value-of select="$releasecount" />',
                          zoomType: 'xy'
                        },
                        title : {
                            text : 'Release Burn down *<xsl:value-of select="$releasename" />*',
                        },
                        xAxis : {
                            categories : [ <xsl:call-template name="listsprints">
                                              <xsl:with-param name="releaseid" select="$releaseid"/>
                                              <xsl:with-param name="releasedoc" select="$releasedoc"/>
                                           </xsl:call-template> ]
                        },
                        yAxis : {
                            max : <xsl:call-template name="totalpoints">
                                     <xsl:with-param name="releaseid" select="$releaseid"/>
                                     <xsl:with-param name="releasedoc" select="$releasedoc"/>                                                 
                                  </xsl:call-template>
                        },
                        series : [
                                {
                                    name : 'Cumulative Velocity',
                                    data : [ <xsl:call-template name="listburnedsumsforrelease">
                                                <xsl:with-param name="sumtype" select="'velocity'"/>
                                                <xsl:with-param name="releaseid" select="$releaseid"/>
                                                <xsl:with-param name="releasedoc" select="$releasedoc"/>
                                                <xsl:with-param name="teamfolder" select="$teamfolder"/>
                                                <xsl:with-param name="thissprintfolder" select="$sprintfolder" />
                                             </xsl:call-template> ],
                                    color: '#FF0000'
                                },
                                {
                                    name : 'Cumulative Commitments',
                                    data : [ <xsl:call-template name="listburnedsumsforrelease">
                                                <xsl:with-param name="sumtype" select="'commitment'"/>
                                                <xsl:with-param name="releaseid" select="$releaseid"/>
                                                <xsl:with-param name="releasedoc" select="$releasedoc"/>
                                                <xsl:with-param name="teamfolder" select="$teamfolder"/>
                                                <xsl:with-param name="thissprintfolder" select="$sprintfolder" />
                                             </xsl:call-template> ],
                                    dashStyle: 'ShortDash', 
                                    color : '#104E8B'
                                } ],
                         exporting: {
                            sourceWidth: 900,
                            sourceHeight: 500,
                        }
                    };
                    var chart<xsl:value-of select="$teamfolderescaped" /><xsl:value-of select="$releasecount" /> = new Highcharts.Chart(jQuery.extend(true, {}, chart<xsl:value-of select="$teamfolderescaped" /><xsl:value-of select="$releasecount" />options));
        });
    </script>
    <div id="container{$teamfolderescaped}{$releasecount}" style="min-width: 900px; height: 500px; margin: 0 auto"></div>
    


	</xsl:template>
</xsl:stylesheet>