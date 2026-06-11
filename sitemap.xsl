<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================
     sitemap.xsl — Backbone Tutorials
     Renders sitemap.xml as a clean, branded HTML page in the browser.
     DEPLOY TO: /sitemap.xsl  (referenced by /sitemap.xml via xml-stylesheet)
     ============================================================ -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:s="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
  exclude-result-prefixes="s image">

  <xsl:output method="html" encoding="UTF-8" indent="yes"
    doctype-system="about:legacy-compat"/>

  <xsl:template match="/">
    <html lang="en">
    <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <meta name="robots" content="noindex, follow"/>
      <title>XML Sitemap · Backbone Tutorials</title>
      <style>
        :root{--ink:#111827;--blue:#2563eb;--mut:#6b7280;--line:#e5e7eb;--bg:#f4f6f9}
        *{box-sizing:border-box}
        body{margin:0;background:var(--bg);color:#1f2937;
          font-family:Inter,system-ui,-apple-system,"Segoe UI",Roboto,sans-serif;line-height:1.6}
        a{color:var(--blue);text-decoration:none}
        a:hover{text-decoration:underline}
        .top{background:var(--ink);background-image:radial-gradient(120% 140% at 85% -20%,#1b2738,#0d121d);
          color:#fff;padding:34px 22px 30px}
        .top .wrap{max-width:1060px;margin:0 auto}
        .brand{display:flex;align-items:center;gap:10px;font-weight:700;font-size:15px;color:#cbd5e1}
        .brand .mono{font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace;color:#06b6d4}
        h1{margin:14px 0 6px;font-size:26px;color:#fff}
        .top p{margin:0;color:#9ca3af;font-size:14.5px;max-width:680px}
        .stats{display:flex;flex-wrap:wrap;gap:10px;margin-top:18px}
        .pill{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.12);
          border-radius:999px;padding:7px 15px;font-size:13px;color:#e2e8f0}
        .pill b{color:#fff}
        .wrap{max-width:1060px;margin:0 auto;padding:22px}
        .tools{display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap;margin-bottom:12px}
        .search{flex:1;min-width:220px;max-width:420px;padding:10px 14px;border:1px solid var(--line);
          border-radius:10px;font-size:14px;background:#fff}
        .count-note{font-size:13px;color:var(--mut)}
        .panel{background:#fff;border:1px solid var(--line);border-radius:12px;overflow:hidden;
          box-shadow:0 2px 12px rgba(0,0,0,.04)}
        table{border-collapse:collapse;width:100%;font-size:14px}
        th,td{padding:11px 14px;text-align:left;border-bottom:1px solid var(--line);vertical-align:middle}
        th{background:#f9fafb;font-weight:700;color:#374151;font-size:12.5px;text-transform:uppercase;letter-spacing:.04em;
          position:sticky;top:0}
        tr:last-child td{border-bottom:none}
        tbody tr:hover{background:#f8fafc}
        td.url{word-break:break-all}
        td.url .path{font-weight:600}
        .num{color:var(--mut);font-variant-numeric:tabular-nums;width:46px;text-align:right}
        .prio{font-variant-numeric:tabular-nums;font-weight:700}
        .bar{display:inline-block;height:6px;border-radius:4px;background:var(--blue);vertical-align:middle;margin-left:8px}
        .badge{display:inline-block;font-size:12px;padding:2px 9px;border-radius:999px;background:#eef2ff;color:#3730a3;font-weight:600}
        .imgs{color:var(--mut);font-variant-numeric:tabular-nums}
        .when{color:var(--mut);font-variant-numeric:tabular-nums;white-space:nowrap}
        footer{max-width:1060px;margin:0 auto;padding:8px 22px 36px;color:var(--mut);font-size:13px}
        @media(max-width:640px){.hide-sm{display:none}h1{font-size:22px}}
      </style>
    </head>
    <body>
      <div class="top">
        <div class="wrap">
          <div class="brand"><span class="mono">&#60;/&#62;</span> Backbone Tutorials</div>
          <h1>XML Sitemap</h1>
          <p>This page lists every URL on backbonetutorials.com that we submit to search engines.
             It is generated for crawlers; the styling here is just to make it readable for humans.</p>
          <div class="stats">
            <span class="pill"><b><xsl:value-of select="count(s:urlset/s:url)"/></b> URLs</span>
            <span class="pill"><b><xsl:value-of select="count(s:urlset/s:url/image:image)"/></b> images</span>
            <span class="pill">Namespace <b>sitemaps.org 0.9</b></span>
          </div>
        </div>
      </div>

      <div class="wrap">
        <div class="tools">
          <input class="search" id="q" type="search" placeholder="Filter URLs… (e.g. modern-frameworks)" onkeyup="ftr()"/>
          <span class="count-note" id="cn"></span>
        </div>
        <div class="panel">
          <table>
            <thead>
              <tr>
                <th class="num">#</th>
                <th>URL</th>
                <th class="hide-sm">Priority</th>
                <th class="hide-sm">Frequency</th>
                <th class="hide-sm">Images</th>
                <th>Last modified</th>
              </tr>
            </thead>
            <tbody id="rows">
              <xsl:for-each select="s:urlset/s:url">
                <tr>
                  <td class="num"><xsl:value-of select="position()"/></td>
                  <td class="url">
                    <xsl:variable name="u" select="s:loc"/>
                    <a href="{$u}">
                      <span class="path">
                        <xsl:value-of select="substring-after($u,'backbonetutorials.com')"/>
                      </span>
                    </a>
                  </td>
                  <td class="hide-sm prio">
                    <xsl:value-of select="s:priority"/>
                    <span class="bar">
                      <xsl:attribute name="style">width:<xsl:value-of select="number(s:priority)*46"/>px</xsl:attribute>
                    </span>
                  </td>
                  <td class="hide-sm"><span class="badge"><xsl:value-of select="s:changefreq"/></span></td>
                  <td class="hide-sm imgs"><xsl:value-of select="count(image:image)"/></td>
                  <td class="when"><xsl:value-of select="s:lastmod"/></td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </div>
      </div>

      <footer>
        Generated for <a href="https://backbonetutorials.com/">backbonetutorials.com</a> ·
        Submit this file's <code>.xml</code> version in Google Search Console.
      </footer>

      <script>
        function ftr(){
          var q=document.getElementById('q').value.toLowerCase();
          var rows=document.querySelectorAll('#rows tr');var n=0;
          rows.forEach(function(r){
            var t=r.querySelector('.url').textContent.toLowerCase();
            var show=t.indexOf(q)>-1;r.style.display=show?'':'none';if(show)n++;
          });
          document.getElementById('cn').textContent=n+' shown';
        }
        document.getElementById('cn').textContent=document.querySelectorAll('#rows tr').length+' URLs';
      </script>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
