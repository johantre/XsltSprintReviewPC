<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="mkslink">
    <xsl:param name="id" />
    <xsl:param name="state" />
    <xsl:param name="title" />
        
    <xsl:choose>
        <xsl:when test="$id and $id != ''">            
            <a target="_blank" class="{$state}" href="https://support.prodatamobility.com/tickets/browse/{$id}"><xsl:value-of select="$title" /></a>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$title" />        
        </xsl:otherwise>
    </xsl:choose>

	</xsl:template>
</xsl:stylesheet>
