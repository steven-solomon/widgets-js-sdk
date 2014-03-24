/*!
 * https://github.com/es-shims/es5-shim
 * @license es5-shim Copyright 2009-2014 by contributors, MIT License
 * see https://github.com/es-shims/es5-shim/blob/master/LICENSE
 */
 /* jshint ignore:start */
(function(root,factory){if(typeof define==="function"&&define.amd){define(factory)}else if(typeof exports==="object"){module.exports=factory()}else{root.returnExports=factory()}})(this,function(){function Empty(){}if(!Function.prototype.bind){Function.prototype.bind=function bind(that){var target=this;if(typeof target!="function"){throw new TypeError("Function.prototype.bind called on incompatible "+target)}var args=_Array_slice_.call(arguments,1);var binder=function(){if(this instanceof bound){var result=target.apply(this,args.concat(_Array_slice_.call(arguments)));if(Object(result)===result){return result}return this}else{return target.apply(that,args.concat(_Array_slice_.call(arguments)))}};var boundLength=Math.max(0,target.length-args.length);var boundArgs=[];for(var i=0;i<boundLength;i++){boundArgs.push("$"+i)}var bound=Function("binder","return function("+boundArgs.join(",")+"){return binder.apply(this,arguments)}")(binder);if(target.prototype){Empty.prototype=target.prototype;bound.prototype=new Empty;Empty.prototype=null}return bound}}var call=Function.prototype.call;var prototypeOfArray=Array.prototype;var prototypeOfObject=Object.prototype;var _Array_slice_=prototypeOfArray.slice;var _toString=call.bind(prototypeOfObject.toString);var owns=call.bind(prototypeOfObject.hasOwnProperty);var defineGetter;var defineSetter;var lookupGetter;var lookupSetter;var supportsAccessors;if(supportsAccessors=owns(prototypeOfObject,"__defineGetter__")){defineGetter=call.bind(prototypeOfObject.__defineGetter__);defineSetter=call.bind(prototypeOfObject.__defineSetter__);lookupGetter=call.bind(prototypeOfObject.__lookupGetter__);lookupSetter=call.bind(prototypeOfObject.__lookupSetter__)}if([1,2].splice(0).length!=2){var array_splice=Array.prototype.splice;var array_push=Array.prototype.push;var array_unshift=Array.prototype.unshift;if(function(){function makeArray(l){var a=[];while(l--){a.unshift(l)}return a}var array=[],lengthBefore;array.splice.bind(array,0,0).apply(null,makeArray(20));array.splice.bind(array,0,0).apply(null,makeArray(26));lengthBefore=array.length;array.splice(5,0,"XXX");if(lengthBefore+1==array.length){return true}}()){Array.prototype.splice=function(start,deleteCount){if(!arguments.length){return[]}else{return array_splice.apply(this,[start===void 0?0:start,deleteCount===void 0?this.length-start:deleteCount].concat(_Array_slice_.call(arguments,2)))}}}else{Array.prototype.splice=function(start,deleteCount){var result,args=_Array_slice_.call(arguments,2),addElementsCount=args.length;if(!arguments.length){return[]}if(start===void 0){start=0}if(deleteCount===void 0){deleteCount=this.length-start}if(addElementsCount>0){if(deleteCount<=0){if(start==this.length){array_push.apply(this,args);return[]}if(start==0){array_unshift.apply(this,args);return[]}}result=_Array_slice_.call(this,start,start+deleteCount);args.push.apply(args,_Array_slice_.call(this,start+deleteCount,this.length));args.unshift.apply(args,_Array_slice_.call(this,0,start));args.unshift(0,this.length);array_splice.apply(this,args);return result}return array_splice.call(this,start,deleteCount)}}}if([].unshift(0)!=1){var array_unshift=Array.prototype.unshift;Array.prototype.unshift=function(){array_unshift.apply(this,arguments);return this.length}}if(!Array.isArray){Array.isArray=function isArray(obj){return _toString(obj)=="[object Array]"}}var boxedString=Object("a");var splitString=boxedString[0]!="a"||!(0 in boxedString);var properlyBoxesContext=function properlyBoxed(method){var properlyBoxes=true;if(method){method.call("foo",function(item,index,context){if(typeof context!=="object"){properlyBoxes=false}})}return!!method&&properlyBoxes};if(!Array.prototype.forEach||!properlyBoxesContext(Array.prototype.forEach)){Array.prototype.forEach=function forEach(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,thisp=arguments[1],i=-1,length=self.length>>>0;if(_toString(fun)!="[object Function]"){throw new TypeError}while(++i<length){if(i in self){fun.call(thisp,self[i],i,object)}}}}if(!Array.prototype.map||!properlyBoxesContext(Array.prototype.map)){Array.prototype.map=function map(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,length=self.length>>>0,result=Array(length),thisp=arguments[1];if(_toString(fun)!="[object Function]"){throw new TypeError(fun+" is not a function")}for(var i=0;i<length;i++){if(i in self)result[i]=fun.call(thisp,self[i],i,object)}return result}}if(!Array.prototype.filter||!properlyBoxesContext(Array.prototype.filter)){Array.prototype.filter=function filter(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,length=self.length>>>0,result=[],value,thisp=arguments[1];if(_toString(fun)!="[object Function]"){throw new TypeError(fun+" is not a function")}for(var i=0;i<length;i++){if(i in self){value=self[i];if(fun.call(thisp,value,i,object)){result.push(value)}}}return result}}if(!Array.prototype.every||!properlyBoxesContext(Array.prototype.every)){Array.prototype.every=function every(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,length=self.length>>>0,thisp=arguments[1];if(_toString(fun)!="[object Function]"){throw new TypeError(fun+" is not a function")}for(var i=0;i<length;i++){if(i in self&&!fun.call(thisp,self[i],i,object)){return false}}return true}}if(!Array.prototype.some||!properlyBoxesContext(Array.prototype.some)){Array.prototype.some=function some(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,length=self.length>>>0,thisp=arguments[1];if(_toString(fun)!="[object Function]"){throw new TypeError(fun+" is not a function")}for(var i=0;i<length;i++){if(i in self&&fun.call(thisp,self[i],i,object)){return true}}return false}}if(!Array.prototype.reduce){Array.prototype.reduce=function reduce(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,length=self.length>>>0;if(_toString(fun)!="[object Function]"){throw new TypeError(fun+" is not a function")}if(!length&&arguments.length==1){throw new TypeError("reduce of empty array with no initial value")}var i=0;var result;if(arguments.length>=2){result=arguments[1]}else{do{if(i in self){result=self[i++];break}if(++i>=length){throw new TypeError("reduce of empty array with no initial value")}}while(true)}for(;i<length;i++){if(i in self){result=fun.call(void 0,result,self[i],i,object)}}return result}}if(!Array.prototype.reduceRight){Array.prototype.reduceRight=function reduceRight(fun){var object=toObject(this),self=splitString&&_toString(this)=="[object String]"?this.split(""):object,length=self.length>>>0;if(_toString(fun)!="[object Function]"){throw new TypeError(fun+" is not a function")}if(!length&&arguments.length==1){throw new TypeError("reduceRight of empty array with no initial value")}var result,i=length-1;if(arguments.length>=2){result=arguments[1]}else{do{if(i in self){result=self[i--];break}if(--i<0){throw new TypeError("reduceRight of empty array with no initial value")}}while(true)}if(i<0){return result}do{if(i in this){result=fun.call(void 0,result,self[i],i,object)}}while(i--);return result}}if(!Array.prototype.indexOf||[0,1].indexOf(1,2)!=-1){Array.prototype.indexOf=function indexOf(sought){var self=splitString&&_toString(this)=="[object String]"?this.split(""):toObject(this),length=self.length>>>0;if(!length){return-1}var i=0;if(arguments.length>1){i=toInteger(arguments[1])}i=i>=0?i:Math.max(0,length+i);for(;i<length;i++){if(i in self&&self[i]===sought){return i}}return-1}}if(!Array.prototype.lastIndexOf||[0,1].lastIndexOf(0,-3)!=-1){Array.prototype.lastIndexOf=function lastIndexOf(sought){var self=splitString&&_toString(this)=="[object String]"?this.split(""):toObject(this),length=self.length>>>0;if(!length){return-1}var i=length-1;if(arguments.length>1){i=Math.min(i,toInteger(arguments[1]))}i=i>=0?i:length-Math.abs(i);for(;i>=0;i--){if(i in self&&sought===self[i]){return i}}return-1}}if(!Object.keys){var hasDontEnumBug=true,hasProtoEnumBug=function(){}.propertyIsEnumerable("prototype"),dontEnums=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],dontEnumsLength=dontEnums.length;for(var key in{toString:null}){hasDontEnumBug=false}Object.keys=function keys(object){var isFunction=_toString(object)==="[object Function]",isObject=object!==null&&typeof object==="object";if(!isObject&&!isFunction){throw new TypeError("Object.keys called on a non-object")}var keys=[],skipProto=hasProtoEnumBug&&isFunction;for(var name in object){if(!(skipProto&&name==="prototype")&&owns(object,name)){keys.push(name)}}if(hasDontEnumBug){var ctor=object.constructor,skipConstructor=ctor&&ctor.prototype===object;for(var i=0;i<dontEnumsLength;i++){var dontEnum=dontEnums[i];if(!(skipConstructor&&dontEnum==="constructor")&&owns(object,dontEnum)){keys.push(dontEnum)}}}return keys}}var negativeDate=-621987552e5,negativeYearString="-000001";if(!Date.prototype.toISOString||new Date(negativeDate).toISOString().indexOf(negativeYearString)===-1){Date.prototype.toISOString=function toISOString(){var result,length,value,year,month;if(!isFinite(this)){throw new RangeError("Date.prototype.toISOString called on non-finite value.")}year=this.getUTCFullYear();month=this.getUTCMonth();year+=Math.floor(month/12);month=(month%12+12)%12;result=[month+1,this.getUTCDate(),this.getUTCHours(),this.getUTCMinutes(),this.getUTCSeconds()];year=(year<0?"-":year>9999?"+":"")+("00000"+Math.abs(year)).slice(0<=year&&year<=9999?-4:-6);length=result.length;while(length--){value=result[length];if(value<10){result[length]="0"+value}}return year+"-"+result.slice(0,2).join("-")+"T"+result.slice(2).join(":")+"."+("000"+this.getUTCMilliseconds()).slice(-3)+"Z"}}var dateToJSONIsSupported=false;try{dateToJSONIsSupported=Date.prototype.toJSON&&new Date(NaN).toJSON()===null&&new Date(negativeDate).toJSON().indexOf(negativeYearString)!==-1&&Date.prototype.toJSON.call({toISOString:function(){return true}})}catch(e){}if(!dateToJSONIsSupported){Date.prototype.toJSON=function toJSON(key){var o=Object(this),tv=toPrimitive(o),toISO;if(typeof tv==="number"&&!isFinite(tv)){return null}toISO=o.toISOString;if(typeof toISO!="function"){throw new TypeError("toISOString property is not callable")}return toISO.call(o)}}if(!Date.parse||"Date.parse is buggy"){Date=function(NativeDate){function Date(Y,M,D,h,m,s,ms){var length=arguments.length;if(this instanceof NativeDate){var date=length==1&&String(Y)===Y?new NativeDate(Date.parse(Y)):length>=7?new NativeDate(Y,M,D,h,m,s,ms):length>=6?new NativeDate(Y,M,D,h,m,s):length>=5?new NativeDate(Y,M,D,h,m):length>=4?new NativeDate(Y,M,D,h):length>=3?new NativeDate(Y,M,D):length>=2?new NativeDate(Y,M):length>=1?new NativeDate(Y):new NativeDate;date.constructor=Date;return date}return NativeDate.apply(this,arguments)}var isoDateExpression=new RegExp("^"+"(\\d{4}|[+-]\\d{6})"+"(?:-(\\d{2})"+"(?:-(\\d{2})"+"(?:"+"T(\\d{2})"+":(\\d{2})"+"(?:"+":(\\d{2})"+"(?:(\\.\\d{1,}))?"+")?"+"("+"Z|"+"(?:"+"([-+])"+"(\\d{2})"+":(\\d{2})"+")"+")?)?)?)?"+"$");var months=[0,31,59,90,120,151,181,212,243,273,304,334,365];function dayFromMonth(year,month){var t=month>1?1:0;return months[month]+Math.floor((year-1969+t)/4)-Math.floor((year-1901+t)/100)+Math.floor((year-1601+t)/400)+365*(year-1970)}function toUTC(t){return Number(new NativeDate(1970,0,1,0,0,0,t))}for(var key in NativeDate){Date[key]=NativeDate[key]}Date.now=NativeDate.now;Date.UTC=NativeDate.UTC;Date.prototype=NativeDate.prototype;Date.prototype.constructor=Date;Date.parse=function parse(string){var match=isoDateExpression.exec(string);if(match){var year=Number(match[1]),month=Number(match[2]||1)-1,day=Number(match[3]||1)-1,hour=Number(match[4]||0),minute=Number(match[5]||0),second=Number(match[6]||0),millisecond=Math.floor(Number(match[7]||0)*1e3),isLocalTime=Boolean(match[4]&&!match[8]),signOffset=match[9]==="-"?1:-1,hourOffset=Number(match[10]||0),minuteOffset=Number(match[11]||0),result;if(hour<(minute>0||second>0||millisecond>0?24:25)&&minute<60&&second<60&&millisecond<1e3&&month>-1&&month<12&&hourOffset<24&&minuteOffset<60&&day>-1&&day<dayFromMonth(year,month+1)-dayFromMonth(year,month)){result=((dayFromMonth(year,month)+day)*24+hour+hourOffset*signOffset)*60;result=((result+minute+minuteOffset*signOffset)*60+second)*1e3+millisecond;if(isLocalTime){result=toUTC(result)}if(-864e13<=result&&result<=864e13){return result}}return NaN}return NativeDate.parse.apply(this,arguments)};return Date}(Date)}if(!Date.now){Date.now=function now(){return(new Date).getTime()}}if(!Number.prototype.toFixed||8e-5.toFixed(3)!=="0.000"||.9.toFixed(0)==="0"||1.255.toFixed(2)!=="1.25"||0xde0b6b3a7640080.toFixed(0)!=="1000000000000000128"){(function(){var base,size,data,i;base=1e7;size=6;data=[0,0,0,0,0,0];function multiply(n,c){var i=-1;while(++i<size){c+=n*data[i];data[i]=c%base;c=Math.floor(c/base)}}function divide(n){var i=size,c=0;while(--i>=0){c+=data[i];data[i]=Math.floor(c/n);c=c%n*base}}function toString(){var i=size;var s="";while(--i>=0){if(s!==""||i===0||data[i]!==0){var t=String(data[i]);if(s===""){s=t}else{s+="0000000".slice(0,7-t.length)+t}}}return s}function pow(x,n,acc){return n===0?acc:n%2===1?pow(x,n-1,acc*x):pow(x*x,n/2,acc)}function log(x){var n=0;while(x>=4096){n+=12;x/=4096}while(x>=2){n+=1;x/=2}return n}Number.prototype.toFixed=function(fractionDigits){var f,x,s,m,e,z,j,k;f=Number(fractionDigits);f=f!==f?0:Math.floor(f);if(f<0||f>20){throw new RangeError("Number.toFixed called with invalid number of decimals")}x=Number(this);if(x!==x){return"NaN"}if(x<=-1e21||x>=1e21){return String(x)}s="";if(x<0){s="-";x=-x}m="0";if(x>1e-21){e=log(x*pow(2,69,1))-69;z=e<0?x*pow(2,-e,1):x/pow(2,e,1);z*=4503599627370496;e=52-e;if(e>0){multiply(0,z);j=f;while(j>=7){multiply(1e7,0);j-=7}multiply(pow(10,j,1),0);j=e-1;while(j>=23){divide(1<<23);j-=23}divide(1<<j);multiply(1,1);divide(2);m=toString()}else{multiply(0,z);multiply(1<<-e,0);m=toString()+"0.00000000000000000000".slice(2,2+f)}}if(f>0){k=m.length;if(k<=f){m=s+"0.0000000000000000000".slice(0,f-k+2)+m}else{m=s+m.slice(0,k-f)+"."+m.slice(k-f)}}else{m=s+m}return m}})()}var string_split=String.prototype.split;if("ab".split(/(?:ab)*/).length!==2||".".split(/(.?)(.?)/).length!==4||"tesst".split(/(s)*/)[1]==="t"||"".split(/.?/).length||".".split(/()()/).length>1){(function(){var compliantExecNpcg=/()??/.exec("")[1]===void 0;String.prototype.split=function(separator,limit){var string=this;if(separator===void 0&&limit===0)return[];if(Object.prototype.toString.call(separator)!=="[object RegExp]"){return string_split.apply(this,arguments)}var output=[],flags=(separator.ignoreCase?"i":"")+(separator.multiline?"m":"")+(separator.extended?"x":"")+(separator.sticky?"y":""),lastLastIndex=0,separator=new RegExp(separator.source,flags+"g"),separator2,match,lastIndex,lastLength;string+="";if(!compliantExecNpcg){separator2=new RegExp("^"+separator.source+"$(?!\\s)",flags)}limit=limit===void 0?-1>>>0:limit>>>0;while(match=separator.exec(string)){lastIndex=match.index+match[0].length;if(lastIndex>lastLastIndex){output.push(string.slice(lastLastIndex,match.index));if(!compliantExecNpcg&&match.length>1){match[0].replace(separator2,function(){for(var i=1;i<arguments.length-2;i++){if(arguments[i]===void 0){match[i]=void 0}}})}if(match.length>1&&match.index<string.length){Array.prototype.push.apply(output,match.slice(1))}lastLength=match[0].length;lastLastIndex=lastIndex;if(output.length>=limit){break}}if(separator.lastIndex===match.index){separator.lastIndex++}}if(lastLastIndex===string.length){if(lastLength||!separator.test("")){output.push("")}}else{output.push(string.slice(lastLastIndex))}return output.length>limit?output.slice(0,limit):output}})()}else if("0".split(void 0,0).length){String.prototype.split=function(separator,limit){if(separator===void 0&&limit===0)return[];return string_split.apply(this,arguments)}}if("".substr&&"0b".substr(-1)!=="b"){var string_substr=String.prototype.substr;String.prototype.substr=function(start,length){return string_substr.call(this,start<0?(start=this.length+start)<0?0:start:start,length)}}var ws="  \n\f\r \xa0\u1680\u180e\u2000\u2001\u2002\u2003"+"\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028"+"\u2029\ufeff";if(!String.prototype.trim||ws.trim()){ws="["+ws+"]";var trimBeginRegexp=new RegExp("^"+ws+ws+"*"),trimEndRegexp=new RegExp(ws+ws+"*$");String.prototype.trim=function trim(){if(this===void 0||this===null){throw new TypeError("can't convert "+this+" to object")}return String(this).replace(trimBeginRegexp,"").replace(trimEndRegexp,"")}}if(parseInt(ws+"08")!==8||parseInt(ws+"0x16")!==22){parseInt=function(origParseInt){var hexRegex=/^0[xX]/;return function parseIntES5(str,radix){str=String(str).trim();if(!+radix){radix=hexRegex.test(str)?16:10}return origParseInt(str,radix)}}(parseInt)}function toInteger(n){n=+n;if(n!==n){n=0}else if(n!==0&&n!==1/0&&n!==-(1/0)){n=(n>0||-1)*Math.floor(Math.abs(n))}return n}function isPrimitive(input){var type=typeof input;return input===null||type==="undefined"||type==="boolean"||type==="number"||type==="string"}function toPrimitive(input){var val,valueOf,toString;if(isPrimitive(input)){return input}valueOf=input.valueOf;if(typeof valueOf==="function"){val=valueOf.call(input);if(isPrimitive(val)){return val}}toString=input.toString;if(typeof toString==="function"){val=toString.call(input);if(isPrimitive(val)){return val}}throw new TypeError}var toObject=function(o){if(o==null){throw new TypeError("can't convert "+o+" to object")}return Object(o)}});
/* jshint ignore:end */

// CT Widgets JS SDK
// -----------------
// v0.0.1
//
// Copyright (c)2014 CrowdTwist
//
// http://crowdtwist.com
(function(w, d) {

  // Debug flag that determines if messages are logged to the console
  var DEBUG = !!w.CT_DEBUG;

  // The string that prepends all console logs
  var LOG_PREFIX = "(widgets)";

  var NOOP = function() {};

  // Array of iframe sources to check when receiving 'message' event, for security
  var IFRAME_ORIGINS = [];

  // Used to grab the origin portion of an href
  var ORIGIN_REGEX = /(http(s)?:\/\/[^\/?&]+)/;

  /*******
  * Shims
  ********/

  /**
   * Console wrappers for:
   *    - log
   *    - group
   *    - groupEnd
   *    - time
   *    - timeEnd
   */
  function _log() {
    if (DEBUG) {
      var args = Array.prototype.slice.apply(arguments);
      args.unshift("color: #bc43a7; font-weight: bold;");
      args.unshift("%c" + LOG_PREFIX);
      console.log.apply(console, args);
    }
  }

  var log = (typeof console.time === "function") ? _log : DEBUG ? console.log : NOOP;

  function group(label) {
    if (DEBUG) {
      if (typeof console.group === "function") {
        label = LOG_PREFIX + " " + label;
        console.group(label);
      } else {
        console.log(label);
      }
    }
  }

  function groupEnd() {
    if (DEBUG) {
      if (typeof console.groupEnd === "function") {
        console.groupEnd();
      }
    }
  }

  function time(label) {
    if (DEBUG) {
      if (typeof console.time === "function") {
        label = LOG_PREFIX + " " + label;
        console.time(label);
      }
    }
  }

  function timeEnd(label) {
    if (DEBUG) {
      if (typeof console.timeEnd === "function") {
        label = LOG_PREFIX + " " + label;
        console.timeEnd(label);
      }
    }
  }

  function addEventListener(el, eventName, handler) {
    if (typeof el.addEventListener === "function")
      el.addEventListener(eventName, handler);
    else
      el.attachEvent('on' + eventName, handler);
  }

  function removeEventListener(el, eventName, handler) {
    if (typeof el.removeEventListener === "function")
      el.removeEventListener(eventName, handler);
    else
      el.detachEvent('on' + eventName, handler);
  }

  /**
   * Specify a function to execute when the DOM is fully loaded.
   * Used to wait for DOM until beginning to parse for widget tags.
   * @param  {Function} fn A function to execute when DOM is loaded
   */
  function ready(fn) {
    if (typeof d.addEventListener === "function") {
      d.addEventListener('DOMContentLoaded', fn);
    } else {
      d.attachEvent('onreadystatechange', function() {
        if (d.readyState === 'complete')
          fn();
      });
    }
  }


  /**
   * Called during bootstrapping to replace a widget tag with an iframe.
   *
   * @param {DOMElement} widget A dom element representing a widget tag.
   */
  function replaceTagWithIframe(widget) {
    var widgetClass = widget.className;
    var widgetSource = widget.getAttribute('data-src');
    var widgetOrigin = widgetSource.match(ORIGIN_REGEX)[0];
    IFRAME_ORIGINS.push(widgetOrigin);

    // Enforce trailing slash for browser consistency
    if (widgetSource.charAt(widgetSource.length-1) != '/')
      widgetSource += '/';

    var iframe = d.createElement('iframe');
    iframe.setAttribute('src', widgetSource);
    iframe.setAttribute('frameborder', 0);
    iframe.setAttribute('scrolling', 'no');
    iframe.style.width = '100%';

    widget.parentNode.replaceChild(iframe, widget);
    log("Replaced tag", widgetClass, "with iframe pointing to", widgetSource);
  }


  /***********************
  * Modal helper functions
  ************************/

  /**
   * Unless already exists, create and insert element into host page
   * that will contain the modal content. Also create element for the dim background.
   *
   * Currently identifying container by the id: ct-modal
   */
  function initModalContainer() {
    if (d.getElementById('ct-modal') !== null) {
      log("Modal container #ct-modal already exists!");
      return;
    }

    // Create the actual modal div
    var modal = d.createElement('div');
    modal.setAttribute('id', 'ct-modal');
    modal.style.display = 'none';
    modal.style.zIndex = 100000;
    modal.style.margin = 'auto';
    modal.style.width = '90%';
    modal.style.position = 'fixed';
    modal.style.top = '0';
    modal.style.right = '0';
    modal.style.bottom = '100px';
    modal.style.left = '0';

    // Create the close button
    var closeButton = d.createElement('button');
    closeButton.innerHTML = '&#10005;';
    closeButton.style.float = 'right';
    closeButton.style.background = 'none';
    closeButton.style.border = 'none';
    closeButton.style.color = '#fff';
    closeButton.style.fontSize = '20px';

    addEventListener(closeButton, 'click', function() {
      hideModal();
    });

    modal.appendChild(closeButton);

    // Create the iframe that represents the main content of the modal
    var iframe = d.createElement('iframe');
    iframe.setAttribute('frameborder', 0);
    iframe.setAttribute('scrolling', 'no');
    iframe.style.width = '100%';

    modal.appendChild(iframe);

    // Create the background element that appears to dim the whole page
    var modalBackground = d.createElement('div');
    modalBackground.setAttribute('id', 'ct-modal-background');
    modalBackground.style.display = 'none';
    modalBackground.style.position = 'fixed';
    modalBackground.style.top = 0;
    modalBackground.style.left = 0;
    modalBackground.style.width = '100%';
    modalBackground.style.height = '100%';
    modalBackground.style.zIndex = 1000;
    modalBackground.style.background = '#000';
    modalBackground.style.opacity = 0.7;
    modalBackground.style.filter = 'alpha(opacity=70)';

    // Insert modal and modal background into the body at the top
    d.body.insertBefore(modalBackground, d.body.firstChild);
    d.body.insertBefore(modal, d.body.firstChild);
  }

  /**
   * Shows the modal and sets its iframe src to the provided widget url
   * @param  {String} url Widget url
   */
  function showModalWithWidgetUrl(url) {
    var modal = d.getElementById('ct-modal');
    var modalBackground = d.getElementById('ct-modal-background');

    if (modal === null) {
      log("#ct-modal has not been initialized! Please run initModalContainer()");
      return;
    }

    var iframe = modal.querySelector('iframe');
    iframe.setAttribute('src', url);

    modal.style.display = '';
    modalBackground.style.display = '';
  }

  /**
   * Hides the modal
   */
  function hideModal() {
    var modal = d.getElementById('ct-modal');
    var modalBackground = d.getElementById('ct-modal-background');

    if (modal === null) {
      log("#ct-modal has not been initialized! Please run initModalContainer()");
      return;
    }

    modal.style.display = 'none';
    modalBackground.style.display = 'none';
  }


  /**************************************************************
  * Set up postMessage event handler
  *
  * This is the main handler that listens on events from iframes
  ***************************************************************/

  /**
   * Given an iframe and a payload from a messsage, resize iframe accordingly
   * @param  {DOMElement} iframe The target iframe to resize
   * @param  {Object} payload Data containing dimensions and other info
   */
  function handleResize(iframe, payload) {
    var height = payload.data.height;

    log('Resizing iframe with src', iframe.getAttribute('src'), 'to height', height);
    iframe.setAttribute('height', height);

    // If iframe is in a modal, resize the modal as well
    var modal = d.getElementById('ct-modal');
    if (iframe.parentNode === modal)
      modal.style.height = height + 'px';
  }


  addEventListener(window, 'message', function(event) {
    if (IFRAME_ORIGINS.indexOf(event.origin) == -1) {
      log("Dropping message from unauthorized domain:", event.origin);
      return;
    }

    // Parse the `data` property of the message event object
    var payload = JSON.parse(event.data);

    if (payload.src === null || payload.src.length === 0) {
      log("No src was provided with message, doing nothing!", payload);
      return;
    }

    // Get reference to the iframe that sent the message via `src`
    var iframe = d.querySelector("iframe[src='" + payload.src + "']");

    if (iframe === null) {
      log("Received message but could not find iframe with matching message src:", payload);
      return;
    }

    // Switch on the message action and perform relevant behavior
    switch (payload.action) {
      case 'resize':
        handleResize(iframe, payload);
        break;
      case 'modal':
        showModalWithWidgetUrl(payload.data.url);
        break;
      default:
        log("No valid payload action provided, doing nothing!", payload);
        return;
    }
  });

  /*********************************************************
  * Entry Point
  *
  * Wait for DOM to load then convert widget tags to iframes
  **********************************************************/

  group("Bootstrap");
  time("Bootstrapped in");
  time("DOM Loaded");

  ready(function() {
    timeEnd("DOM Loaded");

    initModalContainer();

    var widgets = d.querySelectorAll("[class^=ct-]");
    log("Found", widgets.length, "widget tag(s)");

    group("Tag Replacement");

    for (var i = 0; i < widgets.length; i++) {
      var widget = widgets[i];
      replaceTagWithIframe(widget);
    }

    groupEnd();
    groupEnd();

    timeEnd("Bootstrapped in");
  });
})(window, document);
