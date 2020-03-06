<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:impl="urn:x-xspec:compile:xslt:impl"
                xmlns:test="http://www.jenitennison.com/xslt/unit-test"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                version="2.0"
                exclude-result-prefixes="impl">
   <xsl:import href="file:/Users/Paul/dacad/dacad-dita-tools/com.docsascodeasdocs.markdown.dacad-npm/xsl/map.xsl"/>
   <xsl:import href="file:/usr/local/xspec/src/compiler/generate-tests-utils.xsl"/>
   <xsl:include href="file:/usr/local/xspec/src/common/xspec-utils.xsl"/>
   <xsl:output name="x:report" method="xml" indent="yes"/>
   <xsl:variable name="x:xspec-uri" as="xs:anyURI">file:/Users/Paul/dacad/dacad-dita-tools/com.docsascodeasdocs.markdown.dacad-npm/test/test_map-yaml-toc.xspec</xsl:variable>
   <xsl:template name="x:main">
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('xsl:product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('xsl:product-version')"/>
      </xsl:message>
      <xsl:result-document format="x:report">
         <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="file:/usr/local/xspec/src/reporter/format-xspec-report.xsl"</xsl:processing-instruction>
         <x:report stylesheet="file:/Users/Paul/dacad/dacad-dita-tools/com.docsascodeasdocs.markdown.dacad-npm/xsl/map.xsl"
                   date="{current-dateTime()}"
                   xspec="file:/Users/Paul/dacad/dacad-dita-tools/com.docsascodeasdocs.markdown.dacad-npm/test/test_map-yaml-toc.xspec">
            <xsl:call-template name="x:scenario1"/>
         </x:report>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="x:scenario1">
      <xsl:message>When processing the top-level title of a map</xsl:message>
      <x:scenario id="scenario1"
                  xspec="file:/Users/Paul/dacad/dacad-dita-tools/com.docsascodeasdocs.markdown.dacad-npm/test/test_map-yaml-toc.xspec">
         <x:label>When processing the top-level title of a map</x:label>
         <x:context>
            <xsl:attribute name="mode">yaml-toc</xsl:attribute>
            <map>
               <xsl:attribute name="class" select="'', ''" separator="- map/map "/>
               <title>
                  <xsl:attribute name="class" select="'', ''" separator="- topic/title "/>
                  <xsl:text>Don't show this title!</xsl:text>
               </title>
            </map>
         </x:context>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="impl:context-d7e0-doc" as="document-node()">
               <xsl:document>
                  <map>
                     <xsl:attribute name="class" select="'', ''" separator="- map/map "/>
                     <title>
                        <xsl:attribute name="class" select="'', ''" separator="- topic/title "/>
                        <xsl:text>Don't show this title!</xsl:text>
                     </title>
                  </map>
               </xsl:document>
            </xsl:variable>
            <xsl:variable name="impl:context-d7e0" as="item()*">
               <xsl:for-each select="$impl:context-d7e0-doc">
                  <xsl:sequence select="node()"/>
               </xsl:for-each>
            </xsl:variable>
            <xsl:apply-templates select="$impl:context-d7e0" mode="yaml-toc"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:scenario1-expect1">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:scenario1-expect1">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>do nothing.</xsl:message>
      <xsl:variable name="impl:expect-d6e7" select="()"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expect-d6e7, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test id="scenario1-expect1" successful="{$impl:successful}">
         <x:label>do nothing.</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expect-d6e7"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
</xsl:stylesheet>
