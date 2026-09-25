---
layout: page
title: photography
permalink: /photography/
description: Moments I've captured along the way. Click a photo to view it full size.
nav: true
nav_order: 1
images:
  spotlight: true
---

<!-- Photos are listed in _data/photography.yml -->
<div class="row spotlight-group">
  {% for photo in site.data.photography %}
    {% assign path = 'assets/img/photography/' | append: photo.file %}
    {% assign year = photo.date | date: '%Y' %}
    {% capture lightbox_title %}{% if photo.title %}{{ photo.title }} · {% endif %}{{ year }}{% endcapture %}
    <div class="col-6 col-md-4 mb-4">
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
          sizes="(min-width: 768px) 300px, 48vw"
        %}
      </a>
    </div>
  {% endfor %}
</div>

<p class="text-muted small text-center">
  All photos &copy; Deyu Yang. All rights reserved. Please do not use them without permission.
</p>
