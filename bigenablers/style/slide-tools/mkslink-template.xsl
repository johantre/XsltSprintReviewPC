<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="mkslink">
    <xsl:param name="id" />
    <xsl:param name="state" />
    <xsl:param name="title" />
        
    <xsl:variable name="link" select="'href=&quot;http://besrvup-mks01:7001/im/issues?selection='" />

    <xsl:choose>
        <xsl:when test="$id and $id != ''">            
            <xsl:text disable-output-escaping="yes">&lt;</xsl:text> 
            <xsl:value-of select="'a target=&quot;_blank&quot; class=&quot;'" /><xsl:value-of select="$state" /><xsl:text disable-output-escaping="yes">&quot;</xsl:text>
            <xsl:text disable-output-escaping="yes"> </xsl:text><xsl:copy-of select="$link" /><xsl:value-of select="$id" /><xsl:text disable-output-escaping="yes">&quot;</xsl:text>
            <xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="$title" />
            <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$title" />        
        </xsl:otherwise>
    </xsl:choose>

	</xsl:template>
</xsl:stylesheet>
