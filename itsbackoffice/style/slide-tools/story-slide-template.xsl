<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="story-header-template.xsl"/>

	<xsl:template name="storyslide">
    <xsl:param name="state" />
    <xsl:param name="id" />
    <xsl:param name="title" />
            <xsl:choose>
                <xsl:when test="@type='model-context'">
                    <h1 class="rotated"><xsl:text>MODEL</xsl:text></h1>
                </xsl:when>
                <xsl:when test="@type='story-context'">
                    <h1 class="rotated" style="margin: 200px 500px -300px -600px;"><xsl:text>CONTEXT</xsl:text></h1>
                </xsl:when>
                <xsl:when test="@type='story-demo'">
                    <h1 class="rotated"><xsl:text>DEMO</xsl:text></h1>
                </xsl:when>
                <xsl:when test="@type='story-timeline'">
                    <h1 class="rotated" style="margin: 200px 500px -350px -600px;"><xsl:text>TIMELINE</xsl:text></h1>
                </xsl:when>
                <xsl:when test="@type='story-code-q'">
                    <h1 class="rotated"><xsl:text>CODE-Q</xsl:text></h1>
                </xsl:when>
                <xsl:when test="@type='whats-next'">
                    <h1 class="rotated" style="margin: 250px 500px -300px -600px;"><xsl:text>WHATsNEXT</xsl:text></h1>
                </xsl:when>
                <xsl:when test="@type='sprint-intro'">
                    <h1 class="rotated"><xsl:text>INTRO</xsl:text></h1>
                  </xsl:when>
                  <xsl:when test="@type='sprint-goal'">
                    <h1 class="rotated"><xsl:text>GOAL</xsl:text></h1>
                </xsl:when>
                <xsl:otherwise>
                    <h1 class="rotated"><xsl:text>STORY</xsl:text></h1>
                </xsl:otherwise>
            </xsl:choose>
            <header>
                <xsl:call-template name="storyheader">
                    <xsl:with-param name="state" select="$state"/>
                    <xsl:with-param name="id" select="$id" />/>
                    <xsl:with-param name="title" select="$title"/>
                </xsl:call-template>
            </header>
            <xsl:copy-of select="./*" />
	</xsl:template>
</xsl:stylesheet>