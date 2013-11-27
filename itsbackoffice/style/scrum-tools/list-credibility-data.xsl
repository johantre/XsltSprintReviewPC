<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="recursive-avg.xsl"/>

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

    <xsl:template name="listpredictibilities" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
        
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
            <xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
            <xsl:variable name="velocity" select="sum($sprintdoc//story[not(@state='story not-done')]/@points)" />
            <xsl:variable name="commitment" select="sum($sprintdoc//story[not(@state='story uncommitted')]/@points)" />
            
            <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:choose>
                    <xsl:when test="(contains($velocity,'NaN')) or (contains($velocity,'NaN')) or ($velocity = 0) or (contains($commitment,'NaN')) or (contains($commitment,'NaN')) or ($commitment = 0)">
                        <xsl:value-of select="0" />,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$velocity div $commitment" />,
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="listcredibilities" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />        
        <xsl:variable name="sprintdoc" select="document(concat('../../', $releasedoc//releasedata/sprints/sprint[1], '/sprint-review.xml'))" />

            <xsl:call-template name="recursiveavg">
                <xsl:with-param name="sprints" select="$releasedoc//releasedata/sprints" />
                <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                <xsl:with-param name="runningPredTotal" select="0" />
                <xsl:with-param name="runningcount" select="1"/>
                <xsl:with-param name="sprintlocation" select="1" />
            </xsl:call-template>
    </xsl:template>

    <xsl:template name="listhandsoncapacity" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
        
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
            <xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
            <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:value-of select="sum($sprintdoc//team/member[@type='hands-on'][@type='scrummaster']/@capacity)" />,
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listtestercapacity" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
        
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
            <xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
            <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:value-of select="sum($sprintdoc//team/member[@type='tester']/@capacity)" />,
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listmodelercapacity" >
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />
        
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
            <xsl:variable name="sprintdoc" select="document(concat('../../', $fetchedfolder, '/sprint-review.xml'))" />
            <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
                <xsl:value-of select="sum($sprintdoc//team/member[@type='modeler']/@capacity)" />,
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>