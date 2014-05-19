/**
* CrowdTwist Widgets SDK for JavaScript
* v0.0.1
* 2014-05-19
**/(function(){var a,b=function(a,b){return function(){return a.apply(b,arguments)}};null!=(null!=(a=window.CT)?a.version:void 0)?console.log("CrowdTwist Widgets SDK already loaded! This is potentially problematic."):window.CT={version:"0.0.1"},function(a){var b,c,d;return null==a?(console.log("Error: Could not find global CT namespace!"),0):(b=!!window.CT_DEBUG,d="(widgets)",c="function"==typeof console.time,a.console={log:function(){var a;return b?(a=Array.prototype.slice.apply(arguments),c?(a.unshift("color: #bc43a7; font-weight: bold;"),a.unshift("%c"+d),console.log.apply(console,a)):console.log(a.join(" "))):void 0},group:function(a){return b?(a=d+" "+a,"function"==typeof console.group?console.group(a):console.log(a)):void 0},groupEnd:function(){return"function"==typeof console.groupEnd?console.groupEnd():void 0},time:function(a){return b&&"function"==typeof console.time?console.time(d+" "+a):void 0},timeEnd:function(a){return b&&"function"==typeof console.timeEnd?console.timeEnd(d+" "+a):void 0}})}(window.CT),function(a){var b;return null==a?(console.log("Error: Could not find global CT namespace!"),0):(b=function(a,b){var c,d,e,f,g,h;switch(g=-1,h=a.length,c=b[0],d=b[1],e=b[2],b.length){case 0:for(;++g<h;)(f=a[g]).callback.call(null);break;case 1:for(;++g<h;)(f=a[g]).callback.call(null,c);break;case 2:for(;++g<h;)(f=a[g]).callback.call(null,c,d);break;case 3:for(;++g<h;)(f=a[g]).callback.call(null,c,d,e);break;default:for(;++g<h;)(f=a[g]).callback.apply(null,b)}},a.Event={addEventListener:function(a,b,c){return"function"==typeof a.addEventListener?a.addEventListener(b,c):a.attachEvent("on"+b,c)},removeEventListener:function(a,b,c){return"function"==typeof a.removeEventListener?a.removeEventListener(b,c):a.detachEvent("on"+b,c)},ready:function(a){return"function"==typeof document.addEventListener?document.addEventListener("DOMContentLoaded",a):document.attachEvent("onreadystatechange",function(){return"complete"===document.readyState?a():void 0})},trigger:function(c){var d,e;return null==this._events?this:(d=Array.prototype.slice.call(arguments,1),e=this._events[c],e&&(b(e,d),a.console.log("triggered event '"+c+"' with arguments:",d)),this)},subscribe:function(a,b){var c,d;return null==b?this:(null==this._events&&(this._events={}),c=null!=(d=this._events)[a]?d[a]:d[a]=[],c.push({callback:b}),this)},unsubscribe:function(a,b){var c,d,e,f,g,h,i,j;if(null==a&&null==b)return this._events=null,this;for(e=a?[a]:[function(){var b;b=[];for(a in this._events)b.push(a);return b}.call(this)],g=0,i=e.length;i>g;g++)if(a=e[g],d=this._events[a]){if(this._events[a]=f=[],null!=b)for(h=0,j=d.length;j>h;h++)c=d[h],b!==c.callback&&f.push(c);f.length||delete this._events[a]}return this}})}(window.CT),function(a){var c;return null==a?(console.log("Error: Could not find global CT namespace!"),0):(c=function(){function c(c){var d;this.src=c.src,d=c.id,this._onMessage=b(this._onMessage,this),this.id=parseInt(d,10),"/"!==this.src.charAt(this.src.length-1)&&(this.src+="/"),this.origin=this.src.match(a.Widget._originRegex)[0],this.el=document.createElement("iframe"),this.el.setAttribute("frameborder",0),this.el.setAttribute("scrolling","no"),this.el.setAttribute("data-widget-id",this.id),this.el.setAttribute("src",this.src),this.el.style.width="100%",a.Event.addEventListener(window,"message",this._onMessage)}return c.prototype._onMessage=function(b){var c,d;if(!a.Widget.hasOrigin(b.origin))return void a.console.log("[Widget "+this.id+"] Received event from unregistered origin, dropping:",b);if(d=JSON.parse(b.data),this.id===parseInt(d.widgetId,10))switch(d.eventName){case"resize":c=d.eventData.height,null!=c?this.setHeight(c):a.console.log("[Widget "+this.id+"] Received 'resize' event with no 'height'",d)}return this.sendMessage(d),a.console.log("[Widget "+this.id+"] Received event '"+d.eventName+"' from widget '"+d.widgetId+"' with data:",d.eventData)},c.prototype._removeListeners=function(){return a.Event.removeEventListener(window,"message",this._onMessage)},c.prototype.setHeight=function(b){return b=parseInt(b,10),this.el.style.height=b+"px",this.el.parentNode===a.Modal._modal.el?a.Modal.setHeight(b):void 0},c.prototype.sendMessage=function(a){return"string"!=typeof a&&(a=JSON.stringify(a)),this.el.contentWindow.postMessage(a,"*")},c}(),a.Widget={_widgets:[],_originRegex:/((http(s)?:)?\/\/[^\/?&]+)/,addWidget:function(a){var b,d,e;return b=a.id,d=a.src,e=new c({id:null!=b?b:0,src:d}),this._widgets.push(e),e},removeWidget:function(a){var b;return a._removeListeners(),b=this._widgets.indexOf(a),b>-1?this._widgets.splice(b,1):void 0},replaceTagWithWidget:function(b){var c,d,e;return c=parseInt(b.getAttribute("data-widget-id"),10),d=b.getAttribute("data-src"),null!=this.getWidgetByWidgetId(c)?(a.console.group("Error"),a.console.log("Widget tags with widget id",c,"already exist!"),a.console.log("Will not convert the following widget tag:",b),void a.console.groupEnd()):(e=this.addWidget({id:c,src:d}),b.parentNode.replaceChild(e.el,b),a.console.log("Replaced tag",b,"with widget",e))},hasOrigin:function(a){var b,c,d,e,f;for(b=!1,f=this._widgets,d=0,e=f.length;e>d;d++)c=f[d],-1!==a.indexOf(c.origin)&&(b=!0);return b},getWidgetByWidgetId:function(a){var b,c,d,e;for(a=parseInt(a,10),e=this._widgets,c=0,d=e.length;d>c;c++)if(b=e[c],b.id===a)return b}})}(window.CT),function(a){var c;return null==a?(console.log("Error: Could not find global CT namespace!"),0):(c=function(){function c(){this.removeCurrentWidget=b(this.removeCurrentWidget,this),this.el=document.createElement("div"),this.el.setAttribute("id","ct-modal"),this.closeButton=document.createElement("button"),a.Event.addEventListener(this.closeButton,"click",function(a){return function(){return a.hide()}}(this)),this.background=document.createElement("div"),this._initStyles(),this.el.appendChild(this.closeButton)}return c.prototype.containerStyle={display:"none",zIndex:"100000",margin:"auto",width:"90%",position:"fixed",top:"0",right:"0",bottom:"0",left:"0",boxShadow:"0px 19px 33px -11px rgba(0, 0, 0, 0.75)"},c.prototype.closeButtonStyle={"float":"right",background:"none",border:"none",color:"#ffffff",fontSize:"20px",outline:"none",cursor:"pointer"},c.prototype.backgroundStyle={display:"none",position:"fixed",top:"0",left:"0",width:"100%",height:"100%",zIndex:"1000",backgroundColor:"#000000",opacity:"0.7",filter:"alpha(opacity=70)"},c.prototype.removeCurrentWidget=function(){return this.el.removeChild(this.widget.el),a.Widget.removeWidget(this.widget)},c.prototype.show=function(b){var c,d;return c=b.id,d=b.src,null!=this.widget&&this.removeCurrentWidget(),this.widget=a.Widget.addWidget({id:null!=c?c:0,src:d}),this.el.appendChild(this.widget.el),this.el.style.display="",this.background.style.display="",this},c.prototype.hide=function(){return this.el.style.display="none",this.background.style.display="none",this},c.prototype.setWidth=function(a){return a=parseInt(a,10),this.el.style.maxWidth=a+"px"},c.prototype.setHeight=function(a){return a=parseInt(a,10),this.el.style.height=a+"px"},c.prototype._initStyles=function(){var a,b,c,d,e,f;this.el.setAttribute("id","ct-modal"),c=this.containerStyle;for(a in c)b=c[a],this.el.style[a]=b;this.closeButton.innerHTML="&#10005;",d=this.closeButtonStyle;for(a in d)b=d[a],this.closeButton.style[a]=b;this.background.setAttribute("id","ct-modal-background"),e=this.backgroundStyle,f=[];for(a in e)b=e[a],f.push(this.background.style[a]=b);return f},c}(),a.Modal={initModalContainer:function(){return null!=document.getElementById("ct-modal")?void a.console.log("Modal container #ct-modal already exists!"):(this._modal=new c,document.body.insertBefore(this._modal.background,document.body.firstChild),document.body.insertBefore(this._modal.el,document.body.firstChild))},setWidth:function(a){return a=parseInt(a,10),this._modal.setWidth(a)},setHeight:function(a){return a=parseInt(a,10),this._modal.setHeight(a)},show:function(b){var c,d,e;return c=b.id,d=b.src,e=b.width,null==this._modal?void a.console.log("Modal not initialized!"):(this._modal.show({id:c,src:d}),null!=e?this.setWidth(e):void 0)},hide:function(){return null==this._modal?void a.console.log("Modal not initialized!"):this._modal.hide()}})}(window.CT),CT.Event.addEventListener(window,"message",function(a){var b,c,d,e,f,g;if(!CT.Widget.hasOrigin(a.origin))return void CT.console.log("[Dispatch] Received event from unregistered origin, dropping:",a);switch(b=JSON.parse(a.data),CT.Event.trigger(b.eventName,b),b.eventName){case"modal:open":return g=b.eventData,e=g.widgetId,c=g.src,f=g.width,null!=c?(CT.console.log("[Dispatch] Received 'modal:open' event, opening modal with data:",b.eventData),CT.Modal.show({id:null!=e?e:0,src:c,width:f})):CT.console.log("[Dispatch] Received 'modal:open' event with no 'src' eventData properties",b);case"modal:close":return CT.Modal.hide();case"navigate":return d=b.eventData.url,null!=d?(CT.console.log("[Dispatch] Received 'navigate' event, opening url:",d),window.open(d,"_blank")):CT.console.log("[Dispatch] Received 'navigate' event with no 'url'",b)}}),CT.console.group("Bootstrap"),CT.console.time("Bootstrapped in"),CT.console.time("DOM loaded"),CT.Event.ready(function(){var a,b,c,d;for(CT.console.timeEnd("DOM loaded"),CT.console.log("Initializing modal container"),CT.Modal.initModalContainer(),b=document.querySelectorAll("[class=ct-widget]"),CT.console.log("Found",b.length,"widget tag(s)"),CT.console.group("Tag replacement"),c=0,d=b.length;d>c;c++)a=b[c],CT.Widget.replaceTagWithWidget(a);return CT.console.groupEnd(),CT.console.groupEnd(),CT.console.timeEnd("Bootstrapped in")})}).call(this);