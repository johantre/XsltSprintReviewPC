<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="chucknorris-template" >
        <xsl:param name="team" />
        <xsl:param name="title" />
        
        <xsl:for-each select="sprintreview/team">        
            <section class="slide" align="left"><!-- Team slide. -->
                <div class="creditsteam">
                    <xsl:value-of select="translate($team,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /> TEAM :
                </div>
                <div class="creditstitle">
                    <xsl:value-of select="translate($title,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />    
                </div>
                <div class="creditsteam">
                    [<xsl:value-of select="translate($team,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /> TEAM 
                </div>
                <div class="credits">
                    <xsl:for-each select="member[@type='modeler']"> #<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                    <xsl:for-each select="member[@type='hands-on']"> /<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                    <xsl:for-each select="member[@type='tester']"> =<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                    <xsl:for-each select="member[@type='assisted']"> ?<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                    <xsl:for-each select="member[@type='productowner']"> %<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                    <xsl:for-each select="member[@type='scrummaster']"> !<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each>
                </div>
            </section>
        </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>