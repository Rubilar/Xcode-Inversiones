(function(a){var b={listTargetID:null,onClass:"",offClass:"",hideInList:[],colsHidden:[],saveState:false,onToggle:null,show:function(a){g(a)},hide:function(a){f(a)}};var c=0;var d="columnManagerC";var e=function(b){var c="",e=0,f=b.cMColsVisible;if(b.cMSaveState&&b.id&&f&&a.cookie){for(;e<f.length;e++){c+=f[e]==false?0:1}a.cookie(d+b.id,c,{expires:9999})}};var f=function(a){if(jQuery.browser.msie){(f=function(a){a.style.setAttribute("display","none")})(a)}else{(f=function(a){a.style.display="none"})(a)}};var g=function(a){if(jQuery.browser.msie){(g=function(a){a.style.setAttribute("display","block")})(a)}else{(g=function(a){a.style.display="table-cell"})(a)}};var h=function(a){if(jQuery.browser.msie){return(h=function(a){return a.style.getAttribute("display")!="none"})(a)}else{return(h=function(a){return a.style.display!="none"})(a)}};var i=function(a,b,c){for(var d=0;d<b.length;d++){if(b[d].realIndex===undefined){j(a)}if(b[d].realIndex==c){return b[d]}}return null};var j=function(a){var b=a.rows;var c=b.length;var d=[];for(var e=0;e<c;e++){var f=b[e].cells;var g=f.length;for(var h=0;h<g;h++){var i=f[h];var j=i.rowSpan||1;var k=i.colSpan||1;var l=-1;if(!d[e]){d[e]=[]}var m=d[e];while(m[++l]){}i.realIndex=l;for(var n=e;n<e+j;n++){if(!d[n]){d[n]=[]}var o=d[n];for(var p=l;p<l+k;p++){o[p]=1}}}}};a.fn.columnManager=function(e){var f=a.extend({},b,e);var g=function(b){if(!f.listTargetID){return}var c=a("#"+f.listTargetID);if(!c.length){return}var d=null;if(b.tHead&&b.tHead.length){d=b.tHead.rows[0]}else if(b.rows.length){d=b.rows[0]}else{return}var e=d.cells;if(!e.length){return}var g=null;if(c.get(0).nodeName.toUpperCase()=="UL"){g=c}else{g=a("<ul></ul>");c.append(g)}var i=b.cMColsVisible;for(var j=0;j<e.length;j++){if(a.inArray(j+1,f.hideInList)>=0){continue}i[j]=i[j]!==undefined?i[j]:true;var k=a(e[j]).text(),l;if(!k.length){k=a(e[j]).html();if(!k.length){k="undefined"}}if(i[j]&&f.onClass){l=f.onClass}else if(!i[j]&&f.offClass){l=f.offClass}var m=a('<li class="'+l+'">'+k+"</li>").click(h);m[0].cmData={id:b.id,col:j};g.append(m)}b.cMColsVisible=i};var h=function(){var b=this.cmData;if(b&&b.id&&b.col>=0){var c=b.col,d=a("#"+b.id);if(d.length){d.toggleColumns([c+1],f);var e=d.get(0).cMColsVisible;if(f.onToggle){f.onToggle.apply(d.get(0),[c+1,e[c]])}}}};var i=function(b){var c=a.cookie(d+b);if(c){var e=c.split("");for(var f=0;f<e.length;f++){e[f]&=1}return e}return false};return this.each(function(){this.id=this.id||"jQcM0O"+c++;var b,d=[],e=[];j(this);if(f.colsHidden.length){for(b=0;b<f.colsHidden.length;b++){e[f.colsHidden[b]-1]=true;d[f.colsHidden[b]-1]=true}}if(f.saveState){var h=i(this.id);if(h&&h.length){for(b=0;b<h.length;b++){e[b]=true;d[b]=!h[b]}}this.cMSaveState=true}this.cMColsVisible=e;if(d.length){var k=[];for(b=0;b<d.length;b++){if(d[b]){k[k.length]=b+1}}if(k.length){a(this).toggleColumns(k)}}g(this)})};a.fn.toggleColumns=function(b,c){return this.each(function(){var d,j,k,l=this.rows,m=this.cMColsVisible;if(!b)return;if(b.constructor==Number)b=[b];if(!m)m=this.cMColsVisible=[];for(d=0;d<l.length;d++){var n=l[d].cells;for(var o=0;o<b.length;o++){var p=b[o]-1;if(p>=0){var q=i(this,n,p);if(!q){var r=p;while(r>0&&!(q=i(this,n,--r))){}if(!q){continue}}if(m[p]==undefined){m[p]=true}if(m[p]){j=c&&c.hide?c.hide:f;k=-1}else{j=c&&c.show?c.show:g;k=1}if(!q.chSpan){q.chSpan=0}if(q.colSpan>1||k==1&&q.chSpan&&h(q)){if(q.realIndex+q.colSpan+q.chSpan-1<p){continue}q.colSpan+=k;q.chSpan+=k*-1}else if(q.realIndex+q.chSpan<p){continue}else{j(q)}}}}for(d=0;d<b.length;d++){this.cMColsVisible[b[d]-1]=!m[b[d]-1];if(c&&c.listTargetID&&(c.onClass||c.offClass)){var s=c.onClass,t=c.offClass,u;if(m[b[d]-1]){s=t;t=c.onClass}u=a("#"+c.listTargetID+" li").filter(function(){return this.cmData&&this.cmData.col==b[d]-1});if(s){u.removeClass(s)}if(t){u.addClass(t)}}}e(this)})};a.fn.showColumns=function(b,c){return this.each(function(){var d,e=[],f=this.cMColsVisible;if(f){if(b&&b.constructor==Number)b=[b];for(d=0;d<f.length;d++){if(!f[d]&&(!b||a.inArray(d+1,b)>-1))e.push(d+1)}a(this).toggleColumns(e,c)}})};a.fn.hideColumns=function(b,c){return this.each(function(){var d,e=b,f=this.cMColsVisible;if(f){if(b.constructor==Number)b=[b];e=[];for(d=0;d<b.length;d++){if(f[b[d]-1]||f[b[d]-1]==undefined)e.push(b[d])}}a(this).toggleColumns(e,c)})}})(jQuery)