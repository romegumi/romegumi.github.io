---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---

Research Interests
======

| Area | Keywords |
| --- | --- |
| **Neuroscience** | Sensory system, interaction analysis sensing, spatial perception, electrophysiology, optical imaging |
| **Behavioral science** | Escape behavior, aversive behavior, appetitive behavior |
| **Learning and memory** | Classical conditioning, operant conditioning, conditioned taste aversion |

Publications
======

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
