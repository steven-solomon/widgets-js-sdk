if window.CrowdTwist?
  console.error "CrowdTwist Widgets SDK already loaded! This is potentially problematic."
else
  window.CrowdTwist =
    version: "0.2.5"
    $: jQuery.noConflict(true)