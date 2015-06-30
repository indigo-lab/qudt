<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:qudt="http://qudt.org/schema/qudt#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
	xmlns:owl="http://www.w3.org/2002/07/owl#">
	<xsl:template match="/">
		<xsl:call-template name="table">
			<xsl:with-param name="type" select="string('http://qudt.org/schema/qudt#LengthUnit')" />
		</xsl:call-template>

		<xsl:call-template name="table">
			<xsl:with-param name="type" select="string('http://qudt.org/schema/qudt#MassUnit')" />
		</xsl:call-template>

		<xsl:call-template name="table">
			<xsl:with-param name="type" select="string('http://qudt.org/schema/qudt#AreaUnit')" />
		</xsl:call-template>

		<xsl:call-template name="table">
			<xsl:with-param name="type" select="string('http://qudt.org/schema/qudt#VolumeUnit')" />
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="table">
		<xsl:param name="type" />
		<h2>
			Class :
			<xsl:value-of select="$type" />
		</h2>
		<table class="pure-table pure-table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>QUDT</th>
					<th>abbr</th>
					<th>rel</th>
					<th>DBpedia</th>
					<th>DBpedia-ja</th>
					<th>types</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource=$type]" />
			</tbody>
		</table>


	</xsl:template>

	<xsl:template match="rdf:Description">
		<xsl:variable name="a" select="*[contains(namespace-uri(.),'skos')]" />
		<xsl:variable name="b" select="$a/@rdf:resource" />
		<xsl:variable name="c" select="//*[owl:sameAs/@rdf:resource=$b]" />
		<tr class="{local-name($a)}">
			<td>
				<b>
					<xsl:value-of select="position()" />
				</b>
			</td>
			<td>
				<a href="{@rdf:about}" target="_blank">
					<xsl:value-of select="rdfs:label" />
				</a>
			</td>
			<td>
				<code>
					<xsl:value-of select="qudt:abbreviation" />
				</code>
			</td>
			<td>
				<xsl:if test="$a">
					<a href="{namespace-uri($a)}" target="_blank">
						<xsl:value-of select="local-name($a)" />
					</a>
				</xsl:if>
				<xsl:if test="not($a)">
					<span>noMatch</span>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="$b">
					<a href="{string($b)}" target="_blank">
						<xsl:value-of select="substring-after($b,'http://dbpedia.org/resource/')" />
					</a>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="$c">
					<a href="{$c/@rdf:about}" target="_blank" title="{$c/rdfs:comment}">
						<xsl:value-of select="$c/rdfs:label" />
					</a>
				</xsl:if>
			</td>
			<td>
				<xsl:for-each select="rdf:type/@rdf:resource">
					<a class="type" href="{string(.)}">
						<xsl:value-of select="substring-after(string(.),'#')" />
					</a>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>