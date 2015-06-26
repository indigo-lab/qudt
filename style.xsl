<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:qudt="http://qudt.org/schema/qudt#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
	xmlns:owl="http://www.w3.org/2002/07/owl#">
	<xsl:template match="/">
		<html>
			<head>
				<title>QUDT1.1 Unit vs DBpedia-ja</title>
				<link rel="stylesheet" type="text/css" href="style.css" />
			</head>
			<body>
				<div>
					<h1>QUDT1.1 Unit vs DBpedia-ja</h1>
					<table class="pure-table pure-table-striped">
						<thead>
							<tr>
								<th>#</th>
								<th>QUDT</th>
								<th>abbr</th>
								<th>rel</th>
								<th>DBpedia</th>
								<th>DBpedia-ja</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="/rdf:RDF/rdf:Description[rdf:type and rdfs:label]" />
						</tbody>
					</table>

					<div style="margin:2em;">
						このページは RDF/XML に XSL スタイルシートを適用することで表示されています。
						<br />
						RDF/XML は以下のリソースを集約して作成されています。
						<ul>
							<li>
								<a href="http://qudt.org/1.1/vocab/unit">QUDT 1.1 Ontology - Unit</a>
								,
								licensed under
								<a href="https://creativecommons.org/licenses/by-sa/3.0/us/">CC BY-SA 3.0 US</a>
							</li>
							<li>
								Query result from
								<a href="http://dbpedia.org/snorql">DBpedia SPARQL Endpoint</a>
								,
								licensed under
								<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC BY-SA 3.0</a>
							</li>
						</ul>
					</div>

				</div>
			</body>
		</html>
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
		</tr>
	</xsl:template>
</xsl:stylesheet>