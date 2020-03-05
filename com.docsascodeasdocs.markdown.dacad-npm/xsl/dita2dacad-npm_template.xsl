<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:import href="plugin:org.lwdita:xsl/ast2markdown.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/task.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/ut-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/sw-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/pr-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/ui-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/hi-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/markup-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/xml-d.xsl"/>
    <xsl:import href="plugin:org.lwdita:xsl/dita2markdownImpl.xsl"/>
    <dita:extension id="dita.xsl.markdown" 
                    behavior="org.dita.dost.platform.ImportXSLAction"
                    xmlns:dita="http://dita-ot.sourceforge.net"/>
    
    <xsl:include href="dita2dacad-npmImpl.xsl"/>
    
    <dita:extension id="dita.xsl.dacad-npm"
                    behavior="org.dita.dost.platform.ImportXSLAction"
                    xmlns:dita="http://dita-ot.sourceforge.net"/>
    
    <xsl:output method="text"
                encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="text()" mode="yaml"/>
    
    <xsl:template match="/">
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