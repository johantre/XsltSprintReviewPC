<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="chucknorris-template" >
        <xsl:param name="team" />
        <xsl:param name="title" />
        
        <xsl:for-each select="sprintreview/team">        
            <section class="slide" align="left"><!-- Team slide. -->
                <table align="center">
                    <tr>
                        <td colspan="3" width="716" height="465" align="center" style="background-image: url('../../style/prodata/img/thank-you-2.jpg'); background-repeat: no-repeat; background-size: 100% 100%; opacity:0.1; filter:alpha(opacity=40); z-index: -1;"></td>
                    </tr>
                    <tr>
                        <td><div class="creditsteam" align="right">PRODATA MOBILITY SYSTEMS :</div></td><td><div class="creditstitle">THANK YOU</div></td><td><div class="creditsteam" align="left">[<xsl:value-of select="translate($team,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /> TEAM</div></td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <div class="credits">
                                <xsl:for-each select="member[@type='modeler']"> #<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                                <xsl:for-each select="member[@type='hands-on']"> /<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                                <xsl:for-each select="member[@type='tester']"> =<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                                <xsl:for-each select="member[@type='assisted']"> ?<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                                <xsl:for-each select="member[@type='productowner']"> %<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                                <xsl:for-each select="member[@type='scrummaster']"> !<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                            </div>
                        </td>
                    </tr>
                </table>
            </section>
        </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>