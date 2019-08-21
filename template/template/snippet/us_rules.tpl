{% macro main(rule) %}
# Youtube Music is only avaliable to US citizens
USER-AGENT,YouTubeMusic*,{{ rule }}
USER-AGENT,com.google.ios.youtubemusic*,{{ rule }}
DOMAIN-SUFFIX,music.youtube.com,{{ rule }}

# Luminary
DOMAIN-SUFFIX,luminarypodcasts.com,{{ rule }}
{% endmacro %}
