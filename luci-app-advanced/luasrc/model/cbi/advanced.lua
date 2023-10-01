local e=require"nixio.fs"
local t=require"luci.sys"
local t=luci.model.uci.cursor()
m=Map("advanced",translate("進階進階設定"),translate("<font color=\"Red\"><strong>設定文件是直接編輯的除非你知道自己在幹嘛，否則請不要 輕易修改這些設定文件。設定不正確可能會導致不能開機等錯誤。</strong></font><br/>"))
m.apply_on_parse=true
s=m:section(TypedSection,"advanced")
s.anonymous=true

if nixio.fs.access("/etc/dnsmasq.conf")then

s:tab("dnsmasqconf",translate("dnsmasq"),translate("本頁是設定/etc/dnsmasq.conf的文件內容。套用儲存後自動重新啟動生效"))

conf=s:taboption("dnsmasqconf",Value,"dnsmasqconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/dnsmasq.conf")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/dnsmasq.conf",t)
if(luci.sys.call("cmp -s /tmp/dnsmasq.conf /etc/dnsmasq.conf")==1)then
e.writefile("/etc/dnsmasq.conf",t)
luci.sys.call("/etc/init.d/dnsmasq restart >/dev/null")
end
e.remove("/tmp/dnsmasq.conf")
end
end
end
if nixio.fs.access("/etc/config/network")then
s:tab("netwrokconf",translate("網路"),translate("本頁是設定/etc/config/network包含網路設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("netwrokconf",Value,"netwrokconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/network")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/network",t)
if(luci.sys.call("cmp -s /tmp/network /etc/config/network")==1)then
e.writefile("/etc/config/network",t)
luci.sys.call("/etc/init.d/network restart >/dev/null")
end
e.remove("/tmp/network")
end
end
end
if nixio.fs.access("/etc/config/wireless")then
s:tab("wirelessconf",translate("無線"), translate("本頁是/etc/config/wireless的設定檔內容，套用儲存後自動重新啟動生效."))

conf=s:taboption("wirelessconf",Value,"wirelessconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/wireless")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/etc/config/wireless.tmp",t)
if(luci.sys.call("cmp -s /etc/config/wireless.tmp /etc/config/wireless")==1)then
e.writefile("/etc/config/wireless",t)
luci.sys.call("wifi reload >/dev/null &")
end
e.remove("/tmp//tmp/wireless.tmp")
end
end
end

if nixio.fs.access("/etc/hosts")then
s:tab("hostsconf",translate("hosts"),translate("本頁是設定/etc/hosts的文件內容。套用儲存後自動重新啟動生效"))

conf=s:taboption("hostsconf",Value,"hostsconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/hosts")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/hosts.tmp",t)
if(luci.sys.call("cmp -s /tmp/hosts.tmp /etc/hosts")==1)then
e.writefile("/etc/hosts",t)
luci.sys.call("/etc/init.d/dnsmasq restart >/dev/null")
end
e.remove("/tmp/hosts.tmp")
end
end
end

if nixio.fs.access("/etc/config/arpbind")then
s:tab("arpbindconf",translate("ARP綁定"),translate("本頁是設定/etc/config/arpbind包含APR綁定MAC位址文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("arpbindconf",Value,"arpbindconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/arpbind")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/arpbind",t)
if(luci.sys.call("cmp -s /tmp/arpbind /etc/config/arpbind")==1)then
e.writefile("/etc/config/arpbind",t)
luci.sys.call("/etc/init.d/arpbind restart >/dev/null")
end
e.remove("/tmp/arpbind")
end
end
end

if nixio.fs.access("/etc/config/firewall")then
s:tab("firewallconf",translate("防火牆"),translate("本頁是設定/etc/config/firewall包含防火牆協定設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("firewallconf",Value,"firewallconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/firewall")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/firewall",t)
if(luci.sys.call("cmp -s /tmp/firewall /etc/config/firewall")==1)then
e.writefile("/etc/config/firewall",t)
luci.sys.call("/etc/init.d/firewall restart >/dev/null")
end
e.remove("/tmp/firewall")
end
end
end

if nixio.fs.access("/etc/config/mwan3")then
s:tab("mwan3conf",translate("負載平衡"),translate("本頁是設定/etc/config/mwan3包含負載平衡設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("mwan3conf",Value,"mwan3conf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/mwan3")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/mwan3",t)
if(luci.sys.call("cmp -s /tmp/mwan3 /etc/config/mwan3")==1)then
e.writefile("/etc/config/mwan3",t)
luci.sys.call("/etc/init.d/mwan3 restart >/dev/null")
end
e.remove("/tmp/mwan3")
end
end
end
if nixio.fs.access("/etc/config/dhcp")then
s:tab("dhcpconf",translate("DHCP"),translate("本頁是設定/etc/config/DHCP包含機器名稱等設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("dhcpconf",Value,"dhcpconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/dhcp")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/dhcp",t)
if(luci.sys.call("cmp -s /tmp/dhcp /etc/config/dhcp")==1)then
e.writefile("/etc/config/dhcp",t)
luci.sys.call("/etc/init.d/network restart >/dev/null")
end
e.remove("/tmp/dhcp")
end
end
end

if nixio.fs.access("/etc/config/ddns")then
s:tab("ddnsconf",translate("DDNS"),translate("本頁是設定/etc/config/ddns包含動態網域設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("ddnsconf",Value,"ddnsconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/ddns")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/ddns",t)
if(luci.sys.call("cmp -s /tmp/ddns /etc/config/ddns")==1)then
e.writefile("/etc/config/ddns",t)
luci.sys.call("/etc/init.d/ddns restart >/dev/null")
end
e.remove("/tmp/ddns")
end
end
end

if nixio.fs.access("/etc/config/parentcontrol")then
s:tab("parentcontrolconf",translate("家長控制"),translate("本頁是設定/etc/config/parentcontrol包含家長控制設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("parentcontrolconf",Value,"parentcontrolconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/parentcontrol")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/parentcontrol",t)
if(luci.sys.call("cmp -s /tmp/parentcontrol /etc/config/parentcontrol")==1)then
e.writefile("/etc/config/parentcontrol",t)
luci.sys.call("/etc/init.d/parentcontrol restart >/dev/null")
end
e.remove("/tmp/parentcontrol")
end
end
end

if nixio.fs.access("/etc/config/autotimeset")then
s:tab("autotimesetconf",translate("定時設定"),translate("本頁是設定/etc/config/autotimeset包含定時設定任務設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("autotimesetconf",Value,"autotimesetconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/autotimeset")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/autotimeset",t)
if(luci.sys.call("cmp -s /tmp/autotimeset /etc/config/autotimeset")==1)then
e.writefile("/etc/config/autotimeset",t)
luci.sys.call("/etc/init.d/autotimeset restart >/dev/null")
end
e.remove("/tmp/autotimeset")
end
end
end

if nixio.fs.access("/etc/config/wolplus")then
s:tab("wolplusconf",translate("網路喚醒"),translate("本頁是設定/etc/config/wolplus包含網路喚醒設定檔內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("wolplusconf",Value,"wolplusconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/wolplus")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/wolplus",t)
if(luci.sys.call("cmp -s /tmp/wolplus /etc/config/wolplus")==1)then
e.writefile("/etc/config/wolplus",t)
luci.sys.call("/etc/init.d/wolplus restart >/dev/null")
end
e.remove("/tmp/wolplus")
end
end
end

if nixio.fs.access("/etc/config/smartdns")then
s:tab("smartdnsconf",translate("SMARTDNS"),translate("本頁是設定/etc/config/smartdns包含smartdns設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("smartdnsconf",Value,"smartdnsconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/smartdns")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/smartdns",t)
if(luci.sys.call("cmp -s /tmp/smartdns /etc/config/smartdns")==1)then
e.writefile("/etc/config/smartdns",t)
luci.sys.call("/etc/init.d/smartdns restart >/dev/null")
end
e.remove("/tmp/smartdns")
end
end
end

if nixio.fs.access("/etc/config/bypass")then
s:tab("bypassconf",translate("BYPASS"),translate("本頁是設定/etc/config/bypass包含bypass設定文件內容。套用儲存後自動重新啟動生效"))
conf=s:taboption("bypassconf",Value,"bypassconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/bypass")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/bypass",t)
if(luci.sys.call("cmp -s /tmp/bypass /etc/config/bypass")==1)then
e.writefile("/etc/config/bypass",t)
luci.sys.call("/etc/init.d/bypass restart >/dev/null")
end
e.remove("/tmp/bypass")
end
end
end

if nixio.fs.access("/etc/config/openclash")then
s:tab("openclashconf",translate("openclash"),translate("本頁是設定/etc/config/openclash的文檔內容。 套用儲存後自動重新啟動生效"))
conf=s:taboption("openclashconf",Value,"openclashconf",nil,translate("開頭的數字符號（＃）或分號的每一行（;）被視為註解；刪除（;）啟用指定選項。 "))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/openclash")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/openclash",t)
if(luci.sys.call("cmp -s /tmp/openclash /etc/config/openclash")==1)then
e.writefile("/etc/config/openclash",t)
luci.sys.call("/etc/init.d/openclash restart >/dev/null")
end
e.remove("/tmp/openclash")
end
end
end

return m