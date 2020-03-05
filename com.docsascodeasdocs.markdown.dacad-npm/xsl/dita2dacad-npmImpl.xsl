<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- SUPPRESS THE DEFAULT APPLYING OF @ID AND @CLASS VALS ON OUTPUT MD -->
    <xsl:template name="ast-attributes"/>
    
    <!--SUPPRESS RELATED LINKS FROM OUTPUT BODY CONTENT.
        THIS DATA WILL BE REDIRECTED TO TOPIC YAML BLOCKS -->
    <xsl:template match="*[contains(@class, ' topic/related-links ')]" mode="breadcrumb"/>
    <xsl:template match="*[contains(@class, ' topic/related-links ')]" mode="prereqs"/>
    <xsl:template match="*[contains(@class, ' topic/related-links ')]" name="topic.related-links"/>
    
    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="yaml">
        <xsl:text>---&#xA;</xsl:text>
        <xsl:text>topic_type: "</xsl:text>
        <xsl:value-of select="substring-before(@xtrc, ':')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>id: "</xsl:text>
        <xsl:value-of select="substring-before(tokenize(@xtrf, '/')[last()], '.')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>lang: "</xsl:text>
        <xsl:value-of select="@xml:lang"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>title: "</xsl:text>
        <xsl:value-of select="normalize-space(child::*[contains(@class, ' topic/title ')])"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>description: "</xsl:text>
        <xsl:value-of select="normalize-space(descendant::*[contains(@class, ' topic/shortdesc ')])"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:apply-templates mode="yaml"/>
        <xsl:text>---&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/related-links ')]" mode="yaml">
        <xsl:variable name="collType" 
            select="*[contains(@class, ' topic/linkpool ')]/*[contains(@class, ' topic/linkpool ')]/@collection-type"/>
        <xsl:if test="$collType = 'family'">
            <xsl:text>landing_page: "true"&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>related_links:&#xA;</xsl:text>
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/link ')]" mode="yaml">
        <xsl:variable name="file" select="replace(@href, '\.dita$', '')"/>
        <xsl:text>  - topic_type: "</xsl:text>
        <xsl:value-of select="normalize-space(@type)"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>    href: "</xsl:text>
        <xsl:value-of select="replace($file, '^.*/', '')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>    role: "</xsl:text>
        <xsl:value-of select="normalize-space(@role)"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:apply-templates mode="yaml"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/linktext ')]" mode="yaml">
        <xsl:text>    title: "</xsl:text>
        <xsl:value-of select="normalize-space(text())"/>
        <xsl:text>"&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/desc ')]" mode="yaml">
        <xsl:text>    description: "</xsl:text>
        <xsl:value-of select="normalize-space(text())"/>
        <xsl:text>"&#xA;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>