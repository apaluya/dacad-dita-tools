<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <!-- <MAP> -->
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/map ')]/@title"/>
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="toc"/>    
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="chapterBody"/>

    <!-- <TITLE> -->
    <xsl:template match="*[contains(@class, ' topic/title ') and parent::*[contains(@class, ' map/map ')]]" mode="yaml-toc"/>
    <xsl:template match="*[contains(@class, ' topic/title ') and parent::*[contains(@class, ' map/map ')]]"/>
    
    <!-- <TOPICGROUP> -->
    <xsl:template match="*[contains(@class, ' map/topicref mapgroup-d/topicgroup ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <!-- <TOPICHEAD> -->
    <xsl:template match="*[contains(@class, ' map/topicref mapgroup-d/topichead ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <!-- <TOPICMETA> -->
    <xsl:template match="*[contains(@class, ' map/topicmeta ') 
                           and parent::*[contains(@class, ' mapgroup-d/topichead ')]]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicmeta ') 
                           and not(ancestor::*[contains(@class, ' map/relcell ')])
                           and not(parent::*[contains(@class, ' mapgroup-d/topichead ')])]" mode="yaml-toc">
        <xsl:text>    title: "</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' map/linktext ')]" mode="yaml-toc"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>    description: "</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' map/shortdesc ')]" mode="yaml-toc"/>
        <xsl:text>"&#xA;</xsl:text>
    </xsl:template>
    
    <!-- <NAVTITLE> -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')
                           and parent::*[contains(@class, ' map/topicmeta ')] 
                           and count(ancestor::*[contains(@class, ' map/topichead ')]) = 1 ]" mode="yaml-toc">
        <xsl:text>&#xA;- title: "</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>  url: ""&#xA;</xsl:text>
        <xsl:text>  links:&#xA;</xsl:text> 
    </xsl:template>
    
    <!-- <TOPICREF> -->
    <xsl:template match="*[contains(@class, ' map/topicref ')
                           and not(contains(@class, ' mapgroup-d/topicgroup '))
                           and not(contains(@class, ' mapgroup-d/keydef '))
                           and not(contains(@class, ' mapgroup-d/topichead '))]" mode="yaml-toc">
        <xsl:variable name="file" select="replace(@href, '\.dita$', '')"/>
        <xsl:variable name="topic-child" select="child::*[contains(@class, ' map/topicref ')]"/>
        <xsl:text>    - url: "</xsl:text>
        <xsl:value-of select="replace($file, '^.*/', '')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:choose>
            <xsl:when test="$topic-child">
                <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]" mode="yaml-toc"/>
                <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="yaml-toc"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="yaml-toc"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- <LINKTEXT> -->
    <xsl:template match="*[contains(@class, ' map/linktext ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <!-- <SHORTDESC> -->
    <xsl:template match="*[contains(@class, ' map/shortdesc ')]" mode="yaml-toc">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <!-- <KEYDEF> -->
    <xsl:template match="*[contains(@class, ' map/keydef ')]" mode="yaml-toc"/>
    
    <!-- <RELTABLE> -->
    <xsl:template match="*[contains(@class, ' map/reltable ')]" mode="yaml-toc"/>

</xsl:stylesheet>