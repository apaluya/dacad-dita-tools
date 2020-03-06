<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- OVERRIDES -->
    <xsl:include href="topic.xsl"/>
    <xsl:include href="related-links.xsl"/>
    <xsl:include href="map.xsl"/>


    <!-- SUPPRESS THE DEFAULT APPLYING OF @ID AND @CLASS VALS ON OUTPUT MD -->
    <xsl:template name="ast-attributes"/>

    <!-- SUPPRESS THE DEFAULT TEXT OUTPUT FOR YAML MODE -->
    <xsl:template match="text()" mode="yaml"/>
    <xsl:template match="text()" mode="yaml-toc"/>

    <xsl:output method="text"
        encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:apply-templates mode="yaml-toc"/>
        <xsl:variable name="ast" as="node()">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:variable name="ast-flat" as="node()">
            <xsl:apply-templates select="$ast" mode="flatten"/>
        </xsl:variable>
        <xsl:variable name="ast-clean" as="node()">
            <xsl:apply-templates select="$ast-flat" mode="ast-clean"/>
        </xsl:variable>
        <xsl:apply-templates mode="yaml"/>
        <xsl:apply-templates select="$ast-clean" mode="ast"/>
    </xsl:template>
    
    
</xsl:stylesheet>