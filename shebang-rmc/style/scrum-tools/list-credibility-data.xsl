<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="listcredibilitysprints" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />

		<xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
		    <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                'Spr. <xsl:value-of select="@name" /> - <xsl:value-of select="concat(substring(., 5, 2),'/',substring(., 3, 2),'/',substring(., 1, 2))"/>',
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listcredibilityvelocities" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
		
		<xsl:for-each select="$releasedoc//sprints/sprint">
			<xsl:variable name="fetchedfolder" select="."/>
			<xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
            <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:value-of select="sum($sprintdoc//story[not(@state='story not-done')]/@points)" />,
			</xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listcredibilitycommitments" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
		
		<xsl:for-each select="$releasedoc//sprints/sprint">
			<xsl:variable name="fetchedfolder" select="."/>
			<xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
			<xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:value-of select="sum($sprintdoc//story[not(@state='story uncommitted')]/@points)" />,
			</xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listcredibilities" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
        
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
            <xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
            <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:value-of select="sum($sprintdoc//story[not(@state='story not-done')]/@points) div sum($sprintdoc//story[not(@state='story uncommitted')]/@points)" />,
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>