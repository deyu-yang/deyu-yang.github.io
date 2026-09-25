---
layout: page
title: photography
permalink: /photography/
description: Moments I've captured along the way. Click a photo to view it full size.
nav: true
nav_order: 1
images:
  spotlight: true
_styles: >
  .spl-description { white-space: pre-line; }
---

<!-- Photos are listed in _data/photography.yml -->
<div class="row spotlight-group">
  {% for photo in site.data.photography %}
    {% assign path = 'assets/img/photography/' | append: photo.file %}
    {% assign year = photo.date | date: '%Y' %}
    {% capture lightbox_title %}{% if photo.title %}{{ photo.title }} · {% endif %}{{ year }}{% endcapture %}
    {% capture settings %}{{ photo.camera }} · {{ photo.lens }} · {{ photo.focal_length }} · {{ photo.aperture }} · {{ photo.shutter }} · ISO {{ photo.iso }}{% endcapture %}
    {% comment %} Spotlight shows the description as plain text; line breaks come from white-space: pre-line above. {% endcomment %}
    {% capture lightbox_description %}{{ settings }}{% if photo.memory_zh %}
{{ photo.memory_zh }}{% endif %}{% if photo.memory_en %}
{{ photo.memory_en }}{% endif %}{% endcapture %}
    <div class="col-6 col-md-4 mb-4">
      <a
        class="spotlight"
        href="{{ path | relative_url }}"
        data-title="{{ lightbox_title | strip | escape }}"
        data-description="{{ lightbox_description | escape }}"
      >
        {% include figure.liquid
          loading="lazy"
          path=path
          alt=photo.alt
          class="img-fluid rounded z-depth-1"
          sizes="(min-width: 768px) 300px, 48vw"
        %}
        {% if photo.memory_zh or photo.memory_en %}
          <span class="sr-only">
            {% if photo.memory_zh %}<span lang="zh-CN">{{ photo.memory_zh }}</span>{% endif %}
            {% if photo.memory_en %}<span lang="en">{{ photo.memory_en }}</span>{% endif %}
          </span>
        {% endif %}
      </a>
    </div>
  {% endfor %}
</div>

<p class="text-muted small text-center">
  All photos &copy; Deyu Yang. All rights reserved. Please do not use them without permission.
</p>
