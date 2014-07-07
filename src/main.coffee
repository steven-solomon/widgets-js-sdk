if window.CT?.version?
  console.log "CrowdTwist Widgets SDK already loaded! This is potentially problematic."
else
  window.CT =
    version: "0.1.0"
    $: jQuery.noConflict()