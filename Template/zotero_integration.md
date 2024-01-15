---
tags: []
---
# {{title}}
[toc]
## 1.Abstract&Info
### 1.1 Abstract
{{abstractNote}}

### 1.2 Info
Authors: {{authors}}
DOI: {{DOI}}
Publication: {{publicationTitle}}
PDF: {{pdfLink}}
Zotero: {{pdfZoteroLink}}
Data: {{date|format("YYYY-MM-DD")}}

## 2. Annotation
{% persist "annotations" %}

{% set newAnnotations = annotations | filterby("date", "dateafter", lastImportDate) %}
{% if newAnnotations.length > 0 %}
### Imported: {{importDate | format("YYYY-MM-DD h:mm a")}}

{% for each in newAnnotations %}
{% if each.colorCategory == 'Yellow' %}
原文：[{{each.annotatedText}}](zotero://open-pdf/library/items/{{each.attachment.itemKey}}?page={{each.page}}&annotation={{each.id}})
标注：{{each.comment}}
{% endif %}
{% endfor%}

{% endif %}
{% endpersist %}
