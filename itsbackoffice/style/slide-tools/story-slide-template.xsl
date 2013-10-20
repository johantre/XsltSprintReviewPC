<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="story-header-template.xsl"/>

	<xsl:template name="storyslide">
    <xsl:param name="state" />
    <xsl:param name="mksid" />
    <xsl:param name="title" />
            <xsl:choose>
                <xsl:when test="@type='model-context'">
                    <h1 class="rotated">MODEL</h1>
                </xsl:when>
                <xsl:when test="@type='story-context'">
                    <h1 class="rotated" style="margin: 200px 500px -300px -600px;">CONTEXT</h1>
                </xsl:when>
                <xsl:when test="@type='story-demo'">
                    <h1 class="rotated">DEMO</h1>
                </xsl:when>
                <xsl:when test="@type='story-timeline'">
                    <h1 class="rotated" style="margin: 200px 500px -350px -600px;">TIMELINE</h1>
                </xsl:when>
                <xsl:when test="@type='story-code-q'">
                    <h1 class="rotated">CODE-Q</h1>
                </xsl:when>
                <xsl:when test="@type='whats-next'">
                    <h1 class="rotated" style="margin: 250px 500px -300px -600px;">WHATsNEXT</h1>
                </xsl:when>
                <xsl:when test="@type='sprint-intro'">
                    <h1 class="rotated">INTRO</h1>
                </xsl:when>
                <xsl:when test="@type='sprint-goal'">
                    <h1 class="rotated">GOAL</h1>
                </xsl:when>
                <xsl:otherwise>
                    <h1 class="rotated">STORY</h1>
                </xsl:otherwise>
            </xsl:choose>
            <header>
                <xsl:call-template name="storyheader">
                    <xsl:with-param name="state" select="$state"/>
                    <xsl:with-param name="mksid" select="$mksid" />/>
                    <xsl:with-param name="title" select="$title"/>
                </xsl:call-template>
            </header>
            <xsl:copy-of select="./*" />
	</xsl:template>
</xsl:stylesheet>