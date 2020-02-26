<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:include href="dita2dacad-npmImpl.xsl"/>
    
    <dita:extension id="dita.xsl.dacad-npm"
                    behavior="org.dita.dost.platform.ImportXSLAction"
                    xmlns:dita="http://dita-ot.sourceforge.net"/>
    <xsl:output method="text"
                encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:call-template name=""/>
    </xsl:template>
    
</xsl:stylesheet>