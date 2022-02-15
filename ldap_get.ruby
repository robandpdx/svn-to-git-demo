#!/usr/bin/env ruby

# Requires 'ldapsearch' to be on the $PATH

require 'ostruct'

bindDN="\"cn=Anderson\\, Rob,ou=All Users,dc=ad,dc=sample,dc=com\""
url="ldap://ldap.sample.com"
baseDN="\"ou=All Users,dc=ad,dc=sample,dc=com\""

#puts "#{bindDN}"
#puts "ldapsearch -LLL -D #{bindDN} -x -W -H #{url} -b #{baseDN} \"(samaccountname=*)\" -S samaccountname cn mail"
result = `ldapsearch -LLL -D #{bindDN} -x -W -H #{url} -b #{baseDN} -E pr=100/noprompt "(samaccountname=*)" -S samaccountname cn mail`

records = result.split("\n\n").inject([]) do |lst, group|
# dn: uid=ssaasen,ou=people,dc=atlassian,dc=com
# uid: ssaasen
# cn: Stefan Saasen
# mail: devnull@atlassian.com
lst << group.split("\n").inject(OpenStruct.new) do |e, line|
key, *val = line.split(":")
e.send("#{key.strip}=", val.join(":").strip)
e
end
end

records.reject {|e| !e.mail }.sort{|a,b| a.sAMAccountName <=> b.sAMAccountName}.each do |rec|
#last, first = rec.cn.split(", ",2)
#name = rec.cn ? "#{first} #{last}" : rec.sAMAccountName
name = rec.cn ? rec.cn : rec.sAMAccountName
puts "#{rec.sAMAccountName.downcase} = #{name} <#{rec.mail.downcase}>"
end
