{% macro main(default_rule, api_rule, cdn_rule, location_rule, apple_news_rule) %}
# http://www.jjinc.com.au/announcements/apple170008services
#
# Apple 直连
#
USER-AGENT,*com.apple.mobileme.fmip1,DIRECT
USER-AGENT,*WeatherFoundation*,DIRECT
# Maps
USER-AGENT,%E5%9C%B0%E5%9B%BE*,{{ location_rule }}
# Settings
USER-AGENT,%E8%AE%BE%E7%BD%AE*,DIRECT
USER-AGENT,com.apple.geod*,{{ location_rule }}
USER-AGENT,com.apple.Maps,{{ location_rule }}
USER-AGENT,FindMyFriends*,DIRECT
USER-AGENT,FindMyiPhone*,DIRECT
USER-AGENT,FMDClient*,DIRECT
USER-AGENT,FMFD*,DIRECT
USER-AGENT,fmflocatord*,DIRECT
USER-AGENT,geod*,{{ location_rule }}
USER-AGENT,locationd*,{{ location_rule }}
USER-AGENT,Maps*,{{ location_rule }}

#
# 一些 com.apple.appstored* 会连接的 API（优先级高）
#
DOMAIN,apps.apple.com,{{ api_rule }}
DOMAIN,xp.apple.com,{{ api_rule }}
DOMAIN,bag.itunes.apple.com,{{ api_rule }}
DOMAIN,api-edge.apps.apple.com,{{ api_rule }}
DOMAIN,api.apps.apple.com,{{ api_rule }}
DOMAIN,play.itunes.apple.com,{{ api_rule }}
DOMAIN,se.itunes.apple.com,{{ api_rule }}
DOMAIN,se-edge.itunes.apple.com,{{ api_rule }}
DOMAIN,su.itunes.apple.com,{{ api_rule }}
DOMAIN,upp.itunes.apple.com,{{ api_rule }}
DOMAIN,beta.music.apple.com,{{ api_rule }}
DOMAIN-KEYWORD,buy.itunes.apple.com,{{ api_rule }}

#
# Apple Global CDN
#
# iOS App Store
DOMAIN,iosapps.itunes.apple.com,{{ cdn_rule }}
# Mac App Store
DOMAIN,osxapps.itunes.apple.com,{{ cdn_rule }}
# Update
DOMAIN,supportdownload.apple.com,{{ cdn_rule }}
# Update
DOMAIN,appldnld.apple.com,{{ cdn_rule }}
# Update
DOMAIN,swcdn.apple.com,{{ cdn_rule }}
DOMAIN,apptrailers.itunes.apple.com,{{ cdn_rule }}
DOMAIN,updates-http.cdn-apple.com,{{ cdn_rule }}
# App Store & iTunes Images
DOMAIN-SUFFIX,mzstatic.com,{{ cdn_rule }}
# Mac App Store
PROCESS-NAME,storedownloadd,{{ cdn_rule }}
# iOS App Store
USER-AGENT,com.apple.appstored*,{{ cdn_rule }}

#
# Apple Non-China CDN
#
# Trailer
DOMAIN-SUFFIX,hls.itunes.apple.com,{{ default_rule }}
# Movie Stream
DOMAIN-SUFFIX,hls-amt.itunes.apple.com,{{ default_rule }}
# iTunes Music Stream
DOMAIN-SUFFIX,audio-ssl.itunes.apple.com,{{ default_rule }}
DOMAIN-SUFFIX,cdn-apple.com,{{ default_rule }}
DOMAIN,cdn.apple-cloudkit.com,{{ default_rule }}
# Developer
DOMAIN,devimages-cdn.apple.com,{{ default_rule }}
DOMAIN,devstreaming-cdn.apple.com,{{ default_rule }}
DOMAIN,js-cdn.music.apple.com,{{ default_rule }}
DOMAIN,docs-assets.developer.apple.com,{{ default_rule }}

#
# Apple News
#
USER-AGENT,AppleNews*,{{apple_news_rule}}
DOMAIN-SUFFIX,apple.news,{{apple_news_rule}}
DOMAIN,news-events.apple.com,{{apple_news_rule}}
DOMAIN,news-edge.apple.com,{{apple_news_rule}}
DOMAIN,apple.comscoreresearch.com,{{apple_news_rule}}

#
# Apple 其他直连
#
DOMAIN,api.smoot.apple.com,DIRECT
DOMAIN,captive.apple.com,DIRECT
DOMAIN,configuration.apple.com,DIRECT
DOMAIN,guzzoni.apple.com,DIRECT
# Apple Pay
DOMAIN,smp-device-content.apple.com,DIRECT
# Apple Music Streaming
DOMAIN,aod.itunes.apple.com,DIRECT
DOMAIN,api.smoot.apple.cn,DIRECT
# locationd
DOMAIN,gs-loc.apple.com,{{ location_rule }}
# Apple Music Streaming
DOMAIN,mvod.itunes.apple.com,DIRECT
# Apple Music Streaming
DOMAIN,streamingaudio.itunes.apple.com,DIRECT
# Reserve
DOMAIN,reserve-prime.apple.com,DIRECT
DOMAIN-SUFFIX,ess.apple.com,DIRECT
DOMAIN-SUFFIX,push-apple.com.akadns.net,DIRECT
DOMAIN-SUFFIX,push.apple.com,DIRECT
# Apple Music
DOMAIN-SUFFIX,music.apple.com,DIRECT
# GeoServices.framework
DOMAIN-SUFFIX,ls.apple.com,{{ location_rule }}
# Asset Cache Locator Service
DOMAIN-SUFFIX,lcdn-locator.apple.com,DIRECT
# Caching Server Registration
DOMAIN-SUFFIX,lcdn-registration.apple.com,DIRECT
# Apple Pay
DOMAIN-KEYWORD,smp-device,DIRECT
# Apple Pay
USER-AGENT,passd*,DIRECT
# Apple Pay
USER-AGENT,Wallet*,DIRECT

#
# Apple 其他自选
#
DOMAIN-SUFFIX,aaplimg.com,{{ api_rule }}
DOMAIN-SUFFIX,apple.co,{{ api_rule }}
DOMAIN-SUFFIX,itunes.com,{{ api_rule }}
DOMAIN-SUFFIX,itunes.apple.com,{{ api_rule }}
# iCloud 上传和下载
DOMAIN-SUFFIX,icloud-content.com,{{ api_rule }}
DOMAIN-SUFFIX,me.com,{{ api_rule }}
DOMAIN-SUFFIX,apple.com,{{ api_rule }}
DOMAIN-SUFFIX,icloud.com,{{ api_rule }}
DOMAIN-SUFFIX,apple-cloudkit.com,{{ api_rule }}
{% endmacro %}
