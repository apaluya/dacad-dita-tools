<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="yaml">
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicref mapgroup-d/topicgroup ')]" mode="yaml">
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicref mapgroup-d/topichead ')]" mode="yaml">
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicmeta ') 
                           and parent::*[contains(@class, ' mapgroup-d/topichead ')]]" mode="yaml">
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicmeta ') 
                           and not(ancestor::*[contains(@class, ' map/relcell ')])
                           and not(parent::*[contains(@class, ' mapgroup-d/topichead ')])]" mode="yaml">
        <xsl:text>    title: "</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' map/linktext ')]" mode="yaml"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>    description: "</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' map/shortdesc ')]" mode="yaml"/>
        <xsl:text>"&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/navtitle ')
                           and ancestor::*[contains(@class, ' mapgroup-d/>topicgroup ')] 
                           and count(ancestor::*[contains(@class, ' map/topicref ')]) = 1 ]" mode="yaml">
        <xsl:text>&#xA;-title: "</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>  url: ""&#xA;</xsl:text>
        <xsl:text>  links:&#xA;</xsl:text> 
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicref ')
                           and not(contains(@class, ' mapgroup-d/topicgroup '))
                           and not(contains(@class, ' mapgroup-d/keydef '))
                           and not(contains(@class, ' mapgroup-d/topichead '))]" mode="yaml">
        <xsl:variable name="file" select="replace(@href, '\.dita$', '')"/>
        <xsl:variable name="topic-child" select="child::*[contains(@class, ' map/topicref ')]"/>
        <xsl:text>    - url: "</xsl:text>
        <xsl:value-of select="replace($file, '^.*/', '')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:choose>
            <xsl:when test="$topic-child">
                <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]" mode="yaml"/>
                <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="yaml"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="yaml"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/linktext ')]" mode="yaml">
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/shortdesc ')]" mode="yaml">
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/keydef ')]" mode="yaml"/>
    <xsl:template match="*[contains(@class, ' map/reltable ')]" mode="yaml"/>

</xsl:stylesheet>