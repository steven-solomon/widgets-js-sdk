###*
 * CrowdTwist Widgets SDK for JavaScript
 *
 * v0.0.1
 *
 * Copyright (c)2014 CrowdTwist
###
if window.CT?._version?
  console.log "CrowdTwist Widgets SDK already loaded!"
else
  window.CT =
    _version: "0.0.1"
    _iframeOrigins: []
    _originRegex: /(http(s)?:\/\/[^\/?&]+)/