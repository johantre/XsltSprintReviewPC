<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="recursivesum" >
        <xsl:param name="sumtype" />
        <xsl:param name="sprints" />
        <xsl:param name="releaseid" />
        <xsl:param name="sprintdoc" />
        <xsl:param name="thissprintfolder" />
        <xsl:param name="runningtotal" />
        <xsl:param name="sprintlocation" />

        <xsl:choose>
        <xsl:when test="$sprints/sprintfolder[$sprintlocation + 1]" >
            <xsl:call-template name="sumpoints" >
                <xsl:with-param name="sumtype" select="$sumtype"/>
                <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                <xsl:with-param name="releaseid" select="$releaseid"/>
                <xsl:with-param name="runningtotal" select="$runningtotal"/>
            </xsl:call-template>
            <xsl:value-of select="','" />
            <xsl:choose>
                <xsl:when test="$thissprintfolder > $sprints/sprintfolder[$sprintlocation]" >
                    <xsl:call-template name="recursivesum">
                        <xsl:with-param name="sumtype" select="$sumtype"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="releaseid" select="$releaseid"/>
                        <xsl:with-param name="sprintdoc" select="document(concat('../../', $sprints/sprintfolder[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>
                        <xsl:with-param name="runningtotal" ><xsl:call-template name="sumpoints" >
                                                                 <xsl:with-param name="sumtype" select="$sumtype"/>
                                                                 <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                                                                 <xsl:with-param name="releaseid" select="$releaseid"/>
                                                                 <xsl:with-param name="runningtotal" select="$runningtotal"/>
                                                             </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>            
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                    <xsl:call-template name="recursivesum">                                
                        <xsl:with-param name="sumtype" select="$sumtype"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="releaseid" select="$releaseid"/>
                        <xsl:with-param name="sprintdoc" select="$sprintdoc" /> 
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>  <!-- xml-doc from: $thissprintfolder iso $sprints/sprint[$sprintlocation + 1] -->
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>          <!-- running total = fixed through coming recursions -->
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" /> <!-- continue counting, till the end -->
                    </xsl:call-template>            
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprintfolder[$sprintlocation]">
            <xsl:call-template name="sumpoints" >
                <xsl:with-param name="sumtype" select="$sumtype"/>
                <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                <xsl:with-param name="releaseid" select="$releaseid"/>
                <xsl:with-param name="runningtotal" select="$runningtotal"/>
            </xsl:call-template>
            <xsl:value-of select="','" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- sum of velocity points or commitment points? -->
    <xsl:template name="sumpoints" >
        <xsl:param name="sumtype" />
        <xsl:param name="sprintdoc" />
        <xsl:param name="releaseid" />
        <xsl:param name="runningtotal" />
        <xsl:choose>
            <xsl:when test="$sprintdoc//story[@relid=$releaseid]"> <!-- count only those stories marked w the running releaseid -->
		        <xsl:choose>
		            <xsl:when test="contains($sumtype,'velocity')">
                        <xsl:value-of select="$runningtotal - sum($sprintdoc//story[@state='story done'][@relid=$releaseid]/@points) - sum($sprintdoc//story[@state='story uncommitted'][@relid=$releaseid]/@points)" />
		            </xsl:when>
					<xsl:otherwise>
					    <xsl:value-of select="$runningtotal - sum($sprintdoc//story[not(@state='story uncommitted')][@relid=$releaseid]/@points)" />
					</xsl:otherwise>
		        </xsl:choose>
            </xsl:when>
            <xsl:otherwise><!-- sum of all stories that are NOT marked w 'relid="#"' -->
                <xsl:choose>
                    <xsl:when test="contains($sumtype,'velocity')"><!-- formula sum of points WITHIN THAT SPRINT(document) to determine the BURNED velocity: [running Total - recursion(sum(done) - sum(uncommitted)) ] -->
                        <xsl:value-of select="$runningtotal - sum($sprintdoc//story[@state='story done'][not(@relid)]/@points) - sum($sprintdoc//story[@state='story uncommitted'][not(@relid)]/@points)" />
                    </xsl:when>
                    <xsl:otherwise><!-- formula sum of points WITHIN THAT SPRINT(document) to determine the BURNED commitment: [running Total - recursion(sum(all points, except uncommitted)) ]-->
                        <xsl:value-of select="$runningtotal - sum($sprintdoc//story[not(@relid)]/@points) + sum($sprintdoc//story[@state='story uncommitted'][not(@relid)]/@points)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>