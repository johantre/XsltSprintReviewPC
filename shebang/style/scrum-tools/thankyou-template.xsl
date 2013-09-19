<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="thankyou-template" >
    
        <xsl:for-each select="sprintreview/team">
            <section class="slide" align="left"><!-- Team slide. -->
                <div class="credits">
                            <xsl:for-each select="member">#<xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:for-each><br/>%<xsl:value-of select="translate(productowner,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />!<xsl:value-of select="translate(scrummaster,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
                </div>
            </section>
        </xsl:for-each>


	</xsl:template>
</xsl:stylesheet>