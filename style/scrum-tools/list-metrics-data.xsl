<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="listsprintnames" >
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="."/>
      <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
        'Spr. <xsl:value-of select="@name" /> - <xsl:value-of select="concat(substring(., 5, 2),'/',substring(., 3, 2),'/',substring(., 1, 2))"/>',
      </xsl:if>
    </xsl:for-each>
  </xsl:template>  
  
  <xsl:template name="listqualitylinesofcode">
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    <xsl:param name="projectname" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="." />
      <xsl:variable name="sprintdoc" select="document(concat('../../', $teamfolder, '/' , $fetchedfolder, '/sprint-review.xml'))" />

      <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
        <xsl:value-of select="sum($sprintdoc//metric[@project=$projectname]/@linesofcode)" />,
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="listmaxlinesofcode">
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="." />
      <xsl:variable name="sprintdoc" select="document(concat('../../', $teamfolder, '/' , $fetchedfolder, '/sprint-review.xml'))" />

      <xsl:if test="$fetchedfolder = $thissprintfolder">
        <xsl:value-of select="sum($sprintdoc//metric[not($sprintdoc//metric/@linesofcode > @linesofcode)]/@linesofcode)" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>  

  <xsl:template name="listmaxunittests">
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="." />
      <xsl:variable name="sprintdoc" select="document(concat('../../', $teamfolder, '/' , $fetchedfolder, '/sprint-review.xml'))" />

      <xsl:if test="$fetchedfolder = $thissprintfolder">
        <xsl:value-of select="sum($sprintdoc//metric[not($sprintdoc//metric/@unittests > @unittests)]/@unittests)" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="listqualityunittests">
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    <xsl:param name="projectname" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="." />
      <xsl:variable name="sprintdoc" select="document(concat('../../', $teamfolder, '/' , $fetchedfolder, '/sprint-review.xml'))" />

      <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
        <xsl:value-of select="sum($sprintdoc//metric[@project=$projectname]/@unittests)" />,
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="listqualitystepfiles">
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    <xsl:param name="projectname" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="." />
      <xsl:variable name="sprintdoc" select="document(concat('../../', $teamfolder, '/' , $fetchedfolder, '/sprint-review.xml'))" />

      <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
        <xsl:value-of select="sum($sprintdoc//metric[@project=$projectname]/@stepfiles)" />,
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="listqualitycomplexity">
    <xsl:param name="teamfolder" />
    <xsl:param name="releasedoc" />
    <xsl:param name="thissprintfolder" />
    <xsl:param name="projectname" />

    <xsl:for-each select="$releasedoc//sprints/sprint">
      <xsl:variable name="fetchedfolder" select="." />
      <xsl:variable name="sprintdoc" select="document(concat('../../', $teamfolder, '/' , $fetchedfolder, '/sprint-review.xml'))" />

      <xsl:if test="$fetchedfolder &lt;= $thissprintfolder">
        <xsl:value-of select="sum($sprintdoc//metric[@project=$projectname]/@complexity)" />,
      </xsl:if>
    </xsl:for-each>
  </xsl:template>


</xsl:stylesheet>