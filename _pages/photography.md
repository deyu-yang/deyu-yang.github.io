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
  .photo-memory summary { cursor: pointer; color: var(--global-text-color-light); }
  .photo-memory p { margin: 0.5rem 0 0; }
  #spotlight .spl-footer, #spotlight .spl-title, #spotlight .spl-description {
    color: #fff; text-shadow: 0 1px 2px rgba(0, 0, 0, 0.6); }
---

<!-- Photos are listed in _data/photography.yml -->
<div class="row spotlight-group">
  {% for photo in site.data.photography %}
    {% assign path = 'assets/img/photography/' | append: photo.file %}
    {% assign year = photo.date | date: '%Y' %}
    {% capture lightbox_title %}{% if photo.title_zh %}{{ photo.title_zh }}{% if photo.title_en %} / {% endif %}{% endif %}{% if photo.title_en %}{{ photo.title_en }}{% endif %}{% if photo.title_zh or photo.title_en %} · {% endif %}{{ year }}{% endcapture %}
    <div class="col-12 col-sm-6 col-md-4 mb-4">
      <a
        class="spotlight"
        href="{{ path | relative_url }}"
        data-title="{{ lightbox_title | strip | escape }}"
        data-description="{{ photo.camera }} · {{ photo.lens }} · {{ photo.focal_length }} · {{ photo.aperture }} · {{ photo.shutter }} · ISO {{ photo.iso }}"
      >
        {% include figure.liquid
          loading="lazy"
          path=path
          alt=photo.alt
          class="img-fluid rounded z-depth-1"
          sizes="(min-width: 768px) 300px, (min-width: 576px) 48vw, 95vw"
        %}
      </a>
      {% if photo.memory_zh or photo.memory_en %}
        <details class="photo-memory small mt-2">
          <summary><span lang="zh-CN">回忆</span> · Memory</summary>
          {% if photo.memory_zh %}<p lang="zh-CN">{{ photo.memory_zh }}</p>{% endif %}
          {% if photo.memory_en %}<p>{{ photo.memory_en }}</p>{% endif %}
        </details>
      {% endif %}
    </div>
  {% endfor %}
</div>

<p class="text-muted small text-center">
  All photos &copy; Deyu Yang. All rights reserved. Please do not use them without permission.
</p>
