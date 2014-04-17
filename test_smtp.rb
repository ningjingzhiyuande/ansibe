# 如何运行？ (操作的前提是，你所运行的这台机器位于邮件服务器的白名单中）
# 1. 修改其中对应的配置选项（ smtp地址啊，端口啊， domain啊（youku.com）啥的。
# 2. $ ruby test_smtp.rb
# 3. 回到邮箱查看～
require 'net/smtp'
Net::SMTP.start('10.30.2.7', 25,'cnpe.cc',
  'wenyang', 'Deepblue1987', :login)  do |stmp|
  stmp.send_message "lalalalalala", 'wenyang@cnpe.cc', ['tianmiao@cnpe.cc']
end
